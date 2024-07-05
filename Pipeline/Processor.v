`include "Fetch.v"
`include "Decode.v"
`include "Execute.v"
`include "mem.v"
`include "Writeback.v"
`include "F_reg.v"
`include "D_reg.v"
`include "E_reg.v"
`include "M_reg.v"
`include "W_reg.v"
`include "stat.v"
`include "Hazards.v"

module Processor(clk,D_icode,D_ifun,d_icode,d_ifun,E_icode,E_ifun,M_icode,W_icode,D_rA,D_rB,E_dstM,w_stat,f_stat, d_stat, m_stat, e_stat, E_stat,D_stat,M_stat,W_stat,f_PC,f_predPC,F_predPC,F_stall,D_stall,E_bubble, M_Cnd,e_Cnd,f_icode,f_ifun,f_valP,f_valC,d_valA,d_valB,reg_wire0, reg_wire1, reg_wire2, reg_wire3, reg_wire4, reg_wire5, reg_wire6, reg_wire7, reg_wire8, reg_wire9, reg_wire10, reg_wire11, reg_wire12, reg_wire13, reg_wire14, reg_wire15,stat,d_dstE, d_dstM, e_dstE, e_dstM, E_dstM, E_dstE, M_dstE, M_dstM, E_rA, E_rB, W_dstE, W_dstM, e_icode, e_ifun, m_icode,d_valC, W_valM,W_valE, E_valC, E_valA, E_valB,e_valE,M_valE,M_valA,m_valM,f_rA,f_rB,D_valP,D_bubble,m_dstE,f_prevPC,M_valB,e_valB,d_rA,d_rB);

input wire clk;

reg [63:0] register_array [0:15];

// handle case when halt encountered as last instruction and
// in general last instruction encountered

output wire [1:0] w_stat,stat; // 00 -> AOK, 01 -> HLT, 10 -> ADR, 11 -> IN

output wire [63:0] f_predPC,f_prevPC;
output wire [63:0] f_PC;
output wire [63:0] F_predPC;
output wire F_stall,D_stall,E_bubble,m_bubble,D_bubble,M_Cnd,e_Cnd;
output wire [3:0] f_icode,d_rA,d_rB,D_icode, d_icode, d_ifun, E_icode, M_icode, W_icode, f_ifun, D_ifun, E_ifun, f_rA, f_rB, D_rA, D_rB, d_dstE, d_dstM, e_dstE, e_dstM, E_dstM, E_dstE, M_dstE, M_dstM, E_rA, E_rB, W_dstE, W_dstM, e_icode, e_ifun, m_icode,m_dstE,m_dstM;
output wire [1:0] f_stat, d_stat, m_stat, e_stat, E_stat,D_stat,M_stat,W_stat;
output wire [63:0] D_valC, D_valP, f_valC, f_valP, d_valA, d_valB, d_valC, W_valM,W_valE, E_valC, E_valA, E_valB,e_valE,M_valE,M_valA,m_valM,e_valA,e_valB,e_valC,m_valE,m_valA,M_valB;


output wire [63:0]reg_wire0;
output wire [63:0]reg_wire1;
output wire [63:0]reg_wire2;
output wire [63:0]reg_wire3;
output wire [63:0]reg_wire4;
output wire [63:0]reg_wire5;
output wire [63:0]reg_wire6;
output wire [63:0]reg_wire7;
output wire [63:0]reg_wire8;
output wire [63:0]reg_wire9;
output wire [63:0]reg_wire10;
output wire [63:0]reg_wire11;
output wire [63:0]reg_wire12;
output wire [63:0]reg_wire13;
output wire [63:0]reg_wire14;
output wire [63:0]reg_wire15;

// initial begin
//     F_predPC = 64'd0;
// end
// initislise f_valP = 0
Hazards Hazards1(E_icode,E_dstM,d_rA,d_rB,D_icode,M_icode,e_Cnd,F_stall,D_stall,E_bubble,D_bubble);

    F_reg F_reg1(clk,f_predPC,f_PC,F_stall,F_predPC,E_icode,D_icode,M_icode,E_dstM,d_rA,d_rB,f_prevPC);

