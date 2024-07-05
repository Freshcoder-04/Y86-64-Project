module stat(clk,w_stat,stat);

input clk;
input wire [1:0] w_stat;
output reg [1:0] stat;

always@(posedge clk)begin
    stat = w_stat;
end

endmodule