`timescale 1ns / 1ps

module ALU_Unit(
    input [31 : 0] a,
    input [31 : 0] b,
    input [5 : 0] aluCtrl,
    input reset,
    output reg [31 : 0]result
    );
    
    wire signed [31:0] signed_num1, signed_num2;

    integer i;

    assign signed_num1 = a;
    assign signed_num2 = b;  
    
    always @(*) begin
        if(reset) begin
            result = 32'b0;
        end
        
        else begin
            case(aluCtrl[4 : 0])
    
                5'b00000 : begin
                                result = a + b;
                            end
                5'b00001 : begin
                                result = a - b;
                            end
                5'b00010 : begin
                                result = a & b;
                            end
                5'b00011 : begin
                                result = a | b;
                            end
                5'b00100 : begin
                                result = a ^ b;
                            end
                5'b00101 : begin
                                // SLL
                                result = a << b;
                            end
                5'b00110 : begin
                                // SRA
                                result = a >> b;
                            end
                5'b00111 : begin
                                // SRL
                                result = a >>> b;
                            end
                5'b01000 : begin 
                                //result = {a[31-b : 0], a[31:31-b]};
                                // ROL
                                result = (a<<b) | (a>>(32-b));
                            end
                5'b01001 : begin
                                //result = {a[0], a[31 : 1]};
                                // ROR
                                result = (a>>b) | (a<<(32-b));
                            end
                5'b01010 : begin
                                // result = ugeOut;
                                result = (a >= b)? 32'b1:32'b0;
                            end
                5'b01011 : begin
                                // result = uleOut;
                                result = (a <= b)? 32'b1:32'b0;
                            end
                5'b01100 : begin
                                // result = ugtOut;
                                result =  (a > b)? 32'b1:32'b0;
                            end
                5'b01101 : begin
                                // result = ultOut;
                                result = (a < b)? 32'b1:32'b0;
                            end
                5'b01110 : begin
                                // result = sgeOut;
                                result = (signed_num1 >= signed_num2)? 32'b1:32'b0;
                            end
                5'b01111 : begin
                                // result = sleOut;
                                result = (signed_num1 <= signed_num2)? 32'b1:32'b0;
                            end
                5'b10000 : begin
                                // result = sgtOut;
                                result = (signed_num1 > signed_num2)? 32'b1:32'b0;
                            end
                5'b10001 : begin
                                // result = sltOut;
                                result = (signed_num1 < signed_num2)? 32'b1:32'b0;
                            end
                5'b10010 : begin                       
                                //LHI
                                result = {b[15 : 0], a[15 : 0]};
                            end 
                5'b10011 : begin                       
                                //ADD4
                                result = a + {b[29 : 0], 2'b00};
                            end
                5'b10100 : begin
                                // JR and JALR
                                result = {a[31:2] + b[29 : 0], 2'b00};
                            end
  
                default : begin
                            result = a + b;
                          end            
            
            endcase
        end
    
    end
            
endmodule