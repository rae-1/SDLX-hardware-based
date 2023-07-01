`timescale 1ns / 1ps

module instructionRegister(load, p1, p2, p3, p4, clk, reset, in, display,
                            resultSDLX);

    input load, p1, p2, p3, p4, clk, reset;
    input [1 : 0] display;                  
    input [7 : 0] in;
    
    output reg [15 : 0]resultSDLX;

    reg [31 : 0] inst;
    reg [31 : 0] preInst;
    reg [31 : 0] result;
    reg [31 : 0] regPcOutfromRegister;

    wire [31 : 0] inALU1, inALU2;
    wire [31 : 0] DinAluToRegfile;
    wire [31 : 0] actualDin;
    wire [31 : 0] primary_output;
    wire [31 : 0] second_output;
    wire [29 : 0] PcOutfromRegister;
    
    always@(posedge clk) begin
    
        resultSDLX = primary_output[15 : 0];
        
        if(reset) begin
            preInst = 32'b0;
        end
        
        else if(p1) begin
            preInst[31 : 24] = in;
        end

        else if(p2) begin
            preInst[23 : 16] = in;
        end
    
        else if(p3) begin
            preInst[15 : 8] = in;
        end
    
        else if(p4) begin
            preInst[7 : 0] = in;
        end
        
        else if(load) begin
            inst = preInst;
        end
        
        else if (display == 2'b01) begin
            resultSDLX = primary_output[31 : 16];
        end
        
        else if (display == 2'b10) begin
            resultSDLX = second_output[15 : 0];
        end
        
        else if (display == 2'b11) begin
            resultSDLX = second_output[31 : 16];
        end
        
        else begin
        
        end
        
    end


    wire [31:0] D1_out, D2_out;
    wire RS1is0;
    comparingRS1 RS1isZero(
                            .reset(reset),
                            .D1out(D1_out),

                            .RS1is0(RS1is0)
                          );


    wire WE, operand1Sel, operand2Sel, DinSel, nextPcSel;
    wire [1 : 0] RDSel;
    wire [5 : 0]aluCtrl;
    instructionDecoder instructionType( 
                                        .reset(reset),
                                        .instruction(inst),
                                        .RS1is0(RS1is0),
                                        
                                        .WE(WE),
                                        .operand1Sel(operand1Sel),
                                        .operand2Sel(operand2Sel),
                                        .DinSel(DinSel),
                                        .nextPcSel(nextPcSel),
                                        .RDSel(RDSel),
                                        .aluCtrl(aluCtrl)
                                      );

    wire [4 : 0] RD;
    muxRD RDselection(  
                        .storeAt31(31),
                        .RI_typeTriadicRD(inst[20 : 16]),
                        .R_TypeTriadicRD(inst[15 : 11]),
                        .RDSel(RDSel),

                        .RD(RD)
                     );


    wire [29 : 0] PcPlus1;
    wire [31 : 0] PcPlus1PaddedWithZeros;

    suffix2zeros paddedWith2Zeros1(
                                    .PC30bit(PcPlus1),
                                    .PC32bit(PcPlus1PaddedWithZeros)
                                  );

    muxDinSel DinSelect(   
                        .aluOP(DinAluToRegfile),
                        .extendedPC(PcPlus1PaddedWithZeros),
                        .DinSel(DinSel),

                        .Din(actualDin)
//                        .output2(secondary_output)
                    );
    
    wire [31 : 0]pcToOperand1;
    secondary_output outputs(
                              .aluOP(DinAluToRegfile),
                              .extendedPC(pcToOperand1),
                              .DinSel(DinSel),
                              
                              .output1(primary_output),
                              .output2(second_output)
                            );
    
    regFile32x32 regfile(
                         .WE(WE),
                         .clk(clk),       
                         .reset(reset),
                         .RD(RD),
                         .Din(actualDin),
                         .Din_Sel(DinSel),
                         .RS1(inst[25 : 21]),
                         .RS2(inst[20 : 16]),

                         .D1out(D1_out),
                         .D2out(D2_out)
                         );
                         
    wire [29 : 0] nextPcFromMux;
    pcRegister pcReg(   
                        .load(load),
                        // .clock(clk),
                        .reset(reset),
                        .PCin(nextPcFromMux),

                        .PCout(PcOutfromRegister)
                    );

    incrementPC PcPlusOne(
                            .PCin(PcOutfromRegister),

                            .nextPC(PcPlus1)
                         );


    muxNextPC nextPcMux(
                        .incrementedPC(PcPlus1),
                        .ALUoutput(DinAluToRegfile[31 : 2]),
                        .selNextPC(nextPcSel),

                        .PC(nextPcFromMux)
                       );

    suffix2zeros paddedWith2Zeros2(
                                    .PC30bit(PcOutfromRegister),
                                    .PC32bit(pcToOperand1)
                                 );

    muxOperand1 RS1_Or_nextPC(  
                                .D1out(D1_out),
                                .PC(pcToOperand1),
                                .operand1Sel(operand1Sel),

                                .Operand1(inALU1)
                             );

    wire [31 : 0] extendedNumber;
    signExtension extededBit(
                                .instruction(inst[15 : 0]),

                                .extendedNumber(extendedNumber)
                            );

    muxOperand2 RS2_Or_signedConstant(  
                                        .D2out(D2_out), 
                                        .signextendedImmediateOrOffset(extendedNumber), 
                                        .operand2Sel(operand2Sel),

                                        .Operand2(inALU2)
                                     );

    ALU_Unit alu(
                 .a(inALU1),
                 .b(inALU2),
                 .aluCtrl(aluCtrl),
                 .reset(reset),

                 .result(DinAluToRegfile)
                );

endmodule