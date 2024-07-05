`include "Processor.v"

module tb_Processor();

reg clk;
wire [3:0] icode, ifun, rA, rB;
wire [63:0] valC, valP;
wire instr_valid, imem_error, dmem_error, hlt;   
wire [1:0] Status;

wire cond_flag;   
wire [63:0] valE, valM,valA,valB;

reg [63:0] NextPC;
wire [63:0] PC;

Processor Y86_team10(clk,icode,ifun,rA,rB,valA,valB,valC,valP,valE,valM,Status,PC);

initial begin
    clk = 0;
end

always  begin #100; clk=~clk; end

initial begin
    $dumpfile("tb_Processor.vcd");
    $dumpvars(0,tb_Processor);
end 


always@(posedge clk) begin  
    if(Status != 2'b00) begin
        // $monitor("Status = %b", Status);
        $monitor("Test Complete.");
        $finish;
    end
    // if(icode[3] != 0 && icode[3] != 1) begin
    //     $monitor("1");
    //     $finish;
    // end
end

always@(posedge clk) begin
    $monitor("icode = %b, ifun = %b, NextPC = %b, rA = %h, rB = %h, valA = %h, valB = %h, valC = %h, valP = %d, valE = %h,valM = %h,Status = %d",icode,ifun,PC,rA,rB,valA,valB,valC,valP,valE,valM,Status);
end

endmodule