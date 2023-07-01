`timescale 1ns / 1ps

module testBenchForTopModule();

    reg load, p1, p2, p3, p4, clk, reset;
    reg [1 : 0] display;
    reg [7 : 0] in;
    
    wire [15 : 0] resultSDLX;

    instructionRegister dut(load, p1, p2, p3, p4, clk, reset, in, display, resultSDLX);

    initial begin
        clk = 1;
        forever begin
            #1;
            clk = ~clk;
        end
    end

    initial begin
        
//      Initialization:
        load = 0;
        display = 0;
        p1 = 0;
        p2 = 0;
        p3 = 0;
        p4 = 0;
        reset = 1;
        #5;
        
        reset = 0;
        
        // BNQZ
        
        p1 = 1;
        in = 8'b010100_00;
        #3;       
        p1 = 0;
        #1;
        
        p2 = 1;
        in = 8'b001_00000; 
        #3;        
        p2 = 0;
        #1;
        
        p3 = 1;
        in = 8'b00000_000;   
        #3;        
        p3 = 0;
        #1;
        
        p4 = 1;
        in = 8'b00_100010;     
        #3;                
        p4 = 0;
        
        load = 1;
        #3;
        load=0;
        display = 0;
        #2;
        display = 2'b10;
        #2;
        
        
        // R-tri Left shift
        
        p1 = 1;
        in = 8'b000000_00;
        #3;       
        p1 = 0;
        #1;
        
        p2 = 1;
        in = 8'b010_00100; 
        #3;        
        p2 = 0;
        #1;
        
        p3 = 1;
        in = 8'b00001_000;   
        #3;        
        p3 = 0;
        #1;
        
        p4 = 1;
        in = 8'b00_000101;     
        #3;                
        p4 = 0;
        
        load = 1;
        #3;
        load=0;
        display = 0;
        #2;
        display = 2'b10;
        #2;
        
        
        // JALR
        
        p1 = 1;
        in = 8'b010110_00;
        #3;       
        p1 = 0;
        #1;
        
        p2 = 1;
        in = 8'b100_00000; 
        #3;        
        p2 = 0;
        #1;
        
        p3 = 1;
        in = 8'b00000_000;   
        #3;        
        p3 = 0;
        #1;
        
        p4 = 1;
        in = 8'b00_010100;     
        #3;                
        p4 = 0;
        
        load = 1;
        #3;
        load=0;
        display = 0;
        #2;
        display = 2'b10;
        #2;
        
        
        // RI add
        
        p1 = 1;
        in = 8'b100010_01;
        #3;       
        p1 = 0;
        #1;
        
        p2 = 1;
        in = 8'b011_10111; 
        #3;        
        p2 = 0;
        #1;
        
        p3 = 1;
        in = 8'b00010_000;   
        #3;        
        p3 = 0;
        #1;
        
        p4 = 1;
        in = 8'b00_100110;     
        #3;               
        p4 = 0;
        load = 1;
        #3;
        
        load=0;
        display = 0;
        #2;
        
        display = 2'b10;
        #2;
 
        $finish;

    end

endmodule
