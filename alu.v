module alu(
    input [15:0] A, B,
    input [2:0] ALU_Code,
    output [15:0] ALU_Out,
    output Carry,
    output isZero);

reg [15:0] Result;
assign ALU_Out = Result;
reg carry;
assign Carry = carry;
reg iszero;
assign isZero = iszero;
//carry may need to be changed to overflow
always @(*) 
begin 
case(ALU_Code)
    3'b000: {carry,Result} = A + B;
    3'b001: Result = A + (~B+1);    //SUB
    3'b010: Result = A>>1;          //LSL
    3'b011: Result = A < B;         //Set Less Than
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
 

