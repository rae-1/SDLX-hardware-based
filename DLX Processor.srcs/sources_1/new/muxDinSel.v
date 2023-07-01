`timescale 1ns / 1ps

module muxDinSel(aluOP, extendedPC, DinSel, Din);

    input [31 : 0] aluOP;
    input [31 : 0] extendedPC;
    input DinSel;
    
    output reg [31 : 0]Din;
//    output reg [31 : 0]output2;

    always@ (*) begin

        if(DinSel == 1'b1) begin
            Din = aluOP;
//            output2 = extendedPC;
//            output2 = extendedPC - 4;
        end

        else begin
            Din = extendedPC;
//            output2 = aluOP;
        end

    end

endmodule
