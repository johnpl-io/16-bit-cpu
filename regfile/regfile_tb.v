`timescale 1ns / 1ps 
module regfile_tb();
reg clk;
reg write_en;
reg [2:0] rega, regb, wreg;
reg [15:0] writedata;
wire [15:0] read1, read2;


regfile reg_test(clk, write_en, rega, regb, wreg, writedata, read1, read2);

initial begin
clk = 0;
end
always #10 clk =~ clk;
initial begin 
    write_en <= 1'b1;
    #100;
    rega <= 3'b0;
    #100;
    regb <= 3'b100;
    #100;
    wreg <= 3'b001;
    #100;
    writedata <= 16'b1;
    rega <= 3'b001;
    #100;
    $monitor("%b", rega);
       $dumpfile("test.vcd");
       $dumpvars(0,clk, write_en);  
$finish();
end

endmodule
