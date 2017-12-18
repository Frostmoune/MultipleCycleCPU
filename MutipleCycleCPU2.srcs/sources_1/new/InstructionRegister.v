`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/11 21:12:09
// Design Name: 
// Module Name: InstructionRegister
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


module InstructionRegister(CLK,IRWre,InsIn,InsOut);
input CLK,IRWre;
input [31:0] InsIn;
output reg [31:0] InsOut;

reg [31:0] InsRegister;

initial begin
    InsRegister=0;
end

always @(negedge CLK) begin
    if(IRWre==1)InsRegister<=InsIn;
    else InsRegister<=InsRegister+0;
end

always @(posedge CLK) begin
    InsOut<=InsRegister;
end

endmodule
