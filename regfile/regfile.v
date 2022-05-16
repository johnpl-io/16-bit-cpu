module regfile ( 
input clk, 
input write_en,
input [2:0] rega,regb,wreg,
input [15:0] writedata,
output [15:0] read1, read2
);

reg [15:0] reg8 [7:0];
initial begin
    reg8[0] <= 16'b0;
    reg8[1] <= 16'b0;
    reg8[2] <= 16'b0;
    reg8[3] <= 16'b0;
    reg8[4] <= 16'b0;
    reg8[5] <= 16'b0;
    reg8[6] <= 16'b0;
    reg8[7] <= 16'b0;
end
always @( posedge clk )
begin 
   
    if(write_en && wreg != 7 ) begin
    reg8[wreg] <= writedata;
    end
     $monitor("reg 0: %d    reg 4: %d \nreg 1: %d    reg 5: %d \nreg 2: %d    reg 6: %d \nreg 3: %d    reg 7: %d\n", reg8[0], reg8[4], reg8[1], reg8[5], reg8[2], reg8[6], reg8[3], reg8[7]);
    
end
assign read1 = reg8[rega];
assign read2 = reg8[regb];

endmodule

