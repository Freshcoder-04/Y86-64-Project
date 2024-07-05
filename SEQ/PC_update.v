module PC_update(icode,valP,valC,valM,cond_flag, NextPC,clk);

input wire clk;
input wire cond_flag;
input wire [3:0] icode;
input wire [63:0] valP, valC, valM;

output reg [63:0] NextPC;

always@(*) begin
    
    // conditional moves (no matter move occurs or not, still PC needs to get updated)

    if(icode == 4'b0111 && cond_flag == 1) begin   // jump
        NextPC=valC;
    end

    else if(icode == 4'b1000) begin  //  call
        NextPC=valC;
    end

    else if(icode == 4'b1001) begin   // ret
        NextPC=valM;
    end

    else begin
        NextPC=valP;
    end

end

endmodule