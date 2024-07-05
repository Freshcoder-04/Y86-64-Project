module FA(A,B,C,Sel,Sum,Carry);

input A,B,C;
input [3:0]Sel;
output Sum,Carry;

wire M,Sel1not;
not (Sel1not,Sel[1]);
and (M,Sel1not,Sel[0]);

wire AS1xor1,FA1xor1,FA1and1,FA1and2,C1;
xor (AS1xor1,B,M);
xor (FA1xor1,AS1xor1,A);
xor (Sum,FA1xor1,C);
and (FA1and1,AS1xor1,A);
and (FA1and2,FA1xor1,C);
or (Carry,FA1and1,FA1and2);

endmodule