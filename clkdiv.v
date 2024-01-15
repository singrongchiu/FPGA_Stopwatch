`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 03:24:43 PM
// Design Name: 
// Module Name: 
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


module clkdiv(
    input clk,
    output mid_clk,
    output slow_clk
    ); 
    
    reg [9:0] COUNT1;
    reg [19:0] COUNT2; 
    
    assign mid_clk = COUNT1[9];
    assign slow_clk = (COUNT2 >= 1000000); 
        
        always @(posedge clk)
        begin 
            COUNT1 = COUNT1 + 1;
            COUNT2 = COUNT2 + 1;
        end
         
endmodule
