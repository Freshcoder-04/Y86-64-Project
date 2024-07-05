module E_reg(clk,d_stat,d_icode,d_ifun,d_valC,d_valA,d_valB,d_dstE,d_dstM,d_rA,d_rB, E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,E_rA,E_rB,E_dstE,E_dstM,E_bubble);

input clk;
input [1:0] d_stat;
input [3:0] d_icode,d_ifun,d_dstE,d_dstM,d_rA,d_rB;
input [63:0] d_valC,d_valA,d_valB;

input wire E_bubble;
output reg [1:0] E_stat;
output reg [3:0] E_icode,E_ifun,E_dstE,E_dstM,E_rA,E_rB;
output reg [63:0] E_valC,E_valA,E_valB;

initial begin
    E_stat = 2'd0;
    E_dstE = 4'hF;
    E_dstM = 4'hF;
    E_icode = 4'd0;
    E_ifun = 4'd0;
    E_valC = 64'd0;
    E_valA = 64'd0;
    E_valB = 64'd0;
    E_rA = 4'hF;
    E_rB = 4'hF;
end

always@(posedge clk) begin
    if(E_bubble)begin
        E_stat = 2'd0;
        E_dstE = 4'hF;
        E_dstM = 4'hF;
        E_icode = 4'd0;
        E_ifun = 4'd0;
        E_valC = 64'd0;
        E_valA = 64'd0;
        E_valB = 64'd0;
        E_rA = 4'hF;
        E_rB = 4'hF;
    end
    else begin
        E_stat = d_stat;
        E_icode = d_icode;
        E_ifun = d_ifun;
        E_valC = d_valC;
        E_valA = d_valA;
        E_valB = d_valB;
        E_dstE = d_dstE;
        E_dstM = d_dstM;
        E_rA = d_rA;
        E_rB = d_rB;
    end
end

// always@(negedge clk) begin
//     if(D_stall || (e_icode == 4'b0111 && !e_Cnd) || ((e_icode == 4'b0101 || e_icode == 4'b1011) && (E_dstM == d_rA || E_dstM == d_rB)))begin 
//         E_bubble = 1;
//     end
//     else begin
//         E_bubble = 0;
//     end 
// end

endmodule