`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/20 15:30:26
// Design Name: 
// Module Name: InstructionMemory
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


module InstructionMemory(InsMemRW,IDataIn,IAddr,InsOut);
input InsMemRW;
input [31:0] IDataIn,IAddr;
output reg [31:0] InsOut;

reg [7:0] Memory[0:99];
initial begin
    $readmemb("E:/CPU/MultipleCycleCPU2/Instruction.txt",Memory);
end

always @(IAddr or InsMemRW) begin
    begin
        InsOut[31:24]=Memory[IAddr];
        InsOut[23:16]=Memory[IAddr+1];
        InsOut[15:8]=Memory[IAddr+2];
        InsOut[7:0]=Memory[IAddr+3];
     end
end

endmodule
