`timescale 1ns/1ns
`include "imem.v"
`include "alu.v"
`include "regfile.v"
`include "control.v"
`include "aluctrl.v"
module CPU();

wire [15:0] instruction;
reg clk;
reg [2:0] ctrl;
reg [15:0] pc;
wire [15:0] res;
wire Carry;
wire isZero;

wire [2:0] reg1, reg2, wreg;
wire [2:0] ALU_op;
wire [2:0] opcode;
wire [3:0] func;

wire jump, branch, memwrite, regwrite;
reg write_en;
reg [15:0] writedata;
wire [15:0] read1, read2;


//decoding 
assign opcode = instruction[15:13];
assign wreg = instruction[12:10];
assign reg1 = instruction[9:7];
assign reg2 = instruction[6:4];



alu alu_test(.A(read1), .B(read2), .ALU_Code(ALU_op), .ALU_Out(res), .Carry(Carry), .isZero(isZero));
regfile reg_test(.clk(clk), .write_en(regwrite), .rega(reg1), .regb(reg2), .wreg(wreg), .writedata(res), .read1(read1), .read2(read2));
imem imem_test(.pc(pc), .instruction(instruction));
control control_test(.opcode(opcode), .jump(jump), .memwrite(memwrite), .regwrite(regwrite));
aluctrl aluctrl_test(.func(func), .ALU_Code(ALU_op));







always @(posedge clk) 
begin 
    
    $monitor("%d",read1);
    pc = pc + 1;
    #2;
    if(pc > 3) 
    $finish;
    
end
initial begin
clk = 0;
pc = -1;

$dumpfile("out.vcd");
$dumpvars(0,clk, res);
end
always #20 clk =~ clk;


endmodule