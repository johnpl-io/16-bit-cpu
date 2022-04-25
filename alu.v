module alu(
    input [2:0] ALU_Code,
    input [7:0] A, B,
    output [7:0] ALU_Out,
    output Carry,
    output isZero);

reg [7:0] Result;
assign ALU_Out = Result;
always @(*) 
begin 
case(ALU_Code)
    3'b000: Result = A + B; //ADD 
endcase


end


endmodule
 
