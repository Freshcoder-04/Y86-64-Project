`include "FA.v"

module add_sub(A,B,Sel,Sum,Carry);

input [63:0]A;
input [63:0]B;
input [3:0]Sel;
output [63:0]Sum;
output [63:0]Carry;

wire M,Sel1not;
not (Sel1not,Sel[1]);
and (M,Sel1not,Sel[0]);

FA FirstAdd(A[0],B[0],M,Sel,Sum[0],Carry[0]);

genvar iterator;
generate
    for (iterator = 1; iterator < 63 ; iterator = iterator + 1) begin
        FA MidAdd(A[iterator],B[iterator],Carry[iterator-1],Sel,Sum[iterator],Carry[iterator]);
    end
endgenerate

FA LastAdd(A[63],B[63],Carry[62],Sel,Sum[63],Carry[63]);

endmodule