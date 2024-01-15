`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 09:03:42 PM
// Design Name: 
// Module Name: rising_edge_detector
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module rising_edge_detector(
    input clk,
    input signal,
    input reset,
    output reg enable
    ); 
    
    reg [1:0] state;    
    reg [1:0] next_state;   
    
    // Combinational Logic
    always @(*) begin
    
        case (state)
        
            2'b00 : begin
                enable = 1'b0;
                if (signal == 0)
                    next_state = 2'b00;
                else
                    next_state = 2'b01;
            end
            
            2'b01 : begin
                enable = 1'b1;
                if (signal == 0)
                    next_state = 2'b10;
                else
                    next_state = 2'b01;
            end
            
            2'b10 : begin
                enable = 1'b1;
                if (signal == 0)
                    next_state = 2'b10;
                else 
                    next_state = 2'b11;
            end
           
            2'b11 : begin
                enable = 1'b0;
                if (signal == 0)
                    next_state = 2'b00;
                else 
                    next_state = 2'b11;
            end
            
            default : begin
                enable = 1'b0;
                next_state = 2'b00;
            end 
        endcase 
    end
    
    // Sequential
    always @(posedge clk) begin
        if (reset)
            state <= 2'b00;
        else 
            state <= next_state;
    end

endmodule
