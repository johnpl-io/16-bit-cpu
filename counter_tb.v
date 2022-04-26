`timescale 1ns / 10ps 
module reb_alu;
reg [7:0] a,a;
reg [2:0] ctrl;
reg [7:0] res;


alu alu_test(.A(a), .B(b), .A_Code(ctrl), .ALU_Out(res));
a = 8'b00000001;
b = 8'b00000001;
ctrl = 3'b001;
$monitor("%b", res);
endmodule // test
