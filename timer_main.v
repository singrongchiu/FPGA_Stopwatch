`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 03:25:48 PM
// Design Name: 
// Module Name: timer_main
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


module timer_main(
    input clk,
    input reset,
    input startstop,
    input [7:0] sw,
    input [1:0] selector,
    output [3:0] an,
    output dp,
    output [6:0] sseg 
    );
    
    wire [6:0] in0, in1, in2, in3;
    wire mid_clk, slow_clk;
    reg [1:0] state;    
    reg [1:0] next_state;
    reg [7:0] inputnum; 
    reg [7:0] placeholdernum;
    wire [13:0] outputdigits;
    wire [3:0] n3, n2, n1, n0;
    wire enable;
    reg up_down;
    
    // Instantiation of selector
    always @ (selector) begin
        case (selector)
            2'b00 : next_state = 2'b00;
            2'b01 : next_state = 2'b01;
            2'b10 : next_state = 2'b10;
            2'b11 : next_state = 2'b11;
        endcase
    end 
    
    // Module instantiation of the clock divider
    clkdiv c5 (.clk(clk), .mid_clk(mid_clk), .slow_clk(slow_clk));
    
    // Module instantiation of the counter
    count_up m1 (.first_count(inputnum), .clk(slow_clk), .enable(enable), .reset(reset), .up_down(up_down), .count_out(outputdigits));
    rising_edge_detector m2 (.clk(mid_clk), .signal(startstop), .reset(reset), .enable(enable));
    
    always @ (reset) begin
        case (state)
            2'b00 : begin
                inputnum = 0;
            end
            
            2'b01 : begin
                placeholdernum = sw;
                if (sw[7:4] > 9)
                    placeholdernum[7:4] = 0;
                if (sw[3:0] > 9)
                    placeholdernum[3:0] = 0;
                inputnum = placeholdernum[7:4] * 10 + placeholdernum[3:0];
            end
            
            2'b10 : begin
                inputnum = 99;
            end
            
            2'b11 : begin
                placeholdernum = sw;
                if (sw[7:4] > 9)
                    placeholdernum[7:4] = 0;
                if (sw[3:0] > 9)
                    placeholdernum[3:0] = 0;
                inputnum = placeholdernum[7:4] * 10 + placeholdernum[3:0];
            end
        endcase
    end
    
    always @(state) begin
        case (state)
            2'b00 : up_down = 1;
            2'b01 : up_down = 1;
            2'b10 : up_down = 0;
            2'b11 : up_down = 0;
        endcase 
    end
    
    // Sequential
    always @(posedge clk) begin
        state <= next_state;
    end
    
    // Module instantiation of binary_to_bcd module
    binary_to_bcd b1 (.binarynum(outputdigits), .n3(n3), .n2(n2), .n1(n1), .n0(n0));
    
    // Module instantiation of hexto7segment decoder
    hexto7segment c1 (.x(n0), .r(in0));
    hexto7segment c2 (.x(n1), .r(in1));
    hexto7segment c3 (.x(n2), .r(in2));
    hexto7segment c4 (.x(n3), .r(in3));
    
    // Module instantiation of the multiplexer
    time_mux_state_machine c6 (
        .clk(mid_clk),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .an(an),
        .sseg(sseg),
        .dp(dp)
    ); 
    
endmodule
