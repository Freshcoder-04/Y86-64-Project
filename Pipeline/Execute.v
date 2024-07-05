`include "Alu.v"

module Execute(E_icode,E_ifun,E_valA,E_valB,E_valC,E_dstE,E_dstM,E_bubble,E_stat,E_rA,E_rB, e_valE,e_Cnd,e_dstE,e_dstM,e_icode,e_ifun,e_stat,e_valA,e_valB,e_valC);

input wire clk, E_bubble;
input wire [3:0] E_icode, E_ifun, E_dstE, E_dstM, E_rA, E_rB;
input wire [63:0] E_valA, E_valB, E_valC;
input wire [1:0] E_stat;
output reg e_Cnd;   // 1 -> take jump/cmov   0 -> dont take
output reg [63:0] e_valE,e_valA,e_valB,e_valC;
output reg [3:0] e_dstE,e_dstM, e_icode, e_ifun;
reg [3:0] ALU_fun;
reg [63:0] ALU_A, ALU_B;
reg [2:0] cc;   // [ZF,SF,OF]
reg setcc;
wire [63:0] ALU_out;
output reg [1:0] e_stat;

ALU alu1(ALU_A, ALU_B, ALU_fun, ALU_out);

initial begin
     cc =  3'b000;
     // e_bubble = 0;
     e_Cnd = 0;
     e_valE = 64'd0;
     e_dstE = 4'hf;
     e_dstM = 4'hf;

end

// always@(negedge clk) begin
//      if(((E_icode == 4'b0111 && !e_Cnd) || ((E_icode == 4'b0101 || E_icode == 4'b1011) && (E_dstM == E_rA || E_dstM == E_rB))) || E_bubble == 1) begin
//           e_bubble = 1;
//      end
//      else begin
//           e_bubble = 0;
//      end

//      if(e_bubble) begin
//           e_valE = 64'd0;
//           e_dstE = 4'hF;
//           e_dstM = 4'hF;
//      end
//      else begin
//           e_dstM = E_dstM;
//      end
// end

always@(*) begin
    // ALU_fun =  4'd0;
     // e_Cnd = 0;
     // cc =  3'b000;
     setcc =  0;
     cc =  3'b000;
     // e_bubble = 0;
     e_Cnd = 0;
     e_valE = 64'd0;
     // e_dstE = 4'hf;
     // e_dstM = 4'hf;

    /* arithmetic/logical operations */
     // if(!E_bubble) begin
          e_icode = E_icode;
          e_ifun = E_ifun;
          if(E_icode == 4'b0110) begin  // 6 fn OPxx 
               setcc =  1;
               ALU_A =  E_valB;
               ALU_B =  E_valA;
               ALU_fun = E_ifun;
          end
          else if(E_icode == 4'b0000) begin  // 0 0 nop operation
               //    ALU_A =  E_valA;
               //    ALU_B =  64'd0;
               //   ALU_fun =  4'd0;
               e_valE = 64'd0;
          end
          else if(E_icode == 4'b0001) begin  // 1 0 halt operation
               //    ALU_A =  E_valA;
               //    ALU_B =  64'd0;
               //   ALU_fun =  4'd0;
               e_valE = 64'd0;
          end
          else if(E_icode == 4'b0010) begin 

          if(E_ifun == 4'b0000) begin  // 2 0 rrmov operation
               ALU_A =  E_valA;
               ALU_B =  64'd0;
               ALU_fun =  4'd0;
          end
          
          else if(E_ifun == 4'b0001) begin  // 2 1 cmovle operation
               ALU_A =  E_valA;
               ALU_B =  64'd0;
               ALU_fun =  4'd0;
          end

          else if(E_ifun == 4'b0010) begin  // 2 2 cmovl operation
               ALU_A =  E_valA;
               ALU_B =  64'd0;
               ALU_fun =  4'd0;
          end

          else if(E_ifun == 4'b0011) begin  // 2 3 cmove operation
               ALU_A =  E_valA;
               ALU_B =  64'd0;
               ALU_fun =  4'd0;
          end

          else if(E_ifun == 4'b0100) begin  // 2 4 cmovne operation
               ALU_A =  E_valA;
               ALU_B =  64'd0;
               ALU_fun =  4'd0;
          end
          
          else if(E_ifun == 4'b0101) begin  // 2 5 cmovge operation
               ALU_A =  E_valA;
               ALU_B =  64'd0;
               ALU_fun =  4'd0;
          end

          else if(E_ifun == 4'b0110) begin  // 2 6 cmovg operation
               ALU_A =  E_valA;
               ALU_B =  64'd0;
               ALU_fun =  4'd0;
          end
          end

     else if(E_icode == 4'b0011)begin  // 3 0 irmov operation
          ALU_A =  64'd0;
          ALU_B =  E_valC;
          ALU_fun =  4'd0;
          // e_valE = E_valC;
     end

     else if(E_icode == 4'b0100)begin  // 4 0 rmmov operation
          ALU_A =  E_valC;
          ALU_B =  E_valB;
          ALU_fun =  4'd0;  // computing effective address (D(rB) =  D+R[rB])
     end

     else if(E_icode == 4'b0101)begin  // 5 0 mrmov operation
          ALU_A =  E_valC;
          ALU_B =  E_valB;
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

     else if(E_icode==4'b1010 || E_icode==4'b1000)  begin    // A 0 push / 8 0 call ->  +8        
          ALU_A =  64'd8;
          ALU_B =  E_valB;    // E_valB is the value of the stack pointer ( value stored in register[4])
          ALU_fun =  4'd0;
     end   

          else if(E_icode==4'b1011 || E_icode==4'b1001)  begin    // B 0 pop / 9 0 ret -> -8       
               ALU_A =  E_valB;   // -8
               ALU_B =  64'd8;    // E_valB is the value of the stack pointer ( value stored in register[4])
               ALU_fun =  4'd1;
          end
          else if(E_icode==4'b0111)  begin    // 7 0       
               // ALU_A = 64'd0;
               // ALU_B =  64'd0;
               // ALU_fun =  4'd0;
               e_valE = 64'b0;
          end

          if(E_icode!=4'b0111 && E_icode!=4'b0001 && E_icode!=4'b0000) begin
               e_valE =  ALU_out;
          end

     // setting the condition codes if arithmetic/logical operation performed
          if(setcc) begin
               if(e_valE==64'b0) begin
                    cc[2] =  1;  //ZF
               end
               if(e_valE[63]==1) begin  //SF
                    cc[1] =  1;
               end
               if(((ALU_A[63]==0) && (ALU_B[63]==0) && (ALU_out[63]==1)) || ((ALU_A[63]==1) && (ALU_B[63]==1) && (ALU_out[63]==0 || ALU_out == 64'd0))) begin
                    cc[0] =  1;    // OF
               end
          end


     // In case of jump, no e_valE or any operation, only setting the condition flag: e_Cnd, for various conditions

     if(E_icode == 4'b0010 || E_icode == 4'b0111) begin     

               if(E_ifun == 4'b0000) begin  // 0 jmp/rrmovq
                    e_Cnd =  1;
               end

               else if(E_ifun == 4'b0001) begin  //  1 le 
                    if((cc[1]^cc[0])|cc[2]) begin  // <<=  (SF^OF)|ZF
                         e_Cnd =  1;
                    end
               end

               else if(E_ifun == 4'b0010) begin  // 2 l
                    if(cc[1]^cc[0]) begin  // <  (SF^OF)
                         e_Cnd =  1;
                    end
               end

               else if(E_ifun == 4'b0011) begin  // 3 e
                    if(cc[2]) begin  // ==  ZF
                         e_Cnd =  1;
                    end
               end

               else if(E_ifun == 4'b0100) begin  // 4 ne
                    if(~cc[2]) begin  // !=  ZF
                         e_Cnd =  1;
                    end
               end
               
               else if(E_ifun == 4'b0101) begin  //  5 ge
                    if(~(cc[1]^cc[0])) begin  //  >  ~(SF^OF)
                         e_Cnd =  1;
                    end
               end

               else if(E_ifun == 4'b0110) begin  // 6 g
                    if(~(cc[1]^cc[0])&(~cc[2])) begin  //  >  ~(SF^OF)&(~ZF)
                         e_Cnd =  1;
                    end
               end

               if(e_Cnd == 0) begin
                    e_dstE = 4'hF;
               end
               else begin
                    e_dstE = E_dstE;
               end

          end
          else begin
               e_dstE = E_dstE;
          end
     // end
     // if(((E_icode == 4'b0111 && !e_Cnd) || ((E_icode == 4'b0101 || E_icode == 4'b1011) && (E_dstM == E_rA || E_dstM == E_rB))) || E_bubble == 1) begin
     //      e_bubble = 1;
     // end
     // else begin
     //      e_bubble = 0;
     // end

     // if(e_bubble) begin
     //      e_valE = 64'd0;
     //      e_dstE = 4'hF;
     //      e_dstM = 4'hF;
     // end
     // else begin
     //      e_dstM = E_dstM;
     // end
     // e_stat = E_stat;
     // e_valA = E_valA;
     // e_valB = E_valB;
     // e_valC = E_valC;
end

always@(*) begin
     e_stat = E_stat;
     e_valA = E_valA;
     e_valB = E_valB;
     e_valC = E_valC;
     e_dstM = E_dstM;
     e_dstE = E_dstE;
end

endmodule