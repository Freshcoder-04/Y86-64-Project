`include "mem.v"
module tb_mem();

reg [63:0] valA, valB, valE, valP;
reg [3:0] icode;
wire [63:0] valM;
reg clk;

mem mem1(valA, valB, valE, valP, icode, valM, clk);
    // Test cases

    always #5 clk = ~clk;

    initial begin
        clk = 0;    
        // Case 1
        icode = 4'b0010;
        valA = 64'd100;
        valB = 64'd200;
        valE = 64'd300;
        valP = 64'd400;

        // Case 2
        #10; // Wait for 10 time units
        icode = 4'b0011;
        valA = 64'd150;
        valB = 64'd250;
        valE = 64'd350;
        valP = 64'd450;

        // Case 3
        #10;
        icode = 4'b0100;
        valA = 64'd200;
        valB = 64'd300;
        valE = 64'd400;
        valP = 64'd500;

        // Case 4
        #10;
        icode = 4'b0101;
        valA = 64'd250;
        valB = 64'd350;
        valE = 64'd450;
        valP = 64'd550;

        // Case 5
        #10;
        icode = 4'b1010;
        valA = 64'd300;
        valB = 64'd400;
        valE = 64'd500;
        valP = 64'd600;

        // Case 6
        #10;
        icode = 4'b1011;
        valA = 64'd350;
        valB = 64'd450;
        valE = 64'd550;
        valP = 64'd650;

        // Case 7
        #10;
        icode = 4'b1000;
        valA = 64'd400;
        valB = 64'd500;
        valE = 64'd600;
        valP = 64'd700;

        // Case 8
        #10;
        icode = 4'b1001;
        valA = 64'd450;
        valB = 64'd550;
        valE = 64'd650;
        valP = 64'd750;

        #100; // Run simulation for 100 time units
        $finish; // End simulation
    end


    // Dump variables
    initial begin
        $dumpfile("tb_mem.vcd");
        $dumpvars(0, tb_mem);
        $monitor("completed.");
        #100; // Wait for signals to settle
    end

endmodule
