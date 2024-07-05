module Hazards(E_icode,E_dstM,d_rA,d_rB,D_icode,M_icode,e_Cnd,F_stall,D_stall,E_bubble,D_bubble);

input wire [3:0] E_icode,M_icode,D_icode,d_rA,d_rB,E_dstM;
input wire e_Cnd;
output reg F_stall,D_stall,E_bubble,D_bubble;

initial begin
    F_stall = 0;
    D_stall = 0;
    D_bubble = 0;
    E_bubble = 0;
end

always@(*) begin
    F_stall = 0;
    D_stall = 0;
    D_bubble = 0;
    E_bubble = 0;
    if(((E_icode == 4'b0101 || E_icode == 4'b1011) && (E_dstM == d_rA || E_dstM == d_rB))) begin
        F_stall = 1;
        D_stall = 1;
        E_bubble = 1;
    end
    else if((D_icode == 4'b1001 || E_icode == 4'b1001 || M_icode == 4'b1001))begin
        F_stall = 1;
        D_bubble = 1;
    end
    else if(E_icode == 4'b0111 && !e_Cnd) begin
        D_bubble = 1;
        E_bubble = 1;
    end
    // else begin
    //     F_stall = 0;
    //     D_stall = 0;
    //     D_bubble = 0;
    //     E_bubble = 0;
    // end
    // if(((E_icode == 4'b0101 || E_icode == 4'b1011) && (E_dstM == d_rA || E_dstM == d_rB) && (E_dstM != 4'hF))) begin
    //     D_stall = 1;
    // end
    // else begin
    //     D_stall = 0;
    // end
        
    // if((E_icode == 4'b0111 && !e_Cnd) || (D_icode == 4'b1001 || M_icode == 4'b1001 || E_icode == 4'b1001) ) begin
    //     D_bubble = 1;
        
    // end
    // else begin
    //     D_bubble = 0;
    // end
    // if(((E_icode == 4'b0101 || E_icode == 4'b1011) && (E_dstM == E_rA || E_dstM == E_rB) && (E_dstM != 4'hF))) begin
    //     D_stall = 1;
    // end
    // else begin
    //     D_stall = 0;
    // end
        
    // if((E_icode == 4'b0111 && !e_Cnd) || (D_icode == 4'b1001 || M_icode == 4'b1001 || E_icode == 4'b1001) ) begin
    //     D_bubble = 1;
        
    // end
    // else begin
    //     D_bubble = 0;
    // end
    // if(D_stall || (E_icode == 4'b0111 && !e_Cnd) || ((E_icode == 4'b0101 || E_icode == 4'b1011) && (E_dstM == d_rA || E_dstM == d_rB)))begin 
    //     E_bubble = 1;
    // end
    // else begin
    //     E_bubble = 0;
    // end 
end

endmodule