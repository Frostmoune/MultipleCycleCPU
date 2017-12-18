`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 10:48:20
// Design Name: 
// Module Name: DataRegister
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


module DataRegister(CLK,InData,OutData);
input CLK;
input [31:0] InData;
output reg [31:0] OutData;

reg [31:0] DataRegister;

initial begin
    DataRegister=0;
end

always @(negedge CLK) begin
    DataRegister<=InData;
end

always @(posedge CLK) begin
    OutData<=DataRegister;
end

endmodule
