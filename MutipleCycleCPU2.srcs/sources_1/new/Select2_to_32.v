`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/11 21:27:45
// Design Name: 
// Module Name: Select2_to_32
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


module Select2_to_32(Reset,IsHalt,Selector,IAddr,InA,InB,InC,InD,Out);
input Reset,IsHalt;
input [1:0] Selector;
input [31:0] IAddr,InA,InB,InC,InD;
output [31:0] Out;

assign Out=(IsHalt==1)?IAddr:(Reset==0||Selector==2'b00)?InA:(Selector==2'b01)?InB:(Selector==2'b10)?InC:(Selector==2'b11)?InD:0;
endmodule
