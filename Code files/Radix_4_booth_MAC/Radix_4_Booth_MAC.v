`timescale 1ns / 1ps
module MAC_radix4booth(rst, start, M, Q, clk, P);

input rst, start;
input [31:0]M;
input [31:0]Q;
input clk;
output reg [63:0]P;
reg [63:0] Acc,C,m;     // For X = C + AB, Acc = C + m
reg [32:0] q;
reg done;


initial begin
    P <= {64'd0};
    Acc <= {64'd0};
    C <= {64'd0};
    case(M[31])
        1'b0: m<={{32{1'd0}},M};
        1'b1: m<={{32{1'd0}},~M + 1'b1};
    endcase
    
    case(Q[31])
        1'b0: q<={Q,1'b0};          // LSB zero, for conversion into Radix-4
        1'b1: q<={~Q + 1'b1,1'b0};
    endcase
    
    done <= 1'b0;

end

always@(posedge clk) begin
if(rst == 1'b1) begin
    Acc <= {64'd0};
    P <= {64'd0};
    C <= {64'd0};
    case(M[31])
        1'b0: m<={{32{1'd0}},M};
        1'b1: m<={{32{1'd0}},~M + 1'b1};
    endcase
    
    case(Q[31])
        1'b0: q<={Q,1'b0};          // LSB zero, for conversion into Radix-4
        1'b1: q<={~Q + 1'b1,1'b0};
    endcase
    done <= 1'b0;
end
else if (rst == 1'b0 && start == 1'b1) begin
    case(q[2:0])
        3'b000: Acc = Acc;
        3'b001: Acc = C+m;       // Similar X = C + AB in MAC
        3'b010: Acc = C+m;       // But, instead of AxB, m is defined correspondingly
        3'b011: Acc = C+( m << 1 );
        3'b100: Acc = C+( ~(m << 1) + 1'b1);
        3'b101: Acc = C+(~m+1'b1);
        3'b110: Acc = C+(~m+1'b1);
        3'b111: Acc = P;
        default: done <= done;
    endcase
    C = Acc;
    m = m << 2;
    q = q >> 2;
end
end

always@(posedge clk) begin
if(q<=3) begin
done <= 1;
P <= Acc;
end
end

always@(posedge done) begin
// (M[31]^Q[31]) gives Output sign
P = P^{64{M[31]^Q[31]}} + M[31]^Q[31];  // 2s complement (if required)
end

endmodule
