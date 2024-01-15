`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 04:21:19 PM
// Design Name: 
// Module Name: time_mux_state_machine
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


module time_mux_state_machine(
    input clk,
    input [6:0] in0,
    input [6:0] in1,
    input [6:0] in2,
    input [6:0] in3,
    output reg [3:0] an,
    output reg [6:0] sseg,
    output reg dp
    );
    
    reg [1:0] state;
    reg [1:0] next_state;
    always @ (*) begin
        case(state)
            2'b00: next_state = 2'b01;
            2'b01: next_state = 2'b10;
            2'b10: next_state = 2'b11;
            2'b11: next_state = 2'b00;
        endcase
    end  
    
    always @(*) begin
        case (state)
            2'b00 : sseg = in0;
            2'b01 : sseg = in1;
            2'b10 : sseg = in2;
            2'b11 : sseg = in3;
        endcase
        
        case (state)
            2'b00 : an = 4'b1110;
            2'b01 : an = 4'b1101;
            2'b10 : an = 4'b1011;
            2'b11 : an = 4'b0111;
        endcase
        
        case (state)
            2'b00 : dp = 1;
            2'b01 : dp = 1;
            2'b10 : dp = 0;
            2'b11 : dp = 1;
        endcase
    end
    
    always @(posedge clk) begin
        state <= next_state;
    end            
    
endmodule
