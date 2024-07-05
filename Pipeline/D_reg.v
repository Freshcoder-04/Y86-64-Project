module D_reg(clk,D_bubble,f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,F_stall, D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stall,e_icode,E_dstM,e_Cnd,M_icode,d_icode,m_icode,E_rA,E_rB);

input clk,F_stall,e_Cnd;
input [1:0] f_stat;
input [3:0] f_icode,f_ifun,f_rA,f_rB,e_icode,M_icode,E_dstM,d_icode,m_icode,E_rA,E_rB;
input [63:0] f_valC,f_valP;

input wire D_stall,D_bubble;
output reg [1:0] D_stat;
output reg [3:0] D_icode,D_ifun,D_rA,D_rB;
output reg [63:0] D_valC,D_valP;

initial begin
    D_icode = 4'd0;
    D_ifun = 4'd0;
    D_rA = 4'hf;
    D_rB = 4'hf;
end

always@(posedge clk) begin
    if(!D_stall && !D_bubble) begin
        D_stat = f_stat;
        D_icode = f_icode;
        D_ifun = f_ifun;
        D_rA = f_rA;
        D_rB = f_rB;
        D_valC = f_valC;
        D_valP = f_valP;
    end
    else if(D_bubble) begin   // even if stall is 1 -> bubble prioritised
        D_stat = 2'd0;
        D_icode = 4'd0;
        D_ifun = 4'd0;
        D_valC = 64'd0;
        D_rA = 4'd0;
        D_rB = 4'd0;
        D_valP = 64'd0;
    end
    
end

endmodule