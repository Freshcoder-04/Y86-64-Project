`timescale 1ns/1ns
`include "Writeback.v"

module tb_Writeback();

// Signals
reg [3:0] icode;
reg [63:0] valM, valE;
reg cond_flag;
reg [3:0] rA, rB;
reg clk;
wire [63:0] reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15;
// Instantiate the module
Writeback writeback1(icode, valM, valE, cond_flag, rA, rB,
            reg0, reg1, reg2, reg3, reg4,
            reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13,
            reg14, reg15, clk);

initial begin
    clk = 0;
end
// Clock generation
always #5 clk = ~clk;

initial begin
    icode = 4'b0010; // Start from 2
    valM = 64'd0;
    valE = 64'd0;
    cond_flag = 1;
    rA = 4'd0;
    rB = 4'd0;
    clk = 0;

    // Test case for icode = 2
    #10;
    valM = 64'd100;
    valE = 64'd200;
    rA = 4'd1;
    rB = 4'd2;

    // Test case for icode = 3
    icode = 4'b0011;
    #10;
    valM = 64'd150;
    valE = 64'd250;
    rA = 4'd2;
    rB = 4'd3;

    // Test case for icode = 4
    icode = 4'b0100;
    #10;
    valM = 64'd200;
    valE = 64'd300;
    rA = 4'd0;
    rB = 4'd0;

    // Test case for icode = 5
    icode = 4'b0101;
    #10;
    valM = 64'd250;
    valE = 64'd350;
    rA = 4'd0;
    rB = 4'd0;

    // Test case for icode = 6
    icode = 4'b0110;
    #10;
    valM = 64'd300;
    valE = 64'd400;
    rA = 4'd0;
    rB = 4'd0;

    // Test case for icode = 7
    icode = 4'b0111;
    #10;
    valM = 64'd350;
    valE = 64'd450;
    cond_flag = 1;
    rA = 4'd0;
    rB = 4'd0;

    // Test case for icode = 8
    icode = 4'b1000;
    #10;
    valM = 64'd400;
    valE = 64'd500;
    rA = 4'd0;
    rB = 4'd0;
    
    // Test case for icode = 9
    icode = 4'b1001;
    #10;
    valM = 64'd450;
    valE = 64'd550;
    rA = 4'd0;
    rB = 4'd0;

    // Test case for icode = 10
    icode = 4'b1010;
    #10;
    valM = 64'd500;
    valE = 64'd600;
    rA = 4'd0;
    rB = 4'd0;

    // Test case for icode = 11
    icode = 4'b1011;
    #10;
    valM = 64'd550;
    valE = 64'd650;
    rA = 4'd0;
    rB = 4'd0;
    
end

initial 
begin
    $dumpfile("tb_Writback.vcd");
    $dumpvars(0,tb_Writeback);
    $monitor("test complete.");
    #130 $finish;                                                   
end

endmodule