module aluctrl(
    input [3:0] func,
    output reg [2:0] ALU_Code
    );

always@(*)
begin 
    case(func)
    4'b0000: ALU_Code = 3'b000;
    endcase 
end
endmodule
