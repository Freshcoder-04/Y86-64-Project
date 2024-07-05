`include "Fetch.v"

module tb_Fetch();

reg clk;
reg [63:0] PC;

wire [3:0] icode, ifun, rA, rB;
wire [63:0] valC, valP;
wire instr_valid, imem_error, hlt;   
// wire [0:79] instr_reg;  

Fetch Fetch1(clk, PC, icode, ifun, rA, rB, valC, valP, instr_valid, imem_error, hlt);

// always #10 clk = ~clk;

initial begin
    clk = 0;
    PC=64'd0;
end

always #10 clk=~clk;

always@(posedge clk) begin
    PC = valP;
end

initial begin
    $dumpfile("tb_Fetch.vcd");
    $dumpvars(0,tb_Fetch);
    $monitor("test complete.");
    #600 $finish;                                                   
end

endmodule