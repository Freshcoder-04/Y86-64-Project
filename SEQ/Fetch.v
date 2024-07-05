module Fetch(clk, PC, icode, ifun, rA, rB, valC, valP, instr_valid, imem_error, hlt);

input clk;
input [63:0] PC;

reg [7:0] instr_memory [0:255] ;
reg [0:63] temp_valC;

output reg [3:0] icode, ifun, rA, rB;
// output reg [0:63] valC;
output reg [63:0] valP, valC;
output reg instr_valid, imem_error, hlt;   // instr_valid -> 1 means valid instruction 0 means invalid

reg [0:79] instr_reg;  // instruction can vary from 1 to 10 bytes (80 bits)

initial begin
    $readmemb("6.txt",instr_memory);
    // fd = $fopen("/Users/masumi/Desktop/Study/Sem4/IPA/IPA_Project/project-team_10/SampleTestcase/1.txt","r");
    valP=0;
    instr_valid=1;
    hlt=0;
    imem_error = 0;
//     instr_memory[0]=8'b01100000; //5 fn
//     instr_memory[1]=8'b00100011; //rA rB

//     instr_memory[2]=8'b00000000; // 1 0
//     instr_memory[3]=8'b00000000; // 1 0
//     instr_memory[4]=8'b00000000; // 1 0

//   //cmovxx
//     instr_memory[5]=8'b00100000; //2 fn
//     instr_memory[6]=8'b00000100; //rA rB

//   //halt
//     instr_memory[7]=8'b00010000; // 1 0
end

