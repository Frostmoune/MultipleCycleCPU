`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/20 15:25:15
// Design Name: 
// Module Name: PC
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


module PC(CLK,Reset,NextPC,PCWre,IAddr);
input CLK,Reset;
input [31:0] NextPC;
input PCWre;
output reg [31:0] IAddr;

reg flag;

initial begin
    IAddr=0;
    flag=0;
end

always @(posedge CLK or negedge Reset)
begin
    if(Reset==0)begin
        IAddr<=0;
    end
    else if(PCWre==1||NextPC==0)begin
        IAddr<=NextPC;
    end
end
endmodule
