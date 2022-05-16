module memmux (
    input [15:0] data_from_mem, alu_result,
    input memtoreg,
    output reg [15:0] memmuxout
);
always @(*)
begin 
    case (memtoreg) 
    1'b0: memmuxout = alu_result;
    1'b1: memmuxout = data_from_mem;
    endcase
end
endmodule

