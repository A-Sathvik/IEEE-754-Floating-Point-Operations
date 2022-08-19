`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.01.2021 12:47:02
// Design Name: 
// Module Name: jhygyfjhb
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


module Multiplication(A, B, C);
    input [31:0]A,B;
    output [31:0]C;    //A, B, C are represented according to IEEE standard 754 floating point representation
    wire sign;
    assign sign = A[31]^B[31];
    wire [7:0]ae, be;
    assign ae = A[30:23] - 8'd127;
    assign be = B[30:23] - 8'd127; // ae, be are unbiased exponents
    wire [23:0]am, bm;
    wire [22:0]cman;
    wire [47:0]cm;
    assign am = {1'b1,A[22:0]}; // Reprentation of (1.A_mantissa) as 24 bits
    assign bm = {1'b1,B[22:0]}; // Reprentation of (1.B_mantissa) as 24 bits
    wire [7:0]ce,cexp;
    assign ce = (ae + be) + 8'd127; // Biasing exponent.
    // Sum of unbiased exponents should be in the range (-127,128] to avoid overflow
    radix4booth mul({8'd0,am},{8'd0,bm},cm); // 24 bit multiplication 
    
//    assign cman = cm[47] ? (cm[23] ? cm[46:24]+1'b1 : cm[46:24]) : (cm[22] ? cm[45:23]+1'b1 : cm[45:23]);  //This includes rounding off mantissa product to 23 bits
    assign cman = cm[47] ? cm[46:24] : cm[45:23]; //This step is truncation instead of rounding
    assign cexp = cm[47]? (ce + 1'b1):ce; // Exponent increases by 1 depending on mantiassas multiplication.
    assign C = {sign,cexp,cman};

    
endmodule
