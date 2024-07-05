module Fetch(clk, M_valA, W_valM, M_Cnd, D_rA, D_rB, E_icode, E_dstM, D_icode, M_icode, W_icode, f_icode, f_ifun, f_rA, f_rB, f_valC, f_valP, f_stat, F_stall,f_PC,F_predPC,f_predPC,f_prevPC);

input clk, M_Cnd;
input [63:0]  M_valA, W_valM;
input [3:0] D_rA, D_rB, D_icode, E_icode, M_icode, E_dstM, W_icode ;

input [63:0] F_predPC;
reg [7:0] instr_memory [0:255] ;
reg [0:63] temp_valC;
output reg [63:0] f_PC, f_predPC,f_prevPC;
reg imem_error, instr_valid, hlt;
input wire F_stall;
reg flag;
output reg [3:0] f_icode, f_ifun, f_rA, f_rB;  
output reg [63:0] f_valP, f_valC ;
output reg [1:0] f_stat;   // stat -> 00 (AOK), 01 (HLT), 10 (ADR), 11 (INS)


reg [0:79] instr_reg;  // instruction can vary from 1 to 10 bytes (80 bits)

initial begin
    $readmemb("6.txt",instr_memory);
    // f_valP=0;
    f_stat = 2'b00;
    instr_valid = 1;
    imem_error = 0;
    hlt = 0;
    f_predPC = 64'd0;
    // F_predPC = 64'd0;
    f_PC = 64'd0;     // ------> instead initialise F_predPC in processor
    flag = 0;
end


always@(negedge clk) begin
    f_prevPC = f_PC;
end

// always@(*) begin
//     if(!F_stall && flag != 0) begin
//         // SelectPC logic
//         if(M_icode == 4'b0111 && M_Cnd == 0) begin
//             f_PC = M_valA;
//         end
//         else if(W_icode == 4'b1001) begin
//             f_PC = W_valM;
//         end
//         else begin
//             f_PC = F_predPC;
//         end
//     end
//     flag = 1;
// end

