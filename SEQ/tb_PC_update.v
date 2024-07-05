`include "PC_update.v"

module tb_PC_update();

reg clk;
reg cond_flag;
reg [3:0] icode, ifun;
reg [63:0] valP, valC, valM;

wire [63:0] NextPC;

PC_update PC_update1(icode,valP,valC,valM,cond_flag, NextPC);

initial begin
    clk = 0;
end

always #5 clk = ~clk;

initial begin

    // 2-> rrmov
    icode = 4'b0010;
    ifun = 4'b0000;
    valP = 64'd200;
    valM = 64'd300;
    valC = 64'd0;
    cond_flag = 1;
    #10;

    icode = 4'b0010;
    ifun = 4'b0001;
    valP = 64'd200;
    valM = 64'd300;
    valC = 64'd0;
    cond_flag = 0;
    #10;

    // 3-> irmov
    icode = 4'b0011;
    ifun = 4'b0000;
    valP = 64'b0;
    valM = 64'd12;
    valC = 64'd230;
    #10;

    // 4-> rmmov
    icode = 4'b0100;
    ifun = 4'b0000;
    valP = 64'd10;
    valM = 64'd200;
    valC = 64'd8;
    #10;

    // 5-> mrmov
    icode = 4'b0101;
    ifun = 4'b0000;
    valP = 64'd6;
    valM = 64'd547;
    valC = 64'd16;
    #10;
    cond_flag = 0;
    // 6-> OP
    icode = 4'b0110;
    ifun = 4'b0000;
    valP = 64'b1010;
    valM = 64'b1111;
    valC = 64'b0;
    #10;

    icode = 4'b0110;
    ifun = 4'b0001;
    valP = 64'b1010;
    valM = 64'b11111;
    valC = 64'b0;
    #10;

    icode = 4'b0110;
    ifun = 4'b0010;
    valP = 64'b1010;
    valM = 64'b0101;
    valC = 64'b0;
    #10;

    icode = 4'b0110;
    ifun = 4'b0011;
    valP = 64'b1100;
    valM = 64'b0100;
    valC = 64'b0;
    #10;

    // 7-> jxx
    icode = 4'b0111;
    ifun = 4'b0000;
    valP = 64'd243;
    valM = 64'd555;
    valC = 64'd423;
    cond_flag = 0;
    #10;

    icode = 4'b0111;
    ifun = 4'b0001;
    valP = 64'd243;
    valM = 64'd555;
    valC = 64'd423;
    cond_flag = 1;
    #10;

    icode = 4'b0111;
    ifun = 4'b0010;
    valP = 64'd243;
    valM = 64'd555;
    valC = 64'd400;
    #10;

    icode = 4'b0111;
    ifun = 4'b0011;
    valP = 64'd243;
    valM = 64'd555;
    valC = 64'd290;
    #10;

    icode = 4'b0111;
    ifun = 4'b0100;
    valP = 64'd243;
    valM = 64'd555;
    valC = 64'd909;
    cond_flag = 0;
    #10;

    icode = 4'b0111;
    ifun = 4'b0101;
    valP = 64'd243;
    valM = 64'd555;
    valC = 64'd677;
    #10;

    icode = 4'b0111;
    ifun = 4'b0110;
    valP = 64'd243;
    valM = 64'd555;
    valC = 64'd1003;
    #10;

    // 8-> call
    icode = 4'b1000;
    ifun = 4'b0000;
    valP = 64'd243;
    valM = 64'd555;
    valC = 64'd325;
    #10;

    // 9-> ret
    icode = 4'b1001;
    ifun = 4'b0000;
    valP = 64'd243;
    valM = 64'd555;
    valC = 64'b0000;
    #10;

    // 10-> push
    icode = 4'b1010;
    ifun = 4'b0000;
    valP = 64'd10;
    valM = 64'd555;
    valC = 64'b0000;
    #10;

    // 11-> pop
    icode = 4'b1011;
    ifun = 4'b0000;
    valP = 64'd6;
    valM = 64'd555;
    valC = 64'b0000;
    #10;
end

initial 
begin
    $dumpfile("tb_PC_update.vcd");
    $dumpvars(0,tb_PC_update);
    $monitor("test complete.");
    #120 $finish;                                                   
end

endmodule