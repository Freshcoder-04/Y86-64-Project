`include "Writeback.v"
`timescale 1ns / 1ps

module tb_Writeback();

    reg [3:0] W_icode;
    reg [63:0] W_valM, W_valE;
    reg clk, W_bubble;
    reg [1:0] W_stat;
    reg [3:0] W_dstE, W_dstM;
    wire [63:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15;
    wire [1:0] w_stat;

    Writeback Writeback_instance (
        .W_icode(W_icode),
        .W_valM(W_valM),
        .W_valE(W_valE),
        .clk(clk),
        .W_bubble(W_bubble),
        .W_stat(W_stat),
        .W_dstE(W_dstE),
        .W_dstM(W_dstM),
        .reg0(reg0),
        .reg1(reg1),
        .reg2(reg2),
        .reg3(reg3),
        .reg4(reg4),
        .reg5(reg5),
        .reg6(reg6),
        .reg7(reg7),
        .reg8(reg8),
        .reg9(reg9),
        .reg10(reg10),
        .reg11(reg11),
        .reg12(reg12),
        .reg13(reg13),
        .reg14(reg14),
        .reg15(reg15),
        .w_stat(w_stat)
    );

    initial begin
        // Initialize inputs
        W_valM = 64'd55;
        W_valE = 64'd102;
        clk = 0;
        W_bubble = 0;
        W_stat = 2'b00;
        W_dstE = 4'd0;
        W_dstM = 4'd1;
        
        // Initialize registers
        // reg0 = 64'd0;
        // reg1 = 64'd0;
        // reg2 = 64'd0;
        // reg3 = 64'd0;
        // reg4 = 64'd0;
        // reg5 = 64'd0;
        // reg6 = 64'd0;
        // reg7 = 64'd0;
        // reg8 = 64'd0;
        // reg9 = 64'd0;
        // reg10 = 64'd0;
        // reg11 = 64'd0;
        // reg12 = 64'd0;
        // reg13 = 64'd0;
        // reg14 = 64'd0;
        // reg15 = 64'd0;

        // Apply clock
        #10 clk = ~clk;
        
        // Test cases
        // Case 1: W_icode = 4'b0000 (NOP)
        #10;
        W_icode = 4'b0000;
        // Add expected register values here
        
        // Case 2: W_icode = 4'b0001 (HALT)
        #10;
        W_icode = 4'b0001;
        // Add expected register values here
        
        // Case 3: W_icode = 4'b0010 (2 fn)
        #10;
        W_icode = 4'b0010;
        // Add expected register values here
        
        // Case 4: W_icode = 4'b0011 (irmov)
        #10;
        W_icode = 4'b0011;
        // Add expected register values here
        
        // Case 5: W_icode = 4'b0100 (rmmov)
        #10;
        W_icode = 4'b0100;
        W_dstM = 4'd9;
        W_valM = 64'd87;
        // Add expected register values here
        
        // Case 6: W_icode = 4'b0101 (mrmovq)
        #10;
        W_icode = 4'b0101;
        // Add expected register values here
        
        // Case 7: W_icode = 4'b0110 (Arithmetic)
        #10;
        W_icode = 4'b0110;
        // Add expected register values here
        
        // Case 8: W_icode = 4'b0111 (jmp)
        #10;
        W_icode = 4'b0111;
        // Add expected register values here
        
        // Case 9: W_icode = 4'b1000 (call)
        #10;
        W_icode = 4'b1000;
        // Add expected register values here
        
        // Case 10: W_icode = 4'b1001 (ret)
        #10;
        W_icode = 4'b1001;
        // Add expected register values here
        
        // Case 11: W_icode = 4'b1010 (push)
        #10;
        W_icode = 4'b1010;
        // Add expected register values here
        
        // Case 12: W_icode = 4'b1011 (pop)
        #10;
        W_icode = 4'b1011;
        W_dstE = 4'd14;
        W_valE = 64'd200;
        // Add expected register values here
        
        // Case 13: W_icode = 4'b1100 (iaddq)
        #10;
        W_icode = 4'b1100;
        // Add expected register values here
        
        // Case 14: W_icode = 4'b1101 (xorq)
        #10;
        W_icode = 4'b1101;
        // Add expected register values here
        
        // Finish simulation
        #10;
        $finish;
    end
initial begin
    $dumpfile("tb_Writeback.vcd");
    $dumpvars(0,tb_Writeback);
end 

always begin
    #5; clk = ~clk;
end

endmodule