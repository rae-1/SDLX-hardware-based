`timescale 1ns / 1ps

module testBenchForRegfile();

    reg WE, clk, reset;
    reg [4 : 0] RD, RS1, RS2;
    reg [31 : 0] Din;
    wire [31 : 0] D1out, D2out;
    
    regFile32x32 dut(.WE(WE), .clk(clk), .reset(reset), .RD(RD), .Din(Din), .RS1(RS1), .RS2(RS2), .D1out(D1out), .D2out(D2out));
    
    initial begin
        clk = 1;
        forever begin
            #5;
            clk = ~clk;
        end
    end
    
    initial begin
    
        reset = 1'b1;               //values are initialized in the regfile
        #5;
        
        reset = 0;
        #5;
    
        WE = 1'b1;
        Din = 32'b01010;            //updated value that will be stored in destination register(RD)
        #5;
        
        RS1 = 5'b01;                //D1out = regfile[RS1]
        RS2 = 5'b010;               //D2out = regfile[RS2]
        #5;
        
        RS1 = 5'b011;
        RS2 = 5'b0111;
        #5;
        
        RD = 5'b01;                 //the value contained in Din is stored in regfile[RD]
        #5;
        
        RS1 = 5'b01;                //updated value is shown
        RS2 = 5'b01001;
        #5;
        
        $finish;
        
    end

endmodule