Fetch fetch1(clk, M_valA, W_valM, M_Cnd, D_rA, D_rB, E_icode, E_dstM, D_icode, M_icode, W_icode, f_icode, f_ifun, f_rA, f_rB, f_valC, f_valP, f_stat, F_stall,f_PC,F_predPC,f_predPC,f_prevPC);

    D_reg D_reg1(clk,D_bubble,f_stat,f_icode,f_ifun,f_rA,f_rB,f_valC,f_valP,F_stall, D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stall,e_icode,E_dstM,e_Cnd,M_icode,d_icode,m_icode,d_rA,d_rB);

Decode decode1(M_dstE,e_dstE,e_valE,M_dstM,m_valM,M_valE,W_valM,W_dstE,W_valE,D_icode, D_stall,D_stat, D_ifun, D_rA, D_rB, D_valP, D_valC,E_icode, E_dstM,e_Cnd,reg_wire0, reg_wire1, reg_wire2, reg_wire3, reg_wire4, reg_wire5, reg_wire6, reg_wire7, reg_wire8, reg_wire9, reg_wire10, reg_wire11, reg_wire12, reg_wire13, reg_wire14, reg_wire15, d_valA, d_valB, d_dstE, d_dstM,d_stat, D_bubble,d_icode,d_ifun,d_rA,d_rB,d_valC);

    E_reg E_reg1(clk,d_stat,d_icode,d_ifun,d_valC,d_valA,d_valB,d_dstE,d_dstM,d_rA,d_rB, E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,E_rA,E_rB,E_dstE,E_dstM,E_bubble);

Execute execute1(E_icode,E_ifun,E_valA,E_valB,E_valC,E_dstE,E_dstM,E_bubble,E_stat,E_rA,E_rB, e_valE,e_Cnd,e_dstE,e_dstM,e_icode,e_ifun,e_stat,e_valA,e_valB,e_valC);

    M_reg M_reg1(clk, e_stat, e_icode, e_Cnd, e_valE, e_valA, e_valB, e_dstE, e_dstM, M_stat, M_icode, M_Cnd, M_valE, M_valA, M_valB, M_dstE, M_dstM);

mem mem1(M_dstE, M_dstM, m_dstE, m_dstM, m_valE,m_valA,M_stat, M_valA, M_valB, M_valE, M_icode, m_valM, m_stat, m_icode, clk);

    W_reg W_reg1(clk, m_stat, m_icode, m_valE, m_valM, m_dstE, m_dstM, W_stat, W_icode, W_valE, W_valM, W_dstE, W_dstM);

Writeback writeback1(W_icode, W_valM, W_valE, W_dstE, W_dstM, W_stat, w_stat,reg_wire0, reg_wire1, reg_wire2, reg_wire3, reg_wire4,reg_wire5, reg_wire6, reg_wire7, reg_wire8, reg_wire9, reg_wire10, reg_wire11, reg_wire12, reg_wire13, reg_wire14, reg_wire15, clk);

stat stat1(clk,w_stat,stat);
// PC_update pc_update1(icode,valP,valC,valM,cond_flag, NextPC);

// always@(*) begin
//     $monitor(PC);
// end

// always@(*) begin
    


    // $monitor(imem_error,dmem_error,hlt,instr_valid);
    // Status = 2'b00;
    // // $monitor("%b",cc);
    // // $monitor("%b, %h",dmem_error,valE);
    // if(hlt == 1) begin
    //     Status = 2'b01;
    // end
    // else if(imem_error == 1 || dmem_error == 1) begin
    //     Status = 2'b10;
    //     // $monitor("%b, %h",dmem_error,valE);
    // end
    // else if(instr_valid == 0) begin
    //     Status = 2'b11;
    // end
    // else begin
    //     Status = 2'b00;  // AOK
    // end
// end

endmodule