module and_bitwise(A,B,Anded);
input [63:0] A,B;
output [63:0] Anded;

genvar pointer;

generate
    for(pointer=0;pointer<64;pointer=pointer+1) begin
        and and_gate1(Anded[pointer],A[pointer],B[pointer]);
    end
endgenerate

endmodule