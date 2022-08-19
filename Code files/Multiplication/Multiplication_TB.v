`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2020 22:11:51
// Design Name: 
// Module Name: gfgh
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



module Multiplication_TB();
//wire [31:0]A,B;
wire [31:0]C[0:3];
wire [31:0]Input_1[0:3],Input_2[0:3];

wire [31:0] expected_output[0:3];
//12.34 x 56.789 = 700.77626
assign Input_1[0] = 32'b01000001010001010111000010100100;
assign Input_2[0] = 32'b01000010011000110010011111110000;
assign expected_output[0] = 32'b01000100001011110011000110101110;

//0.08103727714 x -700.77626 = -56.789 
assign Input_1[1] = 32'b00111101101001011111011011011111;
assign Input_2[1] = 32'b11000100001011110011000110101110;
assign expected_output[1] = 32'b11000010011000110010011111110000;

// 1729 x 8055 = 13927095
assign Input_1[2] = 32'b01000100110110000010000000000000;
assign Input_2[2] = 32'b01000101111110111011100000000000;
assign expected_output[2] = 32'b01001011010101001000001010110111;

//-438.834 x -614.416 = 269626.630944
assign Input_1[3] = 32'b11000011110110110110101011000001;
assign Input_2[3] = 32'b11000100000110011001101010100000;
assign expected_output[3] = 32'b01001000100000111010011101010100;
genvar i;
generate
for(i=0; i<4; i = i + 1) begin

    Multiplication test(Input_1[i],Input_2[i],C[i]);
    
end

endgenerate
endmodule


