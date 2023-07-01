`timescale 1ns / 1ps

module muxOperand2(D2out, signextendedImmediateOrOffset, operand2Sel, Operand2);

    input [31 : 0] D2out, signextendedImmediateOrOffset;
    input operand2Sel;
    
    output reg [31 : 0]Operand2;

    always@ (*) begin
        
        if(operand2Sel == 1'b1) begin
            Operand2 = D2out;
        end

        else begin
            Operand2 = signextendedImmediateOrOffset;
        end

    end

endmodule
