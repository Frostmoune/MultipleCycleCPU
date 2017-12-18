`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/18 08:26:39
// Design Name: 
// Module Name: testMainCPU
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


module testMainCPU;
reg CLK,Reset,Key;
wire [2:0] Selector;
wire [6:0] a_to_g;
wire [3:0] an;
wire dp;

assign Selector=3'b011;

MainCPU main(.CLK(CLK),.Reset(Reset),.Key(Key),.Selector(Selector),.a_to_g(a_to_g),.an(an),.dp(dp));

initial begin
    CLK = 0;
    Reset = 0;
    Key= 1;
    #50;
    begin 
        CLK=1;
        Key=0;
    end
    #25;
    CLK=0;
    #25;
    begin
        Reset=1;
        CLK=1;
        Key=0;
    end
    forever begin
        #20;
        begin
            CLK=~CLK;
            Key=~CLK;
        end
    end
end

endmodule
