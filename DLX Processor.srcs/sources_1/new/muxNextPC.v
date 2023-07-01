`timescale 1ns / 1ps

module muxNextPC(incrementedPC, ALUoutput, selNextPC, PC);

    input [29 : 0] incrementedPC;
    input [29 : 0] ALUoutput;
    input selNextPC;
    
    output reg [29 : 0] PC;    

    always@(*) begin
        
        if(selNextPC == 1'b1) begin
            PC = incrementedPC;
        end
        
        else begin
            PC = ALUoutput;
        end
        
    end

endmodule
