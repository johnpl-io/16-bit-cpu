module alu(
    input [7:0] A, 
    input [7:0] B,
    input [2:0] ALU_Code,
    output [7:0] ALU_Out,
    output Carry,
    output isZero);

reg [7:0] Result;
assign ALU_Out = Result;
reg carry;
assign Carry = carry;
reg iszero;
assign isZero = iszero;

always @(*) 
begin 
case(ALU_Code)
    3'b000: {carry,Result} = A + B; //ADD
    3'b001: Result = A + (~B+1);    //SUB
    3'b010: Result = A>>1;          //LSL
    3'b011: Result = A<<1;          //LSR
    3'b100: Result = A & B;         //AND
    3'b101: Result = A | B;         //A or B
    3'b110: Result = ~(A);          //Not
    3'b111: Result = A^B;           //Exclusive OR
    //probably should add mult div etc 
    default: Result = A+B;
endcase
iszero = Result == 0 ? 1 : 0;



end


endmodule
 

