`timescale 1ns / 1ps

module secondary_output(aluOP, extendedPC, DinSel, output1, output2);

    input [31 : 0] aluOP;
    input [31 : 0] extendedPC;
    input DinSel;
    
    output reg [31:0] output1;
    output reg [31:0] output2;
    
    always @* begin
        
        output2 = extendedPC;
        output1 = aluOP;
        
        if(DinSel == 1'b0) begin
            output1 = extendedPC + 8;
        end
        
//        else if (DinSel == 1'b1) begin
//            output1 = aluOP;
//        end
        
        else begin
            
        end
    end
    
endmodule
