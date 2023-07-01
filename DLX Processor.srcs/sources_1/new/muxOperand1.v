`timescale 1ns / 1ps

module muxOperand1(D1out, PC, operand1Sel, Operand1);

    input [31 : 0] D1out;
    input [31 : 0] PC;
    input operand1Sel;
    
    output reg [31 : 0]Operand1;

    always@ (*) begin

        if(operand1Sel == 1'b1) begin
            Operand1 = D1out;
        end

        else begin
            Operand1 = PC;
        end

    end

endmodule
