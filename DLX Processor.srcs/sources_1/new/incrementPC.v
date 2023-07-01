`timescale 1ns / 1ps

module incrementPC(PCin, nextPC);

    input [29 : 0] PCin;
    output reg [29 : 0] nextPC;

    always@(*) begin
        nextPC = PCin + 1;
    end

endmodule
