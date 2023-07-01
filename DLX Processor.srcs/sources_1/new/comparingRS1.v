`timescale 1ns / 1ps

module comparingRS1(reset, D1out, RS1is0);

    input reset;
    input [31 : 0] D1out;
    output reg RS1is0;
    
    always@ (*) begin
         
        if(reset) begin
            RS1is0 = 1'b1;
        end
        
        else if(D1out == 32'b0) begin
            RS1is0 = 1'b1;
        end

        else begin
            RS1is0 = 1'b0;
        end

    end

endmodule
