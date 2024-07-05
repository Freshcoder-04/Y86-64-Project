module Writeback(icode, valM, valE, cond_flag, rA, rB,
                reg0, reg1, reg2, reg3, reg4,
                reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13,
                reg14, reg15, clk);

input wire [3:0] icode;
input wire [63:0] valM, valE;
input wire cond_flag;
input wire [3:0] rA, rB;
input wire clk;

reg [3:0]dstE, dstM;

output reg [63:0]reg0;
output reg [63:0]reg1;
output reg [63:0]reg2;
output reg [63:0]reg3;
output reg [63:0]reg4;
output reg [63:0]reg5;
output reg [63:0]reg6;
output reg [63:0]reg7;
output reg [63:0]reg8;
output reg [63:0]reg9;
output reg [63:0]reg10;
output reg [63:0]reg11;
output reg [63:0]reg12;
output reg [63:0]reg13;
output reg [63:0]reg14;
output reg [63:0]reg15;

reg [63:0] temp_register_array [0:15]; // for easy access

initial begin
    temp_register_array[0] = reg0;
    temp_register_array[1] = reg1;
    temp_register_array[2] = reg2;
    temp_register_array[3] = reg3;
    temp_register_array[4] = reg4;
    temp_register_array[5] = reg5;
    temp_register_array[6] = reg6;
    temp_register_array[7] = reg7;
    temp_register_array[8] = reg8;
    temp_register_array[9] = reg9;
    temp_register_array[10] = reg10;
    temp_register_array[11] = reg11;
    temp_register_array[12] = reg12;
    temp_register_array[13] = reg13;
    temp_register_array[14] = reg14;
    temp_register_array[15] = reg15;
    // reg1 = temp_register_array[1];
    // reg2 = temp_register_array[2];
    // reg3 = temp_register_array[3];
    // reg4 = temp_register_array[4];
    // reg5 = temp_register_array[5];
    // reg6 = temp_register_array[6];
    // reg7 = temp_register_array[7];
    // reg8 = temp_register_array[8];
    // reg9 = temp_register_array[9];
    // reg10 = temp_register_array[10];
    // reg11 = temp_register_array[11];
    // reg12 = temp_register_array[12];
    // reg13 = temp_register_array[13];
    // reg14 = temp_register_array[14];
    // reg15 = temp_register_array[15];
end

always@(*) begin

    // dstE logic
    if(icode == 4'b0010) begin  // 2 fn
        if(cond_flag) begin
            dstE = rB;
            temp_register_array[dstE] = valE;
        end
        else begin
            dstE = 4'd15;
        end
    end

    if(icode == 4'b0110)begin // Arithmetic (update destination register)
        dstE = rB;
        temp_register_array[dstE] = valE;
    end
    // else if(icode == 4'b0010 && cond_flag == 1)begin // rrmov or cmov (update destination register)
    //     temp_register_array[dstE] = valE;
    // end
    else if(icode == 4'b0101)begin
        dstM = rA;
        temp_register_array[dstM] = valM;
    end
    else if(icode == 4'b0011)begin // irmov (update destination register)
        dstE = rB;
        temp_register_array[dstE] = valE;
    end
    else if(icode == 4'b1010)begin // push (update stack pointer)
        temp_register_array[4] = valE;
    end
    else if(icode == 4'b1011)begin // pop (update stack pointer, write result to register)
        dstE = rB;
        temp_register_array[dstE] = valM;
        temp_register_array[4] = valE;
    end
    else if(icode == 4'b1000)begin // call (update stack pointer)
        temp_register_array[4] = valE;
    end
    else if(icode == 4'b1001)begin // ret (update stack pointer)
        temp_register_array[4] = valE;
    end
    

end
always@(*) begin
    reg0 = temp_register_array[0];
    reg1 = temp_register_array[1];
    reg2 = temp_register_array[2];
    reg3 = temp_register_array[3];
    reg4 = temp_register_array[4];
    reg5 = temp_register_array[5];
    reg6 = temp_register_array[6];
    reg7 = temp_register_array[7];
    reg8 = temp_register_array[8];
    reg9 = temp_register_array[9];
    reg10 = temp_register_array[10];
    reg11 = temp_register_array[11];
    reg12 = temp_register_array[12];
    reg13 = temp_register_array[13];
    reg14 = temp_register_array[14];
    reg15 = temp_register_array[15];
end

endmodule