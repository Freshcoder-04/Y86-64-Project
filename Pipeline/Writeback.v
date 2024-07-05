module Writeback(W_icode, W_valM, W_valE, W_dstE, W_dstM, W_stat,w_stat,reg0, reg1, reg2, reg3, reg4,reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15, clk);

input wire [3:0] W_icode;
input wire [63:0] W_valM, W_valE;
input wire clk;
input wire [1:0] W_stat;
input wire [3:0] W_dstE, W_dstM;

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

output reg [1:0] w_stat;

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
end

always@(*) begin     // W_icode,W_valM,W_valE
    w_stat = W_stat;

    // if(!W_bubble) begin
        if(W_icode == 4'b0010 && W_dstE != 4'd15) begin  // 2 fn
            temp_register_array[W_dstE] = W_valE;
        end

        if(W_icode == 4'b0110 && W_dstE != 4'd15)begin // Arithmetic (update destination register)
            temp_register_array[W_dstE] = W_valE;
        end
        else if(W_icode == 4'b0101)begin // mrmovq
            temp_register_array[W_dstM] = W_valM;
        end
        else if(W_icode == 4'b0011 && W_dstE != 4'd15)begin // irmov (update destination register)
            temp_register_array[W_dstE] = W_valE;
        end
        else if(W_icode == 4'b1010)begin // push (update stack pointer)
            temp_register_array[4] = W_valE;
        end
        else if(W_icode == 4'b1011 && W_dstE != 4'd15)begin // pop (update stack pointer, write result to register)
            temp_register_array[W_dstE] = W_valM;
            temp_register_array[4] = W_valE;
        end
        else if(W_icode == 4'b1000)begin // call (update stack pointer)
            temp_register_array[4] = W_valE;
        end
        else if(W_icode == 4'b1001)begin // ret (update stack pointer)
            temp_register_array[4] = W_valE;
        end
    // end
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
// always@(posedge clk) begin
//     reg0 = temp_register_array[0];
//     reg1 = temp_register_array[1];
//     reg2 = temp_register_array[2];
//     reg3 = temp_register_array[3];
//     reg4 = temp_register_array[4];
//     reg5 = temp_register_array[5];
//     reg6 = temp_register_array[6];
//     reg7 = temp_register_array[7];
//     reg8 = temp_register_array[8];
//     reg9 = temp_register_array[9];
//     reg10 = temp_register_array[10];
//     reg11 = temp_register_array[11];
//     reg12 = temp_register_array[12];
//     reg13 = temp_register_array[13];
//     reg14 = temp_register_array[14];
//     reg15 = temp_register_array[15];
// end

endmodule