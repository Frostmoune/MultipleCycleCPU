`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 09:24:57
// Design Name: 
// Module Name: PC_4
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


module PC_4(IAddr,PC_4);
input [31:0] IAddr;
output [31:0] PC_4;
assign PC_4=IAddr+4;
endmodule
