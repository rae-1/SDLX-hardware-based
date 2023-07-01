`timescale 1ns / 1ps

module suffix2zeros(PC30bit, PC32bit);

    input [29 : 0] PC30bit;
    output [31 : 0] PC32bit;

    assign PC32bit = { PC30bit, 2'b00 };

endmodule