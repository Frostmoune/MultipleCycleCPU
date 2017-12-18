`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 21:23:09
// Design Name: 
// Module Name: SkipPC
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


module SkipPC(PC_4,ExtOut,SkipPC);
input [31:0] PC_4,ExtOut;
output [31:0] SkipPC;

assign SkipPC=PC_4+(ExtOut<<2);
endmodule
