module F_reg(clk,f_predPC,f_PC,F_stall,F_predPC,e_icode,d_icode,m_icode,E_dstM,d_rA,d_rB,f_prevPC);

input clk;  
input wire F_stall;
input [63:0] f_predPC, f_PC,f_prevPC;
output reg [63:0] F_predPC;
input wire [3:0] d_rA,d_rB,d_icode,e_icode,m_icode,E_dstM;

initial begin  
    F_predPC = 64'd0;
end

always@(posedge clk) begin // e_icode,d_icode,E_dstM,m_icode,d_rA,d_rB
    // if(((e_icode == 4'b0101 || e_icode == 4'b1011) && (E_dstM == d_rA || E_dstM == d_rB)) || 
    //     (d_icode == 4'b1001 || e_icode == 4'b1001 || m_icode == 4'b1001) ) begin
    //     F_stall = 1;
    // end
    // else begin
    //     F_stall = 0;
    // end
    if(F_stall) begin
        F_predPC = f_prevPC;
    end
    else begin
        F_predPC = f_predPC;
    end
end

// always@(*) begin
//     if(((e_icode == 4'b0101 || e_icode == 4'b1011) && (E_dstM == d_rA || E_dstM == d_rB)) || 
//         (d_icode == 4'b1001 || e_icode == 4'b1001 || m_icode == 4'b1001) ) begin
//         F_stall = 1;
//     end
//     else begin
//         F_stall = 0;
//     end
// end

// always@(posedge clk) begin
//     if(F_stall) begin
//         F_predPC = f_PC;
//     end
//     else begin
//         F_predPC = f_predPC;
//     end
// end

endmodule