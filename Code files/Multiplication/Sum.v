`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.01.2021 12:45:51
// Design Name: 
// Module Name: jhbjhb
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


module Sum(Acc,M,r,Next_Acc);
input [63:0] Acc;
input [63:0] M;
input [2:0] r;
output [63:0] Next_Acc;
wire [63:0] sum;
assign sum = (r == 3'b001 || r == 3'b010) ? Acc+M :
             (r == 3'b011) ? Acc+(M<<1) : // {M,1b0};
             (r == 3'b100) ? Acc+(~(M<<1)+1'b1) :
             (r == 3'b101 || r == 3'b110) ? Acc+(~M+1'b1) : Acc;
assign Next_Acc = sum;
endmodule
