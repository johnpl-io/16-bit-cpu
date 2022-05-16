`include "alu.v"
`timescale 1ns / 10ps 
module alu_tb();
reg [15:0] a,b;
reg [2:0] ctrl;
wire [15:0] res;
wire Carry;
wire isZero;


alu alu_test(.A(a), .B(b), .ALU_Code(ctrl), .ALU_Out(res), .Carry(Carry), .isZero(isZero));

   initial // initial block executes only once
        begin
            $monitor("result %d", res);


            a = 8'd5;
            b = 8'd2;
            ctrl = 3'b011;
          


        end

endmodule // test
