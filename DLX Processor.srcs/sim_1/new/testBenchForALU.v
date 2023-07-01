`timescale 1ns / 1ps

module testBenchForALU();
    reg [31 : 0] a;
    reg [31 : 0] b;
    reg [5 : 0] aluCtrl;
    reg reset;
    wire [31 : 0] result;
    wire overflowFlag;
    
    ALU_Unit dut(a, b, aluCtrl, reset, result, overflowFlag);
    
    initial begin
        
        reset = 1;
        #1
    
        reset = 0;
        a = 32'b10000000000000000000000000000000;
        b = 32'b10000000000000000000000000000000;
        aluCtrl = 6'b000000;
        #5;
        
        b = 20;
        a = 79;
        aluCtrl = 6'b000001;
        #5;
        
        a = 24;
        b = 08;
        aluCtrl = 6'b000010;
        #5;
        
        a = 11;
        b = 12;
        aluCtrl = 6'b001000;
        #5; 
        
        a = 32;
        b = 49;
        aluCtrl = 6'b001010;
        #5;
        
        a = 20;
        b = 20;
        aluCtrl = 6'b001010;
        #5;
        
        a = 90;
        b = 20;
        aluCtrl = 6'b001010;
        #5;
              
        $finish;
        
    end
  
endmodule