always@(*) begin    // F_predPC,M_Cnd,M_icode,W_icode
    // if(F_stall) begin
    //     f_predPC = f_PC;
    // end
    hlt = 0;
    f_stat = 2'b00;
    instr_valid = 1;
    imem_error = 0;
    // if(F_stall) begin
    //     f_PC = f_prevPC;
    // end
    if(!F_stall && flag != 0) begin
        // SelectPC logic
        if(M_icode == 4'b0111 && M_Cnd == 0) begin
            f_PC = M_valA;
        end
        else if(W_icode == 4'b1001) begin
            f_PC = W_valM;
        end
        else begin
            f_PC = F_predPC;
        end
    end
    flag = 1;
    // if(!F_stall) begin
        // $display(f_PC);
        // f_valP=0; 
    if(!(f_PC>=0 && f_PC+9<=255)) begin
        imem_error=1;
        // $display("%b",f_PC);
    end

    else begin
        imem_error = 0;
        // instr_valid = 1;
        instr_reg = {instr_memory[f_PC], instr_memory[f_PC+1], instr_memory[f_PC+2], instr_memory[f_PC+3], instr_memory[f_PC+4], instr_memory[f_PC+5], instr_memory[f_PC+6], instr_memory[f_PC+7], instr_memory[f_PC+8], instr_memory[f_PC+9]};
        f_icode=instr_reg[0:3];
        // $display("%b",f_PC);
        f_ifun=instr_reg[4:7];

        // if(hlt) begin
        //     f_icode = 4'd1;
        //     f_ifun = 4'd0;
        //     f_rA = 4'hF;
        //     f_rB = 4'hf;
        //     f_PC = 64'd0;
        // end
        // else begin
            if(f_icode == 4'b0000 && f_ifun == 4'd0) begin // nop
                f_valP=f_PC + 64'd1;
                f_rA = 4'hf;
                f_rB = 4'hf;
                f_valC = 64'd0;
            end

            else if(f_icode == 4'b0001 && f_ifun == 4'd0) begin  // halt
                f_valP=f_PC + 64'd1;
                f_rA = 4'hf;
                f_rB = 4'hf;
                f_valC = 64'd0;
                hlt=1;
                // $finish;
            end

            else if(f_icode == 4'b0110 && (f_ifun == 4'd0 || f_ifun == 4'd1 || f_ifun == 4'd2 || f_ifun == 4'd3)) begin  // 6 fn OPxx 
                f_rA=instr_reg[8:11];  // source
                f_rB=instr_reg[12:15];  // dest
                // $display(f_icode);
                f_valP = f_PC + 64'd2;
                f_valC = 64'd0;
            end

            else if(f_icode == 4'b0010 && (f_ifun == 4'd0 || f_ifun == 4'd1 || f_ifun == 4'd2 || f_ifun == 4'd3 || f_ifun == 4'd4
            || f_ifun == 4'd5 || f_ifun == 4'd6)) 
            begin // 2 fn
                f_rA=instr_reg[8:11];  // source
                f_rB=instr_reg[12:15];  // dest
                f_valP = f_PC + 64'd2;
                f_valC = 64'd0;
            end

            else if(f_icode == 4'b0011 && (f_ifun == 4'd0))begin  // 3 0 irmov operation
                f_rA=instr_reg[8:11];  // source
                f_rB=instr_reg[12:15];  // dest


                temp_valC[0:7] = instr_reg[72:79];
                temp_valC[8:15] = instr_reg[64:71];
                temp_valC[16:23] = instr_reg[56:63];
                temp_valC[24:31] = instr_reg[48:55];
                temp_valC[32:39] = instr_reg[40:47];
                temp_valC[40:47] = instr_reg[32:39];
                temp_valC[48:55] = instr_reg[24:31];
                temp_valC[56:63] = instr_reg[16:23];

                f_valC[63:0] = temp_valC[0:63];

                
                // f_valC=instr_reg[16:79];
                f_valP=f_PC + 64'd10;
            end

            else if(f_icode == 4'b0100 && f_ifun == 4'd0)begin  // 4 0 rmmov operation
                f_rA=instr_reg[8:11];  // source
                f_rB=instr_reg[12:15];  // dest
                temp_valC[0:7] = instr_reg[72:79];
                temp_valC[8:15] = instr_reg[64:71];
                temp_valC[16:23] = instr_reg[56:63];
                temp_valC[24:31] = instr_reg[48:55];
                temp_valC[32:39] = instr_reg[40:47];
                temp_valC[40:47] = instr_reg[32:39];
                temp_valC[48:55] = instr_reg[24:31];
                temp_valC[56:63] = instr_reg[16:23];

                f_valC[63:0] = temp_valC[0:63];
                f_valP=f_PC + 64'd10;
            end

            else if(f_icode == 4'b0101 && f_ifun == 4'd0)begin  // 5 0 mrmov operation
                f_rA=instr_reg[8:11];  // source
                f_rB=instr_reg[12:15];  // dest
                temp_valC[0:7] = instr_reg[72:79];
                temp_valC[8:15] = instr_reg[64:71];
                temp_valC[16:23] = instr_reg[56:63];
                temp_valC[24:31] = instr_reg[48:55];
                temp_valC[32:39] = instr_reg[40:47];
                temp_valC[40:47] = instr_reg[32:39];
                temp_valC[48:55] = instr_reg[24:31];
                temp_valC[56:63] = instr_reg[16:23];

                f_valC[63:0] = temp_valC[0:63];

                f_valP=f_PC + 64'd10;
            end

            else if(f_icode==4'b1000 && f_ifun == 4'd0) begin   // call 8 0
                temp_valC[0:7] = instr_reg[64:71];
                temp_valC[8:15] = instr_reg[56:63];
                temp_valC[16:23] = instr_reg[48:55];
                temp_valC[24:31] = instr_reg[40:47];
                temp_valC[32:39] = instr_reg[32:39];
                temp_valC[40:47] = instr_reg[24:31];
                temp_valC[48:55] = instr_reg[16:23];
                temp_valC[56:63] = instr_reg[8:15];

                f_valC[63:0] = temp_valC[0:63];
                f_valP=f_PC + 64'd9;
                f_rA = 4'hf;
                f_rB = 4'd4;
            end

            else if(f_icode==4'b1010 && f_ifun == 4'd0)  begin // push         
                f_rA=instr_reg[8:11];  // source
                f_rB = 4'd4;  // dest
                f_valP = f_PC + 64'd2;
                f_valC = 64'd0;
                
            end   

            else if((f_icode==4'b1011 || f_icode==4'b1001) && f_ifun == 4'd0)  begin   // 9 0 ret, B 0 pop 
                f_rA=instr_reg[8:11];  // source
                f_rB=4'd4;  // dest
                f_valP = f_PC + 64'd2;
                f_valC = 64'd0;
            end   

            else if(f_icode == 4'b0111 && (f_ifun == 4'd0 || f_ifun == 4'd1 || f_ifun == 4'd2 || f_ifun == 4'd3 || f_ifun == 4'd4
            || f_ifun == 4'd5 || f_ifun == 4'd6))
            begin  // 7 0
                temp_valC[0:7] = instr_reg[64:71];
                temp_valC[8:15] = instr_reg[56:63];
                temp_valC[16:23] = instr_reg[48:55];
                temp_valC[24:31] = instr_reg[40:47];
                temp_valC[32:39] = instr_reg[32:39];
                temp_valC[40:47] = instr_reg[24:31];
                temp_valC[48:55] = instr_reg[16:23];
                temp_valC[56:63] = instr_reg[8:15];

                f_valC[63:0] = temp_valC[0:63];

                f_valP=f_PC + 64'd9;
                f_rA = 4'hf;
                f_rB = 4'hf;
            end

            else begin
                instr_valid=0; // invalid instruction
            end
        // end
        
    end
end

always@(*) begin //f_valC,f_valP
    if(!F_stall) begin
        if(f_icode == 4'b0111 || f_icode == 4'b1000)begin // jxx
            f_predPC = f_valC;
        end
        else begin
            f_predPC = f_valP;
        end
    end
    else begin
        f_predPC = F_predPC;
    end
end
// always@(posedge clk) begin
//     if(F_stall) begin
//         f_PC = F_predPC;
//     end
// end

always@(*) begin
    if(!F_stall) begin
        f_stat = 2'd0;
        if(imem_error == 1) begin
            f_stat = 2'b10;
        end
        else if(instr_valid == 0) begin
            f_stat = 2'b11;
        end
        else if(hlt == 1) begin
            f_stat = 2'b01;             // hlt
        end
        else
            f_stat = 2'b00;
    end
end

// always@(negedge clk) begin
//     if(((E_icode == 4'b0101 || E_icode == 4'b1011) && (E_dstM == D_rA || E_dstM == D_rB)) || 
//         (D_icode == 4'b1001 || E_icode == 4'b1001 || M_icode == 4'b1001) ) begin
//         F_stall = 1;
//     end
//     else begin
//         F_stall = 0;
//     end
// end

endmodule