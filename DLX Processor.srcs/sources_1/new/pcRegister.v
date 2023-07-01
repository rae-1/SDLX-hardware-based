`timescale 1ns / 1ps

module pcRegister(load, reset, PCin, PCout);

    input load, reset;
    input [29 : 0] PCin;
    
    output reg [29 : 0] PCout;
    
    // always@(*) begin
    
        // if(reset ==  1'b1) begin
        //     PCout = 30'b0;
        // end
        
        // else if(negedge load) begin
        //     PCout = PCin;
        // end

        // else begin

        // end


    
    // end

    reg loadOFF;

    always@(*) begin
    
        if(reset ==  1'b1) begin
            PCout = 30'b0;
            loadOFF = 1'b0;
        end
        
        else if(load) begin
        
            if(loadOFF) begin
                PCout = PCin;
                loadOFF = 1'b0;
            end
            
            else begin
            
            end
            
        end
        
        else begin
            loadOFF = 1'b1;
        end
    
    end
    

endmodule

// `timescale 1ns / 1ps

// module pcRegister(load, clock, reset, PCin, PCout);

//     input load, clock, reset;
//     input [29 : 0] PCin;
    
//     output reg [29 : 0] PCout;
    
//     reg loadOFF;
    
//     always@(posedge clock) begin
    
//         if(reset ==  1'b1) begin
//             PCout = 30'b0;
//             loadOFF = 1'b0;
//         end
        
//         else if(load) begin
        
//             if(loadOFF) begin
//                 PCout = PCin;
//                 loadOFF = 1'b0;
//             end
            
//             else begin
            
//             end
            
//         end
        
//         else begin
//             loadOFF = 1'b1;
//         end
    
//     end

// endmodule

