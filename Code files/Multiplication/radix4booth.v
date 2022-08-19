`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.01.2021 12:33:26
// Design Name: 
// Module Name: hgf
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


module radix4booth(A,B,C);
input [31:0]A;
input [31:0]B;
output [47:0]C;
wire [63:0] Creg;
//wire [63:0]Cdum;
wire [63:0]M[0:32];
wire [32:0] Q;
assign M[0] = {32'd0,A};
assign Q = {B,1'b0};

wire [63:0]Acc[0:32];
assign Acc[0] = 64'd0;
genvar q;
generate
for (q=0; q<=30; q = q+2) begin
    Sum s1(Acc[q], M[q], Q[q+2:q], Acc[q+2]);
    ls s2(M[q],M[q+2]);
end
endgenerate
assign Creg = Acc[32];
assign C = Creg[47:0];
endmodule
