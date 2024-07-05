`include "Decode.v"
module tb_Decode();

reg [3:0] icode, rA, rB;   // nop and halt implement!!!!!!
reg clk;
reg [63:0]reg0;
reg [63:0]reg1;
reg [63:0]reg2;
reg [63:0]reg3;
reg [63:0]reg4;
reg [63:0]reg5;
reg [63:0]reg6;
reg [63:0]reg7;
reg [63:0]reg8;
reg [63:0]reg9;
reg [63:0]reg10;
reg [63:0]reg11;
reg [63:0]reg12;
reg [63:0]reg13;
reg [63:0]reg14;
reg [63:0]reg15;

wire [63:0] valA, valB;

Decode decode1(clk, icode, rA, rB, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15, valA, valB);



    // Test cases
    initial begin
        // Initialize inputs
        icode = 4'b0000;
        rA = 4'b0000;
        rB = 4'b0000;
        reg0 = 64'h1C;
        reg1 = 64'hA61;
        reg2 = 64'h9F;
        reg3 = 64'h100;
        reg4 = 64'hA1BC;    // stack pointer (rsp)
        reg5 = 64'h1C;
        reg6 = 64'h508;
        reg7 = 64'h67A;
        reg8 = 64'h4;
        reg9 = 64'h239;
        reg10 = 64'hF2;
        reg11 = 64'h36;
        reg12 = 64'h2E2;
        reg13 = 64'h7ADFD;
        reg14 = 64'hDE2;
        reg15 = 64'h0;  // denotes "no register"
        clk = 0;
    end

    always # 5 clk <= ~clk;

    initial begin
            // Case 1: icode = 2 (cmov)
            icode = 4'b0010;
            rA = 4'b0001;
            rB = 4'b0010;
            #10;

            // Case 2: icode = 3 (irmov)
            icode = 4'b0011;
            rA = 4'b0001;
            rB = 4'b0010;
            #10;

            // Case 3: icode = 4 (rmmov)
            icode = 4'b0100;
            rA = 4'b0001;
            rB = 4'b0010;
            #10;

            // Case 4: icode = 5 (mrmov)
            icode = 4'b0101;
            rA = 4'b0001;
            rB = 4'b0010;
            #10;

            // Case 5: icode = 6 (opxx)
            icode = 4'b0110;
            rA = 4'b0001;
            rB = 4'b0010;
            #10;

            // Case 6: icode = 7 (jmp)
            icode = 4'b0111;
            rA = 4'b0001;
            rB = 4'b0010;
            #10;

            // Case 7: icode = 8 (call)
            icode = 4'b1000;
            rA = 4'b0001;
            rB = 4'b0010;
            #10;

            // Case 8: icode = 9 (ret)
            icode = 4'b1001;
            rA = 4'b0001;
            rB = 4'b0010;
            #10;

            // Case 9: icode = A (push)
            icode = 4'b1010;
            rA = 4'b0001;
            rB = 4'b0010;
            #10;

            // Case 10: icode = B (pop)
            icode = 4'b1011;
            rA = 4'b0001;
            rB = 4'b0010;  
            #10;

            // Add more test cases as needed
            
            $finish;
        
    end

    // Dump variables
    initial begin
        $dumpfile("tb_Decode.vcd");
        $dumpvars(0, tb_Decode);
        $monitor("completed.");
        #100; // Wait for signals to settle
    end

endmodule
