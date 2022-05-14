`timescale 1ns/1ns
`include "imem.v"
`include "alu.v"
`include "regfile.v"
`include "control.v"
`include "aluctrl.v"
`include "alumux.v"
`include "regfilemux.v"
`include "mem.v"
`include "memmux.v"
module CPU();

wire [15:0] instruction;
reg clk;
reg [2:0] ctrl;
reg [15:0] pc;
wire [15:0] res;
wire Carry;
wire isZero;

wire [2:0] rs, rt, rd;
wire [2:0] ALU_Code;
wire [2:0] opcode;
wire [3:0] func;

wire jump, branch, memwrite, regwrite, aluop, reg_dest, memtoreg;
reg write_en;
reg [15:0] writedata;
wire [15:0] read1, read2;
wire [6:0] immediate;
wire [15:0] alumuxout;
wire [2:0] reg_result;
wire [15:0] mem_out;
wire [15:0] memmuxresult;
wire [12:0] jumpaddr;
//decoding 
assign opcode = instruction[15:13];
assign rs = instruction[12:10];
assign rt = instruction[9:7];
assign rd = instruction[6:4];
assign func = instruction[3:0];
assign immediate = instruction[6:0];
assign jumpaddr = instruction[12:0];


alu alu_test(.A(read1), .B(alumuxout), .ALU_Code(ALU_Code), .ALU_Out(res), .Carry(Carry), .isZero(isZero));
regfilemux regfilemux_test(.reg_dest(reg_dest), .rt(rt), .rd(rd), .reg_result(reg_result));
regfile reg_test(.clk(clk), .write_en(regwrite), .rega(rs), .regb(rt), .wreg(reg_result), .writedata(memmuxresult), .read1(read1), .read2(read2));
imem imem_test(.pc(pc), .instruction(instruction));
alumux alumux_test(.immediate(immediate), .read2(read2), .aluop(aluop), .alumuxout(alumuxout));
control control_test(.opcode(opcode), .jump(jump), .branch(branch), .memwrite(memwrite), .regwrite(regwrite), .aluop(aluop), .reg_dest(reg_dest), .memtoreg(memtoreg));
aluctrl aluctrl_test(.opcode(opcode),.func(func), .ALU_Code(ALU_Code));
mem mem_test(.clk(clk), .we(memwrite), .address(res), .data_in(read2), .data_out(mem_out));
memmux memmux_test(.data_from_mem(mem_out), .alu_result(res), .memtoreg(memtoreg), .memmuxout(memmuxresult));




always @(posedge clk)
//may have to be negedge 
begin 
     $display("pc : %b instruction : %b", pc, instruction);
   if(jump  || (branch && isZero)) 
   begin 
    pc = immediate;
   end else begin 
       pc = pc + 1;
   end
   if (pc == 5)
   $finish;
    
end
initial begin
clk = 0;
pc = 0;

$dumpfile("out.vcd");
$dumpvars(0,clk, res);
end
always #20 clk =~ clk;


endmodule