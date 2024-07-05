module mem(valA, valB, valE, valP, icode, valM, clk, dmem_error);

input wire [63:0] valA, valB, valE, valP;
input wire [3:0] icode;
output reg [63:0] valM;
output reg dmem_error;
input wire clk;
reg [7:0]memory [0:1048575];

initial begin
    dmem_error = 0;
end

always@(*) begin
    dmem_error = 0;
    /*
    icode =  4: i.e., register to memory move (write)
        valB and valC will be used for address comptation,
        i.e., valE is the destination address.
        valA should be written to Mem[valE].
    icode =  5: i.e., memory to register move (read)
        valB and valC will be used for address computation,
        the value read from this address valE will be stored
        in valM and this valM should be written in the
        register rA.
    icode =  A: i.e., push
        rA register stores the address of the instruction
        to be pushed into the stack.
        Here stack pointer decrement will happen and
        the value stored in rA (i.e. valA) 
    */
    if(valE>=0 && valE+7 <= 1048575) begin
        if(icode == 4'b0100) begin //rmmov
            memory[valE] =  valA[63:(63-7)];
            memory[valE + 1] =  valA[(63-8):(63-15)];
            memory[valE + 2] =  valA[(63-16):(63-23)];
            memory[valE + 3] =  valA[(63-24):(63-31)];
            memory[valE + 4] =  valA[(63-32):(63-39)];
            memory[valE + 5] =  valA[(63-40):(63-47)];
            memory[valE + 6] =  valA[(63-48):(63-55)];
            memory[valE + 7] =  valA[(63-56):(63-63)];
        end
        
        
        else if(icode == 4'b1010) begin // push
            memory[valE] =  valA[63:(63-7)];
            memory[valE + 1] =  valA[(63-8):(63-15)];
            memory[valE + 2] =  valA[(63-16):(63-23)];
            memory[valE + 3] =  valA[(63-24):(63-31)];
            memory[valE + 4] =  valA[(63-32):(63-39)];
            memory[valE + 5] =  valA[(63-40):(63-47)];
            memory[valE + 6] =  valA[(63-48):(63-55)];
            memory[valE + 7] =  valA[(63-56):(63-63)];
        end
        
        else if(icode == 4'b1000) begin // call
            memory[valE] =  valP[63:(63-7)];
            memory[valE + 1] =  valP[(63-8):(63-15)];
            memory[valE + 2] =  valP[(63-16):(63-23)];
            memory[valE + 3] =  valP[(63-24):(63-31)];
            memory[valE + 4] =  valP[(63-32):(63-39)];
            memory[valE + 5] =  valP[(63-40):(63-47)];
            memory[valE + 6] =  valP[(63-48):(63-55)];
            memory[valE + 7] =  valP[(63-56):(63-63)];
        end
        
    end
    
end

always@(valA, valE, icode) begin
    if(valE>=0 && valE+7 <= 1048575) begin
        if(icode == 4'b0101) begin // mrmov
            valM[(63-0):(63-7)] =  memory[valE + 0];
            valM[(63-8):(63-15)] =  memory[valE + 1];
            valM[(63-16):(63-23)] =  memory[valE + 2];
            valM[(63-24):(63-31)] =  memory[valE + 3];
            valM[(63-32):(63-39)] =  memory[valE + 4];
            valM[(63-40):(63-47)] =  memory[valE + 5];
            valM[(63-48):(63-55)] =  memory[valE + 6];
            valM[(63-56):(63-63)] =  memory[valE + 7];
        end

        else if(icode == 4'b1011) begin // pop
            valM[(63-0):(63-7)] =  memory[valB + 0];
            valM[(63-8):(63-15)] =  memory[valB + 1];
            valM[(63-16):(63-23)] =  memory[valB + 2];
            valM[(63-24):(63-31)] =  memory[valB + 3];
            valM[(63-32):(63-39)] =  memory[valB + 4];
            valM[(63-40):(63-47)] =  memory[valB + 5];
            valM[(63-48):(63-55)] =  memory[valB + 6];
            valM[(63-56):(63-63)] =  memory[valB + 7];
        end

        else if(icode == 4'b1001) begin // ret
            valM[(63-0):(63-7)] =  memory[valB + 0];
            valM[(63-8):(63-15)] =  memory[valB + 1];
            valM[(63-16):(63-23)] =  memory[valB + 2];
            valM[(63-24):(63-31)] =  memory[valB + 3];
            valM[(63-32):(63-39)] =  memory[valB + 4];
            valM[(63-40):(63-47)] =  memory[valB + 5];
            valM[(63-48):(63-55)] =  memory[valB + 6];
            valM[(63-56):(63-63)] =  memory[valB + 7];
        end
    end
end
always@(negedge clk) begin
    if(icode == 4'b1000 || icode == 1010 || icode == 0100) begin
        if(valE < 0 || valE+7 > 1048575) begin
            dmem_error =  1;
        end
        else dmem_error = 0;
    end
end
endmodule