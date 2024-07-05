`include "Fetch.v"
`include "Decode.v"
`include "Execute.v"
`include "mem.v"
`include "Writeback.v"
`include "PC_update.v"

module Processor(clk,icode,ifun,rA,rB,valA,valB,valC,valP,valE,valM,Status,PC);

input wire clk;

reg [63:0] register_array [0:15];
output reg [63:0] PC;
output reg [1:0] Status; // 00 -> AOK, 01 -> HLT, 10 -> ADR, 11 -> INS

output [3:0] icode, ifun, rA, rB;
output [63:0] valC, valP;
wire instr_valid, imem_error, dmem_error, hlt;   

wire cond_flag;   
wire [63:0] NextPC;
output [63:0] valE,valM,valA,valB;

// reg [63:0]reg_file0;
// reg [63:0]reg_file1;
// reg [63:0]reg_file2;
// reg [63:0]reg_file3;
// reg [63:0]reg_file4;
// reg [63:0]reg_file5;
// reg [63:0]reg_file6;
// reg [63:0]reg_file7;
// reg [63:0]reg_file8;
// reg [63:0]reg_file9;
// reg [63:0]reg_file10;
// reg [63:0]reg_file11;
// reg [63:0]reg_file12;
// reg [63:0]reg_file13;
// reg [63:0]reg_file14;
// reg [63:0]reg_file15;

wire [63:0]reg_wire0;
wire [63:0]reg_wire1;
wire [63:0]reg_wire2;
wire [63:0]reg_wire3;
wire [63:0]reg_wire4;
wire [63:0]reg_wire5;
wire [63:0]reg_wire6;
wire [63:0]reg_wire7;
wire [63:0]reg_wire8;
wire [63:0]reg_wire9;
wire [63:0]reg_wire10;
wire [63:0]reg_wire11;
wire [63:0]reg_wire12;
wire [63:0]reg_wire13;
wire [63:0]reg_wire14;
wire [63:0]reg_wire15;
wire [2:0] cc;
initial begin
    PC = 64'd0;
    Status = 2'b00;
end

Fetch fetch1(clk, PC, icode, ifun, rA, rB, valC, valP, instr_valid, imem_error, hlt);

Decode decode1(icode, valC, ifun, rA, rB, reg_wire0, reg_wire1, reg_wire2, reg_wire3, reg_wire4, reg_wire5, reg_wire6, reg_wire7, reg_wire8, reg_wire9, reg_wire10, reg_wire11, reg_wire12, reg_wire13, reg_wire14, reg_wire15, valA, valB);

Execute execute1(cc,icode,ifun,valA,valB,valC,valE,cond_flag);

mem mem1(valA, valB, valE, valP, icode, valM, clk, dmem_error);

Writeback writeback1(icode, valM, valE, cond_flag, rA, rB, reg_wire0, reg_wire1, reg_wire2, reg_wire3, reg_wire4, reg_wire5, reg_wire6, reg_wire7,  reg_wire8, reg_wire9, reg_wire10, reg_wire11, reg_wire12, reg_wire13, reg_wire14, reg_wire15,clk);

PC_update pc_update1(icode,valP,valC,valM,cond_flag, NextPC,clk);

// always@(*) begin
//     $monitor(PC);
// end

always@(*) begin
    // $monitor(imem_error,dmem_error,hlt,instr_valid);
    Status = 2'b00;
    // $monitor("%b",cc);
    // $monitor("%b, %h",dmem_error,valE);
    if(hlt == 1) begin
        Status = 2'b01;
    end
    else if(imem_error == 1 || dmem_error == 1) begin
        Status = 2'b10;
        // $monitor("%b, %h",dmem_error,valE);
    end
    else if(instr_valid == 0) begin
        Status = 2'b11;
    end
    else begin
        Status = 2'b00;  // AOK
    end
end

// always@(reg_wire0, reg_wire1, reg_wire2, reg_wire3, reg_wire4, reg_wire5, reg_wire6, reg_wire7, reg_wire8, reg_wire9, reg_wire10, reg_wire11, reg_wire12, reg_wire13, reg_wire14, reg_wire15) begin
//     reg_file0=reg_wire0;
//     reg_file1=reg_wire1;
//     reg_file2=reg_wire2;
//     reg_file3=reg_wire3;
//     reg_file4=reg_wire4;
//     reg_file5=reg_wire5;
//     reg_file6=reg_wire6;
//     reg_file7=reg_wire7;
//     reg_file8=reg_wire8;
//     reg_file9=reg_wire9;
//     reg_file10=reg_wire10;
//     reg_file11=reg_wire11;
//     reg_file12=reg_wire12;
//     reg_file13=reg_wire13;
//     reg_file14=reg_wire14;
//     reg_file15=reg_wire15;
// end


always@(*) begin
    PC = NextPC;
end

endmodule