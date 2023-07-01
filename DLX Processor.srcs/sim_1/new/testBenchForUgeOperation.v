`timescale 1ns / 1ps
module testBenchForUgeOperation();

    reg [31 : 0]a;
    reg [31 : 0]b;
    wire [31 : 0]result;
    
    ugeOperation dut(a, b, result);
    
    initial begin
    
        a = 2;
        b = 3;
        #5;
        
        a = 1;
        b = 0;
        #5;
        
        a = 12;
        b = 11;
        #5;
        
        a = 90;
        b = 90;
        #5;
        
        a = 34;
        b = 50;
        #5;
        
        $finish;
    
    end
    
endmodule
