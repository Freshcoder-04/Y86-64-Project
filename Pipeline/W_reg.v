module W_reg(clk, m_stat, m_icode, m_valE, m_valM, m_dstE, m_dstM, W_stat, W_icode, W_valE, W_valM, W_dstE, W_dstM);

input clk;
input [1:0] m_stat;
input [3:0] m_icode;
input [63:0] m_valE, m_valM;
input [3:0] m_dstE, m_dstM;

// output reg W_bubble;
output reg [1:0] W_stat;
output reg [3:0] W_icode;
output reg [63:0] W_valE, W_valM;
output reg [3:0] W_dstE, W_dstM;

initial begin
    // W_bubble = 1'd0;
    W_icode = 4'd0;
    W_valE = 64'd0;
    W_valM = 64'd0;
    W_dstE = 4'd0;
    W_dstM = 4'd0;
    W_stat = 2'd0;
end

always@(posedge clk)
begin
    // if(W_icode == 4'd0) begin
    //     W_stat = 2'd0;
    // end
    W_stat = m_stat;
    W_icode = m_icode;
    W_valE = m_valE;
    W_valM = m_valM;
    W_dstE = m_dstE;
    W_dstM = m_dstM;
end

endmodule