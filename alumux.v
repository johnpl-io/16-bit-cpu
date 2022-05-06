module alumux(
    input [6:0] immediate,
    input [15:0] read2,
    input  aluop,
    output reg [15:0] alumuxout
);
 always @(*)
 begin 
     case (aluop)
     1'b0: alumuxout =read2;
     1'b1: alumuxout = {6'b0,immediate};    

     endcase
 end

endmodule

