module Xor_bitwise(A,B,XORed);
input [63:0] A,B;
output [63:0] XORed;

genvar pointer;

generate
    for(pointer=0;pointer<64;pointer=pointer+1) begin
        xor xor_gate1(XORed[pointer],A[pointer],B[pointer]);
    end

endgenerate

endmodule