module regfilemux(
    input reg_dest,
    input [2:0] rt, rd,
    output reg [2:0] reg_result //write register
);

always @(*)
begin
    case (reg_dest)
    1'b0: reg_result = rd; //Sets the write register to rd
    1'b1: reg_result = rt; //Sets the write register to rt
    endcase

end

endmodule