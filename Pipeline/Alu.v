`include "Add_Sub.v"
`include "xor.v"
`include "and.v"

module ALU(ALU_A,ALU_B,ALU_fun,valE);

input wire [63:0] ALU_A, ALU_B;
input wire [3:0] ALU_fun;   //ALU_fun = 0000, 0001, 0010, 0011

output reg [63:0] valE;

wire [63:0] Sum_temp, XORed_temp, Anded_temp,Carry_temp;

add_sub X1(ALU_A,ALU_B,ALU_fun,Sum_temp,Carry_temp);
and_bitwise X2(ALU_A,ALU_B,Anded_temp);
Xor_bitwise X3(ALU_A,ALU_B,XORed_temp);

always@(*) begin
    if((ALU_fun == 4'b0000) || (ALU_fun == 4'b0001)) begin
        assign valE = Sum_temp;
    end
    else if(ALU_fun == 4'b0010) begin
        assign valE = Anded_temp;
    end
    else if(ALU_fun == 4'b0011) begin
        assign valE = XORed_temp;
    end
end
// genvar r;
// generate
// for(r = 0; r<64; r=r+1 ) begin
//     and (Sum[r], Sum_temp[r], control01);
//     and (Carry[r], Carry_temp[r], control01);
//     and (XORed[r], XORed_temp[r], control3);
//     and (Anded[r], Anded_temp[r], control2);
// end    

// endgenerate

endmodule