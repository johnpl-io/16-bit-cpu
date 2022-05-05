module aluctrl(
    input [3:0] func,
    output reg [2:0] ALU_Code
    );

always@(*)
begin 
    case(func)
    4'b0000: ALU_Code = 3'b000; //add
    4'b0001: ALU_Code = 3'b001; //sub
    4'b0100: ALU_Code = 3'b100; //and
    4'b0101: ALU_Code = 3'b101; //or
    4'b0110: ALU_Code = 3'b110; //not 
    4'b0111: ALU_Code = 3'b111; //xor
    endcase 

end

endmodule
