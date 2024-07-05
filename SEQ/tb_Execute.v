`include "Execute.v"

module tb_Execute();

reg [3:0] icode, ifun;
reg [63:0] valA, valB, valC;

wire cond_flag;
wire [63:0] valE;

Execute Execute1(icode,ifun,valA,valB,valC, valE,cond_flag);

// initial begin
    
// end

// always #5 clk = ~clk;

initial begin
    #10;
    // 2-> rrmov
    icode = 4'b0011;
    ifun = 4'b0000;
    valA = 64'b0;
    valB = 64'd12;
    valC = 64'd230;
    #10;
    
    icode = 4'b0010;
    ifun = 4'b0000;
    valA = 64'd200;
    valB = 64'd300;
    valC = 64'd0;
    #10;

    icode = 4'b0010;
    ifun = 4'b0001;
    valA = 64'd200;
    valB = 64'd300;
    valC = 64'd0;
    #10;

    // 3-> irmov
    

    // 4-> rmmov
    icode = 4'b0100;
    ifun = 4'b0000;
    valA = 64'd10;
    valB = 64'd200;
    valC = 64'd8;
    #10;

    // 5-> mrmov
    icode = 4'b0101;
    ifun = 4'b0000;
    valA = 64'd6;
    valB = 64'd547;
    valC = 64'd16;
    #10;

    // 6-> OP
    icode = 4'b0110;
    ifun = 4'b0000;
    valA = 64'b1010;
    valB = 64'b1111;
    valC = 64'b0;
    #10;

    icode = 4'b0110;
    ifun = 4'b0001;
    valA = 64'b1010;
    valB = 64'b11111;
    valC = 64'b0;
    #10;

    icode = 4'b0110;
    ifun = 4'b0010;
    valA = 64'b1010;
    valB = 64'b0101;
    valC = 64'b0;
    #10;

    icode = 4'b0110;
    ifun = 4'b0011;
    valA = 64'b1100;
    valB = 64'b0100;
    valC = 64'b0;
    #10;

    // 7-> jxx
    icode = 4'b0111;
    ifun = 4'b0000;
    valA = 64'b0000;
    valB = 64'b0000;
    valC = 64'd423;
    #10;

    icode = 4'b0111;
    ifun = 4'b0001;
    valA = 64'b0000;
    valB = 64'b0000;
    valC = 64'd423;
    #10;

    icode = 4'b0111;
    ifun = 4'b0010;
    valA = 64'b0000;
    valB = 64'b0000;
    valC = 64'd400;
    #10;

    icode = 4'b0111;
    ifun = 4'b0011;
    valA = 64'b0000;
    valB = 64'b0000;
    valC = 64'd290;
    #10;

    icode = 4'b0111;
    ifun = 4'b0100;
    valA = 64'b0000;
    valB = 64'b0000;
    valC = 64'd909;
    #10;

    icode = 4'b0111;
    ifun = 4'b0101;
    valA = 64'b0000;
    valB = 64'b0000;
    valC = 64'd677;
    #10;

    icode = 4'b0111;
    ifun = 4'b0110;
    valA = 64'b0000;
    valB = 64'b0000;
    valC = 64'd1003;
    #10;

    // 8-> call
    icode = 4'b1000;
    ifun = 4'b0000;
    valA = 64'b0000;
    valB = 64'b0000;
    valC = 64'd325;
    #10;

    // 9-> ret
    icode = 4'b1001;
    ifun = 4'b0000;
    valA = 64'b0000;
    valB = 64'b0000;
    valC = 64'b0000;
    #10;

    // 10-> push
    icode = 4'b1010;
    ifun = 4'b0000;
    valA = 64'd10;
    valB = 64'b0000;
    valC = 64'b0000;
    #10;

    // 11-> pop
    icode = 4'b1011;
    ifun = 4'b0000;
    valA = 64'd6;
    valB = 64'b0000;
    valC = 64'b0000;
    #10;
end

initial 
begin
    $dumpfile("tb_Execute.vcd");
    $dumpvars(0,tb_Execute);
    $monitor("test complete.");
    #300 $finish;                                                   
end

endmodule