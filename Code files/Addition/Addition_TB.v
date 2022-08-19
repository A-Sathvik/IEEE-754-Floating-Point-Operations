`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.01.2021 12:49:41
// Design Name: 
// Module Name: hvhgcc
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


module Addition_TB();
//wire [31:0]A,B;
wire [31:0]error[0:3];
wire [31:0]C[0:3];
wire [31:0]Input_1[0:3],Input_2[0:3];

wire [31:0] expected_output[0:3];
assign expected_output[0] = 32'b01000011000011011111100110011010;
assign expected_output[1] = 32'b01000010010111100011100001010010;
assign expected_output[2] = 32'b11000010010111100011100001010010;
assign expected_output[3] = 32'b11000011000011011111100110011010;




assign Input_1[0] = 32'b01000010110001011000011110101110;
assign Input_2[0] = 32'b01000010001011001101011100001010;

assign Input_1[1] = 32'b01000010110001011000011110101110;
assign Input_2[1] = 32'b11000010001011001101011100001010 ;

assign Input_1[2] = 32'b11000010110001011000011110101110 ;
assign Input_2[2] = 32'b01000010001011001101011100001010 ;

assign Input_1[3] = 32'b11000010110001011000011110101110 ;
assign Input_2[3] = 32'b11000010001011001101011100001010 ;
genvar i;
generate
for(i=0; i<4; i = i + 1) begin

    Addition test(Input_1[i],Input_2[i],C[i]);
    
end
Addition test1(C[i], expected_output[i], error[i]);
endgenerate
endmodule
