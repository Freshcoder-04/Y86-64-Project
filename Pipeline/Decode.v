module Decode(M_dstE,e_dstE,e_valE,M_dstM,m_valM,M_valE,W_valM,W_dstE,W_valE,D_icode, D_stall,D_stat, D_ifun, D_rA, D_rB, D_valP, D_valC,E_icode, E_dstM,e_Cnd,reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, reg9, reg10, reg11, reg12, reg13, reg14, reg15, d_valA, d_valB, d_dstE, d_dstM,d_stat, D_bubble,d_icode,d_ifun,d_rA,d_rB,d_valC);

input wire clk;
input wire [3:0] D_icode, D_rA, D_rB, D_ifun, M_icode, E_icode, E_dstM;
input wire e_Cnd;
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

input wire [3:0] e_dstE,M_dstM,W_dstE,M_dstE,W_dstM;


input wire [1:0] D_stat;
input wire D_stall;

input wire [63:0] D_valP,e_valE,m_valM,M_valE,W_valM,W_valE,D_valC;
input wire D_bubble;
output reg [3:0] d_dstE, d_dstM, d_icode, d_ifun, d_rA, d_rB;
output reg [63:0] d_valA, d_valB, d_valC;
output reg [1:0] d_stat;

reg [63:0] temp_register_array [0:15];

initial begin
    d_valA = 64'b0;
    d_valB = 64'b0;
end

// always @ (negedge clk) begin      // ******* not sure if correct *******
    
// end

always@(*) begin
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

always@(*) begin    //D_rA,D_rB,D_icode,D_ifun,D_valC,e_dstE,M_dstM,W_dstM,W_dstE,e_valE,m_valM,M_valE,W_valM,W_valE
    /*
    get d_valA, d_valB from D_rA D_rB acc to D_icode
    */
    d_stat = D_stat;
    // d_valA = 64'd0;
    // d_valB = 64'd0;
    // d_valC = 64'd0;
    // d_rA = 4'hF;
    // d_rB = 4'hF;
    d_dstE = 4'hF;
    d_dstM = 4'hF;
    if(!D_stall) begin
        

        // if((D_icode == 4'b0111 || D_icode == 4'b1000)|| e_dstE == D_rA || M_dstM == D_rA || M_dstE == D_rA || W_dstM == D_rA || W_dstE == D_rA || e_dstE == D_rB || M_dstM == D_rB || M_dstE == D_rB || W_dstM == D_rB || W_dstE == D_rB)
        if(D_icode == 4'b0010) begin      // 2 fn cmov
            d_valA = temp_register_array[D_rA];
            d_valB = temp_register_array[D_rB];
            d_dstE = D_rB;
            d_dstM = 4'd15;
        end

        else if(D_icode == 4'b0000) begin
            d_valA = 64'd0;
            d_valB = 64'd0;
            d_dstE = 4'hF;
            d_dstE = 4'hF;
        end

        else if(D_icode == 4'b0001) begin
            d_valA = 64'd0;
            d_valB = 64'd0;
            d_dstE = 4'hF;
            d_dstE = 4'hF;
        end

        else if(D_icode == 4'b0011) begin      // 3 0 irmov
            d_valA = 64'd0;   // F - no register (imm value)
            d_valB = temp_register_array[D_rB];
            d_dstE = D_rB;
            d_dstM = 4'd15;
        end
    
        else if(D_icode == 4'b0100) begin      // 4 rmmov
            d_valA = temp_register_array[D_rA];
            d_valB = temp_register_array[D_rB];
            d_dstM = 4'd15;
            d_dstE = 4'd15;
        end
        
        else if(D_icode == 4'b0101) begin      // 5 mrmov
            d_valA = temp_register_array[D_rA];
            d_valB = temp_register_array[D_rB];
            d_dstE = 4'd15;
            d_dstM = D_rA;
        end

        else if(D_icode == 4'b0110) begin      // 6 opxx
            d_valA = temp_register_array[D_rA];
            d_valB = temp_register_array[D_rB];
            d_dstE = D_rB;
            d_dstM = 4'd15;
        end

        else if(D_icode == 4'b0111) begin      // 7 jmp  no register used 
            d_valA = D_valP;
            d_valB = 64'd0;
            d_dstM = 4'd15;
            d_dstE = 4'd15;
        end

        else if(D_icode == 4'b1000) begin      // 8 call
            d_valA = D_valP;
            d_valB = temp_register_array[D_rB];
            d_dstE = D_rB;
            d_dstM = 4'd15;
        end

        else if(D_icode == 4'b1001) begin      // 9 ret
            d_valA = 64'd0;
            d_valB = temp_register_array[D_rB];
            d_dstE = D_rB;
            d_dstM = 4'd15;
        end

        else if(D_icode == 4'b1010) begin      // A 0 push
            d_valA = temp_register_array[D_rA];
            d_valB = temp_register_array[D_rB];
            d_dstM = 4'd15;
            d_dstE = D_rB;
        end

        else if(D_icode == 4'b1011) begin      // B 0 pop
            d_valA = temp_register_array[D_rA];
            d_valB = temp_register_array[D_rB];
            d_dstE = D_rB;
            d_dstM = D_rA;
        end

        // Data forwarding ( with priority )
        if(D_icode == 4'b0111 || D_icode == 4'b1000) begin
            d_valA = D_valP; // Use inceremnted PC
        end
        else if(e_dstE == D_rA && D_rA != 4'hF)begin
            d_valA = e_valE; // Forward valE from Execute
        end
        else if(M_dstM == D_rA && D_rA != 4'hF) begin
            d_valA = m_valM; // Forward valM from memory
        end
        else if(M_dstE == D_rA && D_rA != 4'hF) begin
            d_valA = M_valE; // Forward valE from memory
        end
        else if(W_dstM == D_rA && D_rA != 4'hF) begin
            d_valA = W_valM; // Forward valM from writeback
        end
        else if(W_dstE == D_rA && D_rA != 4'hF)begin
            d_valA = W_valE; // Forward valE from writeback
        end

        if(e_dstE == D_rB && D_rB != 4'hF) begin
            d_valB = e_valE;
        end
        else if(M_dstM == D_rB && D_rB != 4'hF) begin
            d_valB = m_valM;
        end
        else if(M_dstE == D_rB && D_rB != 4'hF) begin
            d_valB = M_valE; // Forward valE from memory
        end
        else if(W_dstM == D_rB && D_rB != 4'hF) begin
            d_valB = W_valM; // Forward valM from writeback
        end
        else if(W_dstE == D_rB && D_rB != 4'hF)begin
            d_valB = W_valE; // Forward valE from writeback
        end

        

        // d_icode = D_icode;
        // d_ifun = D_ifun;
        // d_rA = D_rA;
        // d_rB = D_rB;
        // d_valC = D_valC;
    end
end


always@(*) begin
    d_icode = D_icode;
    d_ifun = D_ifun;
    d_rA = D_rA;
    d_rB = D_rB;
    d_valC = D_valC;
end


endmodule