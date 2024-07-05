module Decode(icode, valC, ifun,rA, rB, reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15, valA, valB);

input wire [3:0] icode, rA, rB, ifun;   

input wire [63:0]reg0;
input wire [63:0]reg1;
input wire [63:0]reg2;
input wire [63:0]reg3;
input wire [63:0]reg4;
input wire [63:0]reg5;
input wire [63:0]reg6;
input wire [63:0]reg7;
input wire [63:0]reg8;
input wire [63:0]reg9;
input wire [63:0]reg10;
input wire [63:0]reg11;
input wire [63:0]reg12;
input wire [63:0]reg13;
input wire [63:0]reg14;
input wire [63:0]reg15;

input wire [63:0]valC;
output reg [63:0] valA, valB;

reg [63:0] temp_register_array [0:15];   // for easy access 

initial begin
    valA = 64'b0;
    valB = 64'b0;
end

always@(rA,rB,icode,ifun) begin
    
    /* 

    get valA, valB from rA rB acc to icode
    
    */

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

    if(icode == 4'b0010) begin      // 2 fn cmov
        valA = temp_register_array[rA];
        valB = temp_register_array[rB];
    end

    else if(icode == 4'b0011) begin      // 3 0 irmov
        valA = temp_register_array[15];   // F - no register (imm value)
        valB = temp_register_array[rB];
    end

    else if(icode == 4'b0100) begin      // 4 rmmov
        valA = temp_register_array[rA];
        valB = temp_register_array[rB];
    end
    
    else if(icode == 4'b0101) begin      // 5 mrmov
        valA = temp_register_array[rA];
        valB = temp_register_array[rB];
    end

    else if(icode == 4'b0110) begin      // 6 opxx
        valA = temp_register_array[rA];
        valB = temp_register_array[rB];
    end

    else if(icode == 4'b0111) begin      // 7 jmp  no register used 
        valA = temp_register_array[15];
        valB = temp_register_array[15];
    end

    else if(icode == 4'b1000) begin      // 8 call
        valA = temp_register_array[15];
        valB = temp_register_array[4];
    end

    else if(icode == 4'b1001) begin      // 9 ret
        valA = temp_register_array[15];
        valB = temp_register_array[4];
    end

    else if(icode == 4'b1010) begin      // A 0 push
        valA = temp_register_array[rA];
        valB = temp_register_array[4];
    end

    else if(icode == 4'b1011) begin      // B 0 pop
        valA = temp_register_array[rA];
        valB = temp_register_array[4];
    end

end
endmodule