module M_reg(clk, e_stat, e_icode, e_Cnd, e_valE, e_valA,e_valB, e_dstE, e_dstM, M_stat, M_icode, M_Cnd, M_valE, M_valA, M_valB, M_dstE, M_dstM);

input clk;
input [1:0] e_stat;
input [3:0] e_icode;
input e_Cnd;
input [63:0] e_valE, e_valA, e_valB;
input [3:0] e_dstE, e_dstM;

output reg [1:0] M_stat;
output reg [3:0] M_icode;
output reg M_Cnd;
output reg [63:0] M_valE, M_valA, M_valB;
output reg [3:0] M_dstE, M_dstM;

initial begin
    M_Cnd = 0;
    // M_bubble = 0;
    M_dstE = 4'hf;
    M_dstM = 4'hf;
    M_icode = 4'd0;
    M_valA = 64'd0;
    M_valB = 64'd0;
    M_valE = 64'd0;
end

always@(posedge clk)
begin
    // M_bubble = e_bubble;
    // if(e_bubble) begin
    //     M_icode = 4'd0;
    //     // M_valE = 64'd0;
    //     M_valA = e_valA;
    //     // M_dstE = 4'd0;
        // M_dstM = 4'd0;
    // end
    M_stat = e_stat;
    M_icode = e_icode;
    M_Cnd = e_Cnd;
    M_valE = e_valE;
    M_valA = e_valA;
    M_valB = e_valB;
    M_dstE = e_dstE;
    M_dstM = e_dstM;
end


endmodule