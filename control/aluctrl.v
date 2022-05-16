module aluctrl(
    input [2:0] opcode,
    input [3:0] func,
    output reg [2:0] ALU_Code
    );

always@(*)
begin 
    case(opcode)
    3'b000:
    begin    
    case(func)
    4'b0000: ALU_Code = 3'b000; //add
    4'b0001: ALU_Code = 3'b001; //sub
    4'b0100: ALU_Code = 3'b100; //and
    4'b0101: ALU_Code = 3'b101; //or
    4'b0110: ALU_Code = 3'b110; //not 
    4'b0111: ALU_Code = 3'b111; //xor
    4'b0011: ALU_Code = 3'b011; //slt
    4'b0010: ALU_Code = 3'b010; //lsl

    endcase 
    end
    3'b001: ALU_Code = 3'b000; //addi
    3'b010: ALU_Code = 3'b001; //subi
    3'b011: ALU_Code = 3'b000; //st
    3'b100: ALU_Code = 3'b000; //ld
    3'b110: ALU_Code = 3'b001; //beq
    endcase

end

endmodule
