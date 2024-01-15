`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 05:04:37 PM
// Design Name: 
// Module Name: binary_to_bcd
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


module binary_to_bcd(
    input [13:0] binarynum,
    output [3:0] n3,
    output [3:0] n2,
    output [3:0] n1,
    output [3:0] n0
    );

reg [3:0] i3, i2, i1, i0;
assign n3 = i3;
assign n2 = i2;
assign n1 = i1;
assign n0 = i0;

always @(binarynum)
begin
    i3 = (binarynum / 1000);
    i2 = (binarynum - (i3 * 1000)) / 100;
    i1 = (binarynum - (i3 * 1000) - (i2 * 100)) / 10;
    i0 = (binarynum - (i3 * 1000) - (i2 * 100) - (i1 * 10));
end

endmodule
