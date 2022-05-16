`timescale 1ns/1ns
`include "./imem/imem.v"
`include "./alu/alu.v"
`include "./regfile/regfile.v"
`include "./control/control.v"
`include "./control/aluctrl.v"
`include "./muxes/alumux.v"
`include "./muxes/regfilemux.v"
`include "./mem/mem.v"
`include "./muxes/memmux.v"
module CPU();

wire [15:0] instruction;
reg clk;
reg [15:0] pc;
wire [15:0] res;
wire isZero;

wire [2:0] rs, rt, rd;
wire [2:0] ALU_Code;
wire [2:0] opcode;
wire [3:0] func;

wire jump, branch, memwrite, regwrite, alusrc, reg_dest, memtoreg;
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


alu alu_test(.A(read1), .B(alumuxout), .ALU_Code(ALU_Code), .ALU_Out(res), .isZero(isZero));
regfilemux regfilemux_test(.reg_dest(reg_dest), .rt(rt), .rd(rd), .reg_result(reg_result));
regfile reg_test(.clk(clk), .write_en(regwrite), .rega(rs), .regb(rt), .wreg(reg_result), .writedata(memmuxresult), .read1(read1), .read2(read2));
imem imem_test(.pc(pc), .instruction(instruction));
alumux alumux_test(.immediate(immediate), .read2(read2), .alusrc(alusrc), .alumuxout(alumuxout));
control control_test(.opcode(opcode), .jump(jump), .branch(branch), .memwrite(memwrite), .regwrite(regwrite), .alusrc(alusrc), .reg_dest(reg_dest), .memtoreg(memtoreg));
aluctrl aluctrl_test(.opcode(opcode),.func(func), .ALU_Code(ALU_Code));
mem mem_test(.clk(clk), .we(memwrite), .address(res), .data_in(read2), .data_out(mem_out));
memmux memmux_test(.data_from_mem(mem_out), .alu_result(res), .memtoreg(memtoreg), .memmuxout(memmuxresult));




always @(posedge clk)
begin 
     $display("pc : %b instruction : %b ", pc, instruction);
   if(jump  || (branch && isZero)) 
   begin 
     if(jump)
     pc = jumpaddr;
     if(branch)
    pc = immediate;
   end else begin 
       pc = pc + 1;
   end
   if (instruction == 16'b1111111111111111)
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