always@(posedge clk) begin
    // $display(PC);
    imem_error=0;
    // valP=0; 
    if(!(PC>=0 && PC+9<=255)) begin
        imem_error=1;
        // $display("%b",PC);
    end

    else begin
        imem_error = 0;
        instr_reg = {instr_memory[PC], instr_memory[PC+1], instr_memory[PC+2], instr_memory[PC+3], instr_memory[PC+4], instr_memory[PC+5], instr_memory[PC+6], instr_memory[PC+7], instr_memory[PC+8], instr_memory[PC+9]};
        icode=instr_reg[0:3];
        // $display("%b",PC);
        ifun=instr_reg[4:7];

        if(icode == 4'b0000 && ifun == 4'd0) begin // nop
            valP=PC + 64'd1;
            rA = 4'hf;
            rB = 4'hf;
            valC = 64'd0;
        end

        else if(icode == 4'b0001 && ifun == 4'd0) begin  // halt
            valP=PC + 64'd1;
            rA = 4'hf;
            rB = 4'hf;
            valC = 64'd0;
            hlt=1;
        end

        else if(icode == 4'b0110 && (ifun == 4'd0 || ifun == 4'd1 || ifun == 4'd2 || ifun == 4'd3)) begin  // 6 fn OPxx 
            rA=instr_reg[8:11];  // source
            rB=instr_reg[12:15];  // dest
            // $display(icode);
            valP = PC + 64'd2;
            valC = 64'd0;
        end

        else if(icode == 4'b0010 && (ifun == 4'd0 || ifun == 4'd1 || ifun == 4'd2 || ifun == 4'd3 || ifun == 4'd4
        || ifun == 4'd5 || ifun == 4'd6)) 
        begin // 2 fn
            rA=instr_reg[8:11];  // source
            rB=instr_reg[12:15];  // dest
            valP = PC + 64'd2;
            valC = 64'd0;
        end

        else if(icode == 4'b0011 && (ifun == 4'd0))begin  // 3 0 irmov operation
            rA=instr_reg[8:11];  // source
            rB=instr_reg[12:15];  // dest


            temp_valC[0:7] = instr_reg[72:79];
            temp_valC[8:15] = instr_reg[64:71];
            temp_valC[16:23] = instr_reg[56:63];
            temp_valC[24:31] = instr_reg[48:55];
            temp_valC[32:39] = instr_reg[40:47];
            temp_valC[40:47] = instr_reg[32:39];
            temp_valC[48:55] = instr_reg[24:31];
            temp_valC[56:63] = instr_reg[16:23];

            valC[63:0] = temp_valC[0:63];

            
            // valC=instr_reg[16:79];
            valP=PC + 64'd10;
        end

        else if(icode == 4'b0100 && ifun == 4'd0)begin  // 4 0 rmmov operation
            rA=instr_reg[8:11];  // source
            rB=instr_reg[12:15];  // dest
            temp_valC[0:7] = instr_reg[72:79];
            temp_valC[8:15] = instr_reg[64:71];
            temp_valC[16:23] = instr_reg[56:63];
            temp_valC[24:31] = instr_reg[48:55];
            temp_valC[32:39] = instr_reg[40:47];
            temp_valC[40:47] = instr_reg[32:39];
            temp_valC[48:55] = instr_reg[24:31];
            temp_valC[56:63] = instr_reg[16:23];

            valC[63:0] = temp_valC[0:63];
            valP=PC + 64'd10;
        end

        else if(icode == 4'b0101 && ifun == 4'd0)begin  // 5 0 mrmov operation
            rA=instr_reg[8:11];  // source
            rB=instr_reg[12:15];  // dest
            temp_valC[0:7] = instr_reg[72:79];
            temp_valC[8:15] = instr_reg[64:71];
            temp_valC[16:23] = instr_reg[56:63];
            temp_valC[24:31] = instr_reg[48:55];
            temp_valC[32:39] = instr_reg[40:47];
            temp_valC[40:47] = instr_reg[32:39];
            temp_valC[48:55] = instr_reg[24:31];
            temp_valC[56:63] = instr_reg[16:23];

            valC[63:0] = temp_valC[0:63];

            valP=PC + 64'd10;
        end

        else if(icode==4'b1000 && ifun == 4'd0) begin
            temp_valC[0:7] = instr_reg[64:71];
            temp_valC[8:15] = instr_reg[56:63];
            temp_valC[16:23] = instr_reg[48:55];
            temp_valC[24:31] = instr_reg[40:47];
            temp_valC[32:39] = instr_reg[32:39];
            temp_valC[40:47] = instr_reg[24:31];
            temp_valC[48:55] = instr_reg[16:23];
            temp_valC[56:63] = instr_reg[8:15];

            valC[63:0] = temp_valC[0:63];
            valP=PC + 64'd9;
        end

        else if(icode==4'b1010 && ifun == 4'd0)  begin // push         
            rA=instr_reg[8:11];  // source
            rB=instr_reg[12:15];  // dest
            valP = PC + 64'd2;
            valC = 64'd0;
        end   

        else if((icode==4'b1011 || icode==4'b1001) && ifun == 4'd0)  begin   // 9 0 ret, B 0 pop 
            rA=instr_reg[8:11];  // source
            rB=instr_reg[12:15];  // dest
            valP = PC + 64'd2;
            valC = 64'd0;
        end   

        else if(icode == 4'b0111 && (ifun == 4'd0 || ifun == 4'd1 || ifun == 4'd2 || ifun == 4'd3 || ifun == 4'd4
        || ifun == 4'd5 || ifun == 4'd6))
        begin  // 7 0
            temp_valC[0:7] = instr_reg[64:71];
            temp_valC[8:15] = instr_reg[56:63];
            temp_valC[16:23] = instr_reg[48:55];
            temp_valC[24:31] = instr_reg[40:47];
            temp_valC[32:39] = instr_reg[32:39];
            temp_valC[40:47] = instr_reg[24:31];
            temp_valC[48:55] = instr_reg[16:23];
            temp_valC[56:63] = instr_reg[8:15];

            valC[63:0] = temp_valC[0:63];

            valP=PC + 64'd9;
        end

        else begin
            instr_valid=0; // invalid instruction
        end
    end
end

endmodule