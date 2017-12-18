`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/11 21:49:08
// Design Name: 
// Module Name: MultipleCycleCPU
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


module MultipleCycleCPU(CLK,Reset,curPC,nextPC,ReadData1,ReadData2,Rs,Rt,Result,DataOut,state);
input CLK,Reset;
output [31:0] curPC,nextPC;
output [31:0] ReadData1,ReadData2;
output [4:0] Rs,Rt;
output [31:0] Result,DataOut;
output [2:0] state;

wire PCWre,InsMemRW,IRWre,Sign,Zero,ALUSrcA,ALUSrcB,DBDataSrc,RegWre,RD,WR,IsHalt,ExtSel,WrRegDSrc;
wire [1:0] RegDst,PCSrc;
wire [2:0] ALUOp,State;
wire [4:0] TempReg,TempZero,WriteReg;
wire [31:0] readdata1,readdata2,result,dataout,NextPC,IAddr,IDataIn,InsIn,InsOut,WriteData,PC4,DBDataIn,DBDataOut,Data1,Data2,ExtOut,ExtendSa,InA,InB,JumpPC,Skip_PC,DAddr;
assign TempReg=5'b11111;
assign TempZero=5'b00000;
assign IDataIn=0;
PC pc(CLK,Reset,NextPC,PCWre,IAddr);
//module PC(CLK,Reset,NextPC,PCWre,IAddr);
InstructionMemory Ins(InsMemRW,IDataIn,IAddr,InsIn);
//module InstructionMemory(InsMemRW,IDataIn,IAddr,InsOut);
InstructionRegister InsReg(CLK,IRWre,InsIn,InsOut);
//module InstructionRegister(CLK,IRWre,InsIn,InsOut);
ControlUnit Con(CLK,Reset,InsOut[31:26],Sign,Zero,PCWre,ALUSrcA,ALUSrcB,DBDataSrc,RegWre,InsMemRW,RD,WR,IsHalt,RegDst,ExtSel,PCSrc,ALUOp,IRWre,WrRegDSrc,State);
//module ControlUnit(CLK,Reset,Op,Sign,Zero,PCWre,ALUSrcA,ALUSrcB,DBDataSrc,RegWre,InsMemRW,RD,WR,RegDst,IsHalt,ExtSel,PCSrc,ALUOp,IRWre,WrRegDSrc,State);
Select2_to_5 WriteRegSelect(RegDst,TempReg,InsOut[20:16],InsOut[15:11],TempZero,WriteReg);
//module Select2_to_5(Selector,InA,InB,InC,InD,Out);
PC_4 pc_4(IAddr,PC4);
//module PC_4(IAddr,PC_4);
Select32 WriteDataSelect(WrRegDSrc,PC4,DBDataOut,WriteData);
//module Select32(Select,DataA,DataB,Data);
RegisterFile Register(CLK,Reset,RegWre,InsOut[25:21],InsOut[20:16],WriteReg,WriteData,Data1,Data2);
//module RegisterFile(CLK,Reset,RegWre,ReadReg1,ReadReg2,WriteReg,WriteData,ReadData1,ReadData2);
SignZeroExtend ext(InsOut[15:0],ExtSel,Sign,ExtOut);
//module SignZeroExtend(Immediate,ExtSel,Sign,ExtOut);
DataRegister ADR(CLK,Data1,readdata1);
//module DateRegister(CLK,InData,OutData);
DataRegister BDR(CLK,Data2,readdata2);
Extend_Sa SaExtend(InsOut[10:6],ExtendSa);
//module Extend_Sa(Sa,ExtendSa);
Select32 ALUA(ALUSrcA,readdata1,ExtendSa,InA);
Select32 ALUB(ALUSrcB,readdata2,ExtOut,InB);
ALU alu(InA,InB,ALUOp,result,Zero,Sign);
//module ALU(InA,InB,ALUOp,Result,Zero,Sign);
SkipPC Skip(PC4,ExtOut,Skip_PC);
//module SkipPC(PC_4,ExtOut,SkipPC);
JumpPC Jump(IAddr,InsOut[25:0],JumpPC);
//module JumpPC(PC,InAddress,Out);
Select2_to_32 getNextPC(Reset,IsHalt,PCSrc,IAddr,PC4,Skip_PC,Data1,JumpPC,NextPC);
//module Select2_to_32(Reset,IsHalt,Selector,IAddr,InA,InB,InC,InD,Out);
DataRegister ALUOutDR(CLK,Result,DAddr);
DataMemory Data(CLK,Reset,RD,WR,DAddr,readdata2,dataout);
//module DataMemory(CLK,Reset,RD,WR,DAddr,DataIn,DataOut);
Select32 DBDataSelect(DBDataSrc,result,dataout,DBDataIn);
DataRegister DBDR(CLK,DBDataIn,DBDataOut);

assign curPC=IAddr;
assign nextPC=NextPC;
assign ReadData1=Data1;
assign ReadData2=Data2;
assign Rs=InsOut[25:21];
assign Rt=InsOut[20:16];
assign Result=result;
assign DataOut=dataout;
assign state=State;
endmodule