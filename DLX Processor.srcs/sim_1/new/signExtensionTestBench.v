`timescale 1ns / 1ps

module signExtensionTestBench();

    reg [31 : 0] instruction;
    wire [31 : 0] extendedNumber;
    
    signExtension dut(instruction, extendedNumber);
    
    initial begin
        
        instruction = 32'b1000100000000000;
        #5;
        
        instruction = 31;
        #5;      
        
        $finish;
    end

endmodule
