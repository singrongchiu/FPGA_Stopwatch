`timescale 1ns / 1ps
module count_up(
    input [7:0] first_count,
    input clk,
    input enable,
    input reset,
    input up_down,
    output wire [13:0] count_out
    );

    reg [13:0] totalcount;
    assign count_out = totalcount;

    always @(posedge clk) 
        begin
            if (reset)
                totalcount = first_count * 100;
            else if (totalcount >= 0 && totalcount < 9999 && enable && up_down && !reset)
                totalcount = totalcount + 1; 
            else if (totalcount > 0 && totalcount <= 9999 && enable && !up_down && !reset)
                totalcount = totalcount - 1; 
        end
endmodule