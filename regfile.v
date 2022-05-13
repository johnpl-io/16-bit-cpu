module regfile ( 
input clk, 
input write_en,
input [2:0] rega,regb,wreg,
input [15:0] writedata,
output [15:0] read1, read2
);

reg [15:0] reg8 [7:0];
initial begin
    reg8[0] <= 2;
    reg8[1] <= 2;
    reg8[2] <= 16'b0;
    reg8[3] <= 16'b0;
    reg8[4] <= 16'b0;
    reg8[5] <= 16'b0;
    reg8[6] <= 16'b0;
    reg8[7] <= 16'b0;
end
always @( posedge clk )
begin 
    if(write_en) begin
    reg8[wreg] <= writedata;
    end
    $monitor("reg 0 %d reg1 %d", reg8[0], reg8[1]);
end
assign read1 = reg8[rega];
assign read2 = reg8[regb];

endmodule

