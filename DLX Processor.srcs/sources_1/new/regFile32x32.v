`timescale 1ns / 1ps

module regFile32x32(WE, clk, reset, RD, Din, Din_Sel, RS1, RS2, D1out, D2out);

    input WE, clk, reset, Din_Sel;
    input [4 : 0] RD;
    input [31 : 0] Din;
    input [4 : 0] RS1, RS2;
    output [31 : 0] D1out, D2out;
    
    reg [31 : 0] regfile [31 : 0];

    integer i;

    assign D1out = regfile[RS1];
    assign D2out = regfile[RS2];

    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            regfile[i] = i;
        end
    end

    always@ (posedge clk)begin

        if(reset) begin
            for(i = 0; i < 31; i = i + 1) begin
//                regfile[i] <= i;
                regfile[i] = i;
            end
        end

        else if(WE == 1'b1) begin
//            regfile[RD] <= Din;
            if (RD==31 && Din_Sel==0) begin
                regfile[RD] = Din + 4;
            end
            
            else begin
                regfile[RD] = Din;
            end
          
        end

        else begin
            
        end

    end

endmodule