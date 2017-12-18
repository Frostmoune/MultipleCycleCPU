`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/20 15:33:49
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(CLK,Reset,Op,Sign,Zero,PCWre,ALUSrcA,ALUSrcB,DBDataSrc,RegWre,InsMemRW,RD,WR,IsHalt,RegDst,ExtSel,PCSrc,ALUOp,IRWre,WrRegDSrc,State);
input CLK,Reset;
input [5:0] Op;
input Sign,Zero;
output reg PCWre,ALUSrcA,ALUSrcB,DBDataSrc,RegWre,InsMemRW,RD,WR,IsHalt;
output reg [1:0] RegDst;
output reg ExtSel;
output reg [1:0] PCSrc;
output reg [2:0] ALUOp;
output reg IRWre,WrRegDSrc;
output reg [2:0] State;

initial begin
    State=3'b000;
    PCWre=1;
    ALUSrcA=0;
    ALUSrcB=0;
    DBDataSrc=0;
    RegWre=1;
    InsMemRW=0;
    RD=1;
    WR=1;
    RegDst=2'b10;
    ExtSel=0;
    PCSrc=2'b00;
    ALUOp=3'b000;
    IRWre=0;
    WrRegDSrc=1;
    IsHalt=0;
end

always @(posedge CLK or negedge Reset) begin
    if(Reset==0) begin
        State<=3'b000;
        IsHalt<=0;
    end
    else begin
        if(State==3'b000)State<=3'b001;
        else if(State==3'b001) begin
            if((Op==6'b111000)||(Op==6'b111001)||(Op==6'b111010)||(Op==6'b111111))State<=3'b000;
            else State<=3'b010;
        end
        else if(State==3'b010)begin
            if((Op==6'b110100)||(Op==6'b110101)||(Op==6'b110110))State<=3'b000;
            else if((Op==6'b110000)||(Op==6'b110001))State<=3'b100;
            else State<=3'b011;
        end
        else if(State==3'b100)begin
            if(Op==6'b110000)State<=3'b000;
            else State<=3'b011;
        end
        else State<=3'b000;
    end
end

always @(Reset or State or Zero or Sign or Op)begin
    if(State==3'b010&&Op==6'b011000)ALUSrcA=1;
    else ALUSrcA=0;
    
    if(State==3'b010)begin
        if((Op==6'b000010)||(Op==6'b010010)||(Op==6'b100111)||(Op==6'b110000)||(Op==6'b110001))ALUSrcB=1;
        else ALUSrcB=0;
    end
    else ALUSrcB=0;
    
    if(State==3'b100&&Op==6'b110001)DBDataSrc=1;
    else DBDataSrc=0;
    
    if(State==3'b100&&Op==6'b110001)RD=0;
    else RD=1;
    
    if(State==3'b100&&Op==6'b110000)WR=0;
    else WR=1;
    
    if(State==3'b010)begin
        if((Op==6'b000010)||(Op==6'b110000)||(Op==6'b110001)||(Op==6'b110100)||(Op==6'b110101)||(Op==6'b110110))ExtSel=1;
        else ExtSel=0;
    end
    else ExtSel=0;
    
    if(State==3'b001&&Op==6'b111010)RegDst=2'b00;
    else if(State==3'b011)begin
        if((Op==6'b000010)||(Op==6'b010010)||(Op==6'b100111)||(Op==6'b110001))RegDst=2'b01;
        else RegDst=2'b10;
    end
    else RegDst=2'b10;
         
    if(State==3'b001&&Op==6'b111010)WrRegDSrc=0;
    else WrRegDSrc=1;
    
    if(State==3'b011)RegWre=1;
    else if(State==3'b001&&Op==6'b111010)RegWre=1;
    else RegWre=0;
    
    if(State==3'b000)IRWre=1;
    else IRWre=0;
    
    if(State==3'b001)begin
        if((Op==6'b111000)||(Op==6'b111010))PCSrc=2'b11;
        else if(Op==6'b111001)PCSrc=2'b10;
        else if(Op==6'b111111)PCSrc=2'bz;
        else PCSrc=2'b00;
    end
    else if(State==3'b010)begin
        if((Op==6'b110100&&Zero==1)||(Op==6'b110101&&Zero==0)||(Op==6'b110110&&Zero==0&&Sign==0))PCSrc=2'b01;
        else PCSrc=2'b00;
    end
    else PCSrc=2'b00;
    
    //if(Reset==0)IsHalt=0;
    if(Op==6'b111111)IsHalt=1;
    else IsHalt=0;
    
    if(State==3'b010)begin
       if(Op==6'b000001)ALUOp=3'b001;
       else if((Op==6'b100110)||(Op==6'b100111))ALUOp=3'b011;
       else if(Op==6'b011000)ALUOp=3'b100;
       else if((Op==6'b010010)||(Op==6'b010000))ALUOp=3'b101;
       else if(Op==6'b010001)ALUOp=3'b110;
       else if((Op==6'b110100)||(Op==6'b110101)||(Op==6'b110110))ALUOp=3'b111;
       else ALUOp=3'b000;
    end
    else ALUOp=3'b000;
end

always @(negedge CLK)begin
    if(State==3'b001)begin
        if((Op==6'b111000)||(Op==6'b111001)||(Op==6'b111010))PCWre<=1;
        else PCWre<=0;
    end
    else if(State==3'b010)begin
        if((Op==6'b110100)||(Op==6'b110101)||(Op==6'b110110))PCWre<=1;
        else PCWre<=0;
    end
    else if(State==3'b100)begin
         if(Op==6'b110000)PCWre<=1;
         else PCWre<=0;
    end
    else if(State==3'b011)PCWre<=1;
    else PCWre<=0;
end

endmodule
