`timescale 1ns / 1ps

module instructionDecoder(reset, instruction, RS1is0,
                          WE, operand1Sel, operand2Sel, DinSel, nextPcSel, RDSel, aluCtrl);

    input [31 : 0] instruction;
    input RS1is0, reset;

    output reg WE, operand1Sel, DinSel, operand2Sel, nextPcSel;
    output reg [1 : 0] RDSel;
    output reg [5 : 0] aluCtrl;


    always@ (*) begin
    
        if(reset) begin
            WE              = 1'b1;
            operand1Sel     = 1'b1;                     
            operand2Sel     = 1'b1;                     
            DinSel          = 1'b1;                     
            nextPcSel       = 1'b1;                     
            RDSel           = 2'b10;
        end
        
        else if( instruction[31 : 26] == 6'b000000 ) begin  //R type triadic
            WE              = 1'b1;
            operand1Sel     = 1'b1;                     //RS1 - D1out
            operand2Sel     = 1'b1;                     //RS2 - D2out
            DinSel          = 1'b1;                     //Din -  ALU output
            nextPcSel       = 1'b1;                     //PC + 1
            RDSel           = 2'b10;                    //RD = IR[15:11]
            aluCtrl         = instruction[5 : 0];
        end

        else if( instruction[31] == 1'b1 ) begin        //R-I type triadic
            WE              = 1'b1;
            operand1Sel     = 1'b1;                     //RS1 - D1out
            operand2Sel     = 1'b0;                     //Signed exteded immediate
            DinSel          = 1'b1;                     //Din -  ALU output
            nextPcSel       = 1'b1;                     //PC + 1
            RDSel           = 2'b01;                    //RD = IR[20:16]
            aluCtrl         = instruction[31 : 26];
        end

        else begin                                         // R type diadic

            if(instruction[30 : 26] == 5'b10011) begin     //BEQZ
                
                if(RS1is0 == 1'b1) begin
                    nextPcSel       = 1'b0;                //PC : add4
                    aluCtrl         = 6'b010011;           //ADD4
                end

                else begin
                    nextPcSel       = 1'b1;                //PC+1
                end

                WE              = 1'b0;                    //No need to update any register
                operand1Sel     = 1'b0;                    //PC padded with 2 zero's
                operand2Sel     = 1'b0;                    //Signed offset
                DinSel          = 1'b1;                    //Does not matter since WE = 0
                RDSel           = 2'b10;                   //Does not matter since WE = 0

            end

            else if(instruction[30 : 26] == 5'b10100) begin //BNQZ
                
                if(RS1is0 == 1'b0) begin
                    nextPcSel       = 1'b0;                //PC : add4
                    aluCtrl         = 6'b010011;           //ADD4
                end

                else begin
                    nextPcSel       = 1'b1;                //PC+1
                end

                WE              = 1'b0;                    //No need to update any register
                operand1Sel     = 1'b0;                    //PC padded with 2 zero's
                operand2Sel     = 1'b0;                    //Signed offset
                DinSel          = 1'b1;                    //Does not matter since WE = 0
                RDSel           = 2'b10;                   //Does not matter since WE = 0

            end
            
            else if(instruction[30 : 26] == 5'b10101) begin //JR

                nextPcSel       = 1'b0;                    //PC : add4
                aluCtrl         = 6'b010100;               //ADD4

                WE              = 1'b0;                    //No need to update any register
                operand1Sel     = 1'b1;                    //RS1 - D1out
                operand2Sel     = 1'b0;                    //Signed offset
                DinSel          = 1'b1;                    //Does not matter since WE = 0
                RDSel           = 2'b10;                   //Does not matter since WE = 0

            end
            
            else if(instruction[30 : 26] == 5'b10110) begin //JALR

                nextPcSel       = 1'b0;                    //PC : add4
                aluCtrl         = 6'b010100;               //ADD4

                WE              = 1'b1;                    //address to be stored at R31
                operand1Sel     = 1'b1;                    //RS1 - D1out
                operand2Sel     = 1'b0;                    //Signed offset
                DinSel          = 1'b0;                    //Din -  extendedPC
                RDSel           = 2'b00;                   //RD = storeAt31

            end

            else begin

            end

        end

    end

endmodule
