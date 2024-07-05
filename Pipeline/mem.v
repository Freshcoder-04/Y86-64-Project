module mem(M_dstE, M_dstM, m_dstE, m_dstM, m_valE,m_valA,M_stat, M_valA, M_valB, M_valE, M_icode, m_valM, m_stat, m_icode, clk);

input wire [1:0] M_stat;
// input M_bubble;
input wire [63:0] M_valA, M_valB, M_valE;
input wire [3:0] M_icode,M_dstE, M_dstM;
output reg [63:0] m_valM,m_valE,m_valA;
output reg [1:0] m_stat;
output reg [3:0] m_icode,m_dstE, m_dstM;
input wire clk;
reg [7:0] memory [0:1048575];
// output reg m_bubble;
initial begin
    m_valM = 64'd0;
    m_stat = 0;
    m_icode = 4'd0;
    m_dstE = 4'd0;
    m_dstM = 4'd0;
end

// always@(negedge clk) begin
//     if(M_bubble) begin
//         m_valM = 64'd0;
//     end
// end

// initial begin
//     m_bubble = 0;
// end

always@(M_stat, M_valA, M_valB, M_valE, M_icode) begin    //  *   ------> change according to testing results
    /*
    M_icode =  4: i.e., register to memory move (write)
        valB and valC will be used for address computation,
        i.e., M_valE is the destination address.
        valA should be written to Mem[M_valE].
    M_icode =  5: i.e., memory to register move (read)
        valB and valC will be used for address computation,
        the value read from this address M_valE will be stored
        in m_valM and this m_valM should be written in the
        register rA.
    M_icode =  A: i.e., push
        rA register stores the address of the instruction
        to be pushed into the stack.
        Here stack pointer decrement will happen and
        the value stored in rA (i.e. valA) 
    */
    

    
    
    // if(!M_bubble) begin
        if(M_valE>=0 && M_valE+7 <= 1048575) begin
            if(M_icode == 4'b0100) begin //rmmov
                memory[M_valE] =  M_valA[63:(63-7)];
                memory[M_valE + 1] =  M_valA[(63-8):(63-15)];
                memory[M_valE + 2] =  M_valA[(63-16):(63-23)];
                memory[M_valE + 3] =  M_valA[(63-24):(63-31)];
                memory[M_valE + 4] =  M_valA[(63-32):(63-39)];
                memory[M_valE + 5] =  M_valA[(63-40):(63-47)];
                memory[M_valE + 6] =  M_valA[(63-48):(63-55)];
                memory[M_valE + 7] =  M_valA[(63-56):(63-63)];
            end
            
            
            else if(M_icode == 4'b1010) begin // push
                memory[M_valE] =  M_valA[63:(63-7)];
                memory[M_valE + 1] =  M_valA[(63-8):(63-15)];
                memory[M_valE + 2] =  M_valA[(63-16):(63-23)];
                memory[M_valE + 3] =  M_valA[(63-24):(63-31)];
                memory[M_valE + 4] =  M_valA[(63-32):(63-39)];
                memory[M_valE + 5] =  M_valA[(63-40):(63-47)];
                memory[M_valE + 6] =  M_valA[(63-48):(63-55)];
                memory[M_valE + 7] =  M_valA[(63-56):(63-63)];
            end
            
            else if(M_icode == 4'b1000) begin // call
                memory[M_valE] =  M_valA[63:(63-7)];
                memory[M_valE + 1] =  M_valA[(63-8):(63-15)];
                memory[M_valE + 2] =  M_valA[(63-16):(63-23)];
                memory[M_valE + 3] =  M_valA[(63-24):(63-31)];
                memory[M_valE + 4] =  M_valA[(63-32):(63-39)];
                memory[M_valE + 5] =  M_valA[(63-40):(63-47)];
                memory[M_valE + 6] =  M_valA[(63-48):(63-55)];
                memory[M_valE + 7] =  M_valA[(63-56):(63-63)];
            end
        end
        m_icode = M_icode;
        m_valE = M_valE;
        m_valA = M_valA;
        m_dstE = M_dstE;
        m_dstM = M_dstM;
        // m_bubble = M_bubble;
    // end
    // else begin
    //     m_icode = 4'd0;
    //     m_bubble = M_bubble;
    // end
    if(M_icode == 4'b1000 || M_icode == 4'b1010 || M_icode == 4'b0100) begin
        if((M_valE < 0 || M_valE+7 > 1048575)) begin
            m_stat = 2'b10;   // dmem_error
        end
        else begin
            m_stat = M_stat;
        end
    end
    else begin
        m_stat = M_stat;
    end
end

always@(M_stat, M_valA, M_valE, M_icode) begin      // negedge or posedge seeeeee M_stat, M_valA, M_valE, M_icode
    // if(!M_bubble) begin
        if(M_valE>=0 && M_valE+7 <= 1048575) begin
            if(M_icode == 4'b0101) begin // mrmov
                m_valM[(63-0):(63-7)] =  memory[M_valE + 0];
                m_valM[(63-8):(63-15)] =  memory[M_valE + 1];
                m_valM[(63-16):(63-23)] =  memory[M_valE + 2];
                m_valM[(63-24):(63-31)] =  memory[M_valE + 3];
                m_valM[(63-32):(63-39)] =  memory[M_valE + 4];
                m_valM[(63-40):(63-47)] =  memory[M_valE + 5];
                m_valM[(63-48):(63-55)] =  memory[M_valE + 6];
                m_valM[(63-56):(63-63)] =  memory[M_valE + 7];
            end

            else if(M_icode == 4'b1011) begin // pop
                m_valM[(63-0):(63-7)] =  memory[M_valB+ 0];
                m_valM[(63-8):(63-15)] =  memory[M_valB+ 1];
                m_valM[(63-16):(63-23)] =  memory[M_valB + 2];
                m_valM[(63-24):(63-31)] =  memory[M_valB + 3];
                m_valM[(63-32):(63-39)] =  memory[M_valB + 4];
                m_valM[(63-40):(63-47)] =  memory[M_valB + 5];
                m_valM[(63-48):(63-55)] =  memory[M_valB + 6];
                m_valM[(63-56):(63-63)] =  memory[M_valB + 7];
            end

            else if(M_icode == 4'b1001) begin // ret
                m_valM[(63-0):(63-7)] =  memory[M_valB + 0];
                m_valM[(63-8):(63-15)] =  memory[M_valB + 1];
                m_valM[(63-16):(63-23)] =  memory[M_valB + 2];
                m_valM[(63-24):(63-31)] =  memory[M_valB + 3];
                m_valM[(63-32):(63-39)] =  memory[M_valB + 4];
                m_valM[(63-40):(63-47)] =  memory[M_valB + 5];
                m_valM[(63-48):(63-55)] =  memory[M_valB + 6];
                m_valM[(63-56):(63-63)] =  memory[M_valB + 7];
            end
        end
        m_icode = M_icode;
        m_valE = M_valE;
        m_valA = M_valA;
        m_dstE = M_dstE;
        m_dstM = M_dstM;
        // m_bubble = M_bubble;
    // end
    // else begin
    //     m_icode = 4'd0;
    //     // m_bubble = M_bubble;
    // end
    if(M_icode == 4'b1000 || M_icode == 4'b1010 || M_icode == 4'b0100) begin
        if((M_valE < 0 || M_valE+7 > 1048575)) begin
            m_stat = 2'b10;   // dmem_error
        end
        else begin
            m_stat = M_stat;
        end
    end
    else begin
        m_stat = M_stat;
    end
end

endmodule