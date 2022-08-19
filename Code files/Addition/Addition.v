`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.12.2020 15:04:40
// Design Name: 
// Module Name: j
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


module Addition(A,B,C);
input [31:0] A,B;
output [31:0] C;        //A, B, C are represented according to IEEE standard 754 floating point representation
wire [31:0] C;
reg Sign_A, Sign_B;
reg [7:0] e_A,e_B;
reg Sign_C;
reg [7:0] E;
wire [7:0] eC;
reg [23:0] M_A, M_B, Big, Small;
wire [22:0] Mantissa_C;
reg [24:0] Mant_temp2, Mant_temp1;
wire [22:0] Mantissa_Cd;
initial begin
 Sign_A = A[31];
 Sign_B = B[31];
 e_A = A[30:23];
 e_B = B[30:23];

M_A = {1'b1, A[22:0]};
M_B = {1'b1, B[22:0]};

end
always@(Sign_A,Sign_B) begin

    if(e_A>e_B) begin
        E = e_A;			// Output exponent is almost same as that of larger number's
 
        M_B = M_B >> (e_A - e_B); // Right shift of smaller number's Mantissa such that exponents are equal
        Big = M_A;			// As exponents are same, Mantissa gives the larger number (without sign)
        Small = M_B;
        Sign_C = Sign_A;		// As 'A' is larger, Sign of A +/- B remains sign A.
        
        end
    else if (e_A<e_B) begin
        E = e_B;			// Now, 'B' is larger

        M_A = M_A >> (e_B - e_A);
        Big = M_B;
        Small = M_A;
        Sign_C = Sign_B;

    end
    else begin				// Exponents are same => Larger number is decided by Mantissas
        E = e_A;
        if(M_A>M_B) begin
        Big = M_A;
        Small = M_B;
        Sign_C = Sign_A;
        end
        else begin
        Big = M_B;
        Small = M_A;
        Sign_C = Sign_B;
        end
        end

 Mant_temp1 = M_A+M_B;			// For like signs, any how Mantissas should be added and underflow cannot occur in this situation. But there is 1 overflow possibility.
 Mant_temp2 = Big-Small;   		// Subtraction may result in underflow. There are 23 possibilities and we have taken care by following steps.
end
wire [23:0] M;
assign M = Mant_temp2;
assign Mantissa_Cd =  M[23] ? {M[22:0]} : M[22] ? {M[21:0],1'd0} : M[21] ? {M[20:0],2'd0} : M[20] ? {M[19:0],3'd0} : M[19] ? {M[18:0],4'd0} : M[18] ? {M[17:0],5'd0} : M[17] ? {M[16:0],6'd0} : M[16] ? {M[15:0],7'd0} : M[15] ? {M[14:0],8'd0} : M[14] ? {M[13:0],9'd0} : M[13] ? {M[12:0],10'd0} : M[12] ? {M[11:0],11'd0} : M[11] ? {M[10:0],12'd0} : M[10] ? {M[9:0],13'd0} : M[9] ? {M[8:0],14'd0} : M[8] ? {M[7:0],15'd0} : M[7] ? {M[6:0],16'd0} : M[6] ? {M[5:0],17'd0} : M[5] ? {M[4:0],18'd0} : M[4] ? {M[3:0],19'd0} : M[3] ? {M[2:0],20'd0} : M[2] ? {M[1:0],21'd0} : M[1] ? {M[0],22'd0} : 23'd0 ;

// As 1.000001 - 0.99999 gives 0.000002, normalisation should be done appropriately in A-b and B-A situations

// Alternative for these MUXes, is to utilise a separate module (shown below) which shifts the mantissa and finds the first non-zero bit in order to normalise appropriately.

assign Mantissa_C = Sign_A^Sign_B ? Mantissa_Cd : Mant_temp1[24] ? Mant_temp1[23:1] : Mant_temp1[22:0];

// In the case of same signs, overflow occurs only in a single possibility of Mantissa A + Mantissa B > 23-bits

wire [7:0]exp_C;
assign exp_C = M[23] ? E-0 : M[22] ? E-1 : M[21] ? E-2 : M[20] ? E-3 : M[19] ? E-4 : M[18] ? E-5 : M[17] ? E-6 : M[16] ? E-7 : M[15] ? E-8 : M[14] ? E-9 : M[13] ? E-10 : M[12] ? E-11 : M[11] ? E-12 : M[10] ? E-13 : M[9] ? E-14 : M[8] ? E-15 : M[7] ? E-16 : M[6] ? E-17 : M[5] ? E-18 : M[4] ? E-19 : M[3] ? E-20 : M[2] ? E-21 : M[1] ? E-22 : E-23;

// With proper normalisation of Mantissa, correction of exponent correspondingly is required.

assign eC = Sign_A^Sign_B ? exp_C : Mant_temp1[24] ? (E + 1'b1) : E;
assign C = {Sign_C, eC, Mantissa_C};
endmodule


