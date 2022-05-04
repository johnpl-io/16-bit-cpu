`timescale 1ns/1ns
`include "imem.v"
`include "alu.v"
`include "regfile.v"
module CPU();

wire [15:0] instruction;
reg clk;
reg [2:0] ctrl;
reg [15:0] pc;
wire [15:0] res;
wire Carry;
wire isZero;

wire [2:0] reg1, reg2, wreg;
wire [3:0] ALU_Code;


reg write_en;
reg [15:0] writedata;
wire [15:0] read1, read2;


//decoding 
assign opcode = instruction[15:9];
assign wreg = instruction[8:6];
assign reg1 = instruction[5:3];
assign reg2 = instruction[2:0];

alu alu_test(.A(read1), .B(read2), .ALU_Code(ctrl), .ALU_Out(res), .Carry(Carry), .isZero(isZero));
regfile reg_test(.clk(clk), .write_en(write_en), .rega(reg1), .regb(reg2), .wreg(wreg), .writedata(res), .read1(read1), .read2(read2));
imem imem_test(.pc(pc), .instruction(instruction));

always @(posedge clk)
begin case(opcode) 
    7'b0000000:
    begin
        ctrl = 3'b000;
       $monitor("%d" , res );
        write_en = 1;
         
        #2
    write_en = 0;

    end
endcase

end


always @(posedge clk) 
begin 
   pc = pc + 1;
         #2;
    if(pc > 2) 
    $finish;
  
end
initial begin
clk = 0;
pc = -1;
write_en = 0;
$dumpfile("out.vcd");
$dumpvars(0,clk, res);
end
always #20 clk =~ clk;


endmodule