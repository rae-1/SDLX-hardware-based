`timescale 1ns / 1ps

module muxRD(storeAt31, RI_typeTriadicRD, R_TypeTriadicRD, RDSel, RD);    //storeAt31 = 11111

    input [4 : 0] storeAt31, RI_typeTriadicRD, R_TypeTriadicRD;
    input [1 : 0] RDSel;
    
    output reg [4 : 0] RD;

    always@ (*) begin
        
        if(RDSel == 2'b00) begin
            RD = storeAt31;
        end

        else if(RDSel == 2'b01) begin
            RD = RI_typeTriadicRD;
        end

        else if(RDSel == 2'b10) begin
            RD = R_TypeTriadicRD;
        end

        else begin
            
        end

    end

endmodule
