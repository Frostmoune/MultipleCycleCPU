`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 10:45:10
// Design Name: 
// Module Name: testCPU
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


module testCPU;
    reg Reset;
    reg CLK;
    wire [31:0] curPC,nextPC;
    wire [31:0] ReadData1,ReadData2;
    wire [4:0] Rs,Rt;
    wire [31:0] Result,DataOut;
    wire [31:0] InsOut;
    wire [2:0] State;
    wire [4:0] WriteReg;
    wire [31:0] WriteData;
    
    initial begin
        CLK = 1;
        Reset = 0;
        #25;
        CLK = 0;
        #25;
        begin 
            Reset=1;
            CLK=1;
        end
        forever #25 CLK=~CLK;
    end

//module MultipleCycleCPU(CLK,Reset,curPC,nextPC,ReadData1,ReadData2,Rs,Rt,Result,DataOut);
    MultipleCycleCPU cpu(
        .CLK(CLK),
        .Reset(Reset),
        .curPC(curPC),
        .nextPC(nextPC),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .Rs(Rs),
        .Rt(Rt),
        .Result(Result),
        .DataOut(DataOut),
        .state(State)
    );
    
endmodule
