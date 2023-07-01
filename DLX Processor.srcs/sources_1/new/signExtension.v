`timescale 1ns / 1ps

module signExtension(instruction, extendedNumber);

    input [15 : 0] instruction;
    output [31 : 0] extendedNumber;

    assign extendedNumber = { { 16{instruction[15]} } , instruction[15 : 0] };

endmodule