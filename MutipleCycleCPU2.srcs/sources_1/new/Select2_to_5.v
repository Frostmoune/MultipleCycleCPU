`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/11 21:39:49
// Design Name: 
// Module Name: Select2_to_5
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


module Select2_to_5(Selector,InA,InB,InC,InD,Out);
input [1:0] Selector;
input [4:0] InA,InB,InC,InD;
output reg [4:0] Out;

always @(Selector,InA,InB,InC,InD) begin
    case(Selector)
        2'b00:Out<=InA;
        2'b01:Out<=InB;
        2'b10:Out<=InC;
        2'b11:Out<=InD;
    endcase
end

endmodule
