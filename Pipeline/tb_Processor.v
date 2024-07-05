`include "Processor.v"

module tb_Processor();

reg clk;
wire [3:0] D_icode,D_ifun,E_icode,E_ifun,M_icode,W_icode,D_rA,D_rB,E_dstM;
wire [1:0] w_stat,f_stat, d_stat, m_stat, e_stat, E_stat,D_stat,M_stat,W_stat,stat;
wire [63:0] f_PC;
wire [63:0] F_predPC;
wire [63:0] f_predPC,f_prevPC;
wire [3:0] f_icode,f_ifun,f_rA,f_rB,d_icode,d_ifun,d_dstE, d_dstM, e_dstE, e_dstM, E_dstE, M_dstE, M_dstM, E_rA, E_rB, W_dstE, W_dstM, e_icode, e_ifun, m_icode,m_dstE,d_rA,d_rB;
wire [63:0] f_valC,f_valP,d_valA,d_valB,d_valC, W_valM,W_valE, E_valC, E_valA, E_valB,e_valE,M_valE,M_valA,m_valM,D_valP,M_valB,e_valB;
wire D_stall,E_bubble, M_Cnd,e_Cnd,D_bubble,F_stall;
wire [63:0] reg_wire0, reg_wire1, reg_wire2, reg_wire3, reg_wire4, reg_wire5, reg_wire6, reg_wire7, reg_wire8, reg_wire9, reg_wire10, reg_wire11, reg_wire12, reg_wire13, reg_wire14, reg_wire15;

Processor Y86_team10(clk,D_icode,D_ifun,d_icode,d_ifun,E_icode,E_ifun,M_icode,W_icode,D_rA,D_rB,E_dstM,w_stat,f_stat, d_stat, m_stat, e_stat, E_stat,D_stat,M_stat,W_stat,f_PC,f_predPC,F_predPC,F_stall,D_stall,E_bubble,M_Cnd,e_Cnd,f_icode,f_ifun,f_valP,f_valC,d_valA,d_valB,reg_wire0, reg_wire1, reg_wire2, reg_wire3, reg_wire4, reg_wire5, reg_wire6, reg_wire7, reg_wire8, reg_wire9, reg_wire10, reg_wire11, reg_wire12, reg_wire13, reg_wire14, reg_wire15,stat,d_dstE, d_dstM, e_dstE, e_dstM, E_dstM, E_dstE, M_dstE, M_dstM, E_rA, E_rB, W_dstE, W_dstM, e_icode, e_ifun, m_icode,d_valC, W_valM,W_valE, E_valC, E_valA, E_valB,e_valE,M_valE,M_valA,m_valM,f_rA,f_rB,D_valP,D_bubble,m_dstE,f_prevPC,M_valB,e_valB,d_rA,d_rB);

initial begin
    clk = 0;
    // f_PC = 64'd0;
end

always  begin #1000; clk=~clk; end

initial begin
    $dumpfile("tb_Processor.vcd");
    $dumpvars(0,tb_Processor);
end 


always@(*) begin  
    if(stat != 2'b00) begin
        $monitor("w_stat = %d", w_stat);
        $monitor("stat = %d", stat);
        $monitor("Test Complete.");
        $finish;
    end
    // if(icode[3] != 0 && icode[3] != 1) begin
    //     $monitor("1");
    //     $finish;
    // end
end

always@(*) begin
    $monitor("f_icode = %d, f_ifun = %d, E_icode = %d, E_ifun = %d, M_icode = %d, W_icode = %d, D_rA = %h, D_rB = %h, E_dstM = %h, w_stat = %d, f_PC = %d, f_predPC = %d, F_predPC = %d, F_stall = %d",f_icode,f_ifun,E_icode,E_ifun,M_icode,W_icode,D_rA,D_rB,E_dstM,w_stat,f_PC,f_predPC,F_predPC,F_stall);
    // #8000 $finish;
end

endmodule