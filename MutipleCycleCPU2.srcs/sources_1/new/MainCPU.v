`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/17 19:54:29
// Design Name: 
// Module Name: MainCPU
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


module MainCPU(CLK,Reset,Key,Selector,a_to_g,an,dp);
input CLK,Reset,Key;
input [2:0] Selector;
output [6:0] a_to_g;
output [3:0] an;
output dp;

wire CLK190,CLK3,Led;
wire [31:0] ReadData1, ReadData2, curPC, Result,InsOut,nextPC;
wire [4:0] Rs,Rt;
wire [31:0] DataOut;
wire [2:0] State;
wire [15:0] Out;

CLOCK myclock(.CLK(CLK),.Reset(Reset),.CLK190(CLK190),.CLK3(CLK3));
KeyOn mykey(.CLK(CLK190),.Key(Key),.Led(Led));
MultipleCycleCPU myCPU(.CLK(Led),.Reset(Reset),.curPC(curPC),.nextPC(nextPC), .ReadData1(ReadData1),.ReadData2(ReadData2),.Rs(Rs),.Rt(Rt),.Result(Result),.DataOut(DataOut),.state(State));
//module MultipleCycleCPU(CLK,Reset,curPC,nextPC,ReadData1,ReadData2,Rs,Rt,Result,DataOut,state);
Shift myshift(.CLK(CLK3),.Reset(Reset),.Selector(Selector),.PC(curPC[7:0]),.NextPC(nextPC[7:0]),.Rs(Rs),.Rt(Rt),.ReadData1(ReadData1[7:0]),.ReadData2(ReadData2[7:0]),.Result(Result[7:0]),.DataOut(DataOut[7:0]),.State(State),.Out(Out));
MUX mymux(.CLK190(CLK190),.Reset(Reset),.Out(Out),.a_to_g(a_to_g),.an(an),.dp(dp));

endmodule
