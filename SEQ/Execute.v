`include "Alu.v"

module Execute(cc,icode,ifun,valA,valB,valC, valE,cond_flag);

// input wire clk;
input wire [3:0] icode, ifun;
input wire [63:0] valA, valB, valC;

output reg cond_flag;   // 1 -> take jump/cmov   0 -> dont take
output reg [63:0] valE;

reg [3:0] ALU_fun;
reg [63:0] ALU_A, ALU_B;
output reg [2:0] cc;   // [ZF,SF,OF]
reg setcc;
wire [63:0] ALU_out;

ALU alu1(ALU_A, ALU_B, ALU_fun, ALU_out);

initial begin
     cc =  3'b000;
end

always@(*) begin
    // ALU_fun =  4'd0;
     cond_flag = 0;
     // cc =  3'b000;
     setcc =  0;

    /* arithmetic/logical operations */

     if(icode == 4'b0110) begin  // 6 fn OPxx 
          setcc =  1;
          ALU_A =  valB;
          ALU_B =  valA;
          ALU_fun = ifun;
     end
     else if(icode == 4'b0000) begin  // 0 0 nop operation
          //    ALU_A =  valA;
          //    ALU_B =  64'd0;
          //   ALU_fun =  4'd0;
          valE = 64'd0;
     end
     else if(icode == 4'b0001) begin  // 1 0 halt operation
          //    ALU_A =  valA;
          //    ALU_B =  64'd0;
          //   ALU_fun =  4'd0;
          valE = 64'd0;
     end
    else if(icode == 4'b0010) begin 

        if(ifun == 4'b0000) begin  // 2 0 rrmov operation
             ALU_A =  valA;
             ALU_B =  64'd0;
            ALU_fun =  4'd0;
        end
        
        else if(ifun == 4'b0001) begin  // 2 1 cmovle operation
             ALU_A =  valA;
             ALU_B =  64'd0;
            ALU_fun =  4'd0;
        end

        else if(ifun == 4'b0010) begin  // 2 2 cmovl operation
             ALU_A =  valA;
             ALU_B =  64'd0;
            ALU_fun =  4'd0;
        end

        else if(ifun == 4'b0011) begin  // 2 3 cmove operation
             ALU_A =  valA;
             ALU_B =  64'd0;
            ALU_fun =  4'd0;
        end

        else if(ifun == 4'b0100) begin  // 2 4 cmovne operation
             ALU_A =  valA;
             ALU_B =  64'd0;
            ALU_fun =  4'd0;
        end
        
        else if(ifun == 4'b0101) begin  // 2 5 cmovge operation
             ALU_A =  valA;
             ALU_B =  64'd0;
            ALU_fun =  4'd0;
        end

        else if(ifun == 4'b0110) begin  // 2 6 cmovg operation
             ALU_A =  valA;
             ALU_B =  64'd0;
            ALU_fun =  4'd0;
        end
    end

    else if(icode == 4'b0011)begin  // 3 0 irmov operation
         ALU_A =  64'd0;
         ALU_B =  valC;
        ALU_fun =  4'd0;
    end

    else if(icode == 4'b0100)begin  // 4 0 rmmov operation
         ALU_A =  valC;
         ALU_B =  valB;
        ALU_fun =  4'd0;  // computing effective address (D(rB) =  D+R[rB])
    end

    else if(icode == 4'b0101)begin  // 5 0 mrmov operation
         ALU_A =  valC;
         ALU_B =  valB;
        ALU_fun =  4'd0;   // computing effective address (D(rB) =  D+R[rB])
    end

    /*
    0 -> top   initial stack pointer
    1
    2
    3
    .
    .
    .
    104.....
    */

    else if(icode==4'b1010 || icode==4'b1000)  begin    // A 0 push / 8 0 call ->  +8        
         ALU_A =  64'd8;
         ALU_B =  valB;    // valB is the value of the stack pointer ( value stored in register[4])
        ALU_fun =  4'd0;
    end   

     else if(icode==4'b1011 || icode==4'b1001)  begin    // B 0 pop / 9 0 ret -> -8       
          ALU_A =  valB;   // -8
          ALU_B =  64'd8;    // valB is the value of the stack pointer ( value stored in register[4])
          ALU_fun =  4'd1;
     end
     else if(icode==4'b0111)  begin    // 7 0       
          // ALU_A = 64'd0;
          // ALU_B =  64'd0;
          // ALU_fun =  4'd0;
          valE = 64'b0;
     end

     if(icode!=4'b0111 && icode!=4'b0001 && icode!=4'b0000 ) begin
          valE =  ALU_out;
     end

    // setting the condition codes if arithmetic/logical operation performed
     if(setcc) begin
          if(valE==64'b0) begin
               cc[2] =  1;
          end
          if(valE[63]==1) begin
               cc[1] =  1;
          end
          if(((ALU_A[63]==0) && (ALU_B[63]==0) && (ALU_out[63]==1)) || ((ALU_A[63]==1) && (ALU_B[63]==1) && (ALU_out[63]==0 || ALU_out == 64'd0))) begin
               cc[0] =  1;
          end
     end


    // In case of jump, no valE or any operation, only setting the condition flag: cond_flag, for various conditions

    if(icode == 4'b0010 || icode == 4'b0111) begin     

        if(ifun == 4'b0000) begin  // 0 jmp/rrmovq
             cond_flag =  1;
        end

        else if(ifun == 4'b0001) begin  //  1 le 
            if((cc[1]^cc[0])|cc[2]) begin  // <<=  (SF^OF)|ZF
                 cond_flag =  1;
            end
        end

        else if(ifun == 4'b0010) begin  // 2 l
            if(cc[1]^cc[0]) begin  // <  (SF^OF)
                 cond_flag =  1;
            end
        end

        else if(ifun == 4'b0011) begin  // 3 e
            if(cc[2]) begin  // ==  ZF
                 cond_flag =  1;
            end
        end

        else if(ifun == 4'b0100) begin  // 4 ne
            if(~cc[2]) begin  // !=  ZF
                 cond_flag =  1;
            end
        end
        
        else if(ifun == 4'b0101) begin  //  5 ge
            if(~(cc[1]^cc[0])) begin  //  >  ~(SF^OF)
                 cond_flag =  1;
            end
        end

        else if(ifun == 4'b0110) begin  // 6 g
            if(~(cc[1]^cc[0])&(~cc[2])) begin  //  >  ~(SF^OF)&(~ZF)
                 cond_flag =  1;
            end
        end
     end


end

endmodule