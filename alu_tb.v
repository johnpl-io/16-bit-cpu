`timescale 1ns / 10ps 
module reb_alu;
reg [7:0] a,b;
reg [2:0] ctrl;
wire [7:0] res;
wire Carry;
wire isZero;


alu alu_test(.A(a), .B(b), .ALU_Code(ctrl), .ALU_Out(res), .Carry(Carry), .isZero(isZero));

   initial // initial block executes only once
        begin
            $monitor("sum %b", res);


            a = 8'b00000011;
            b = 8'b00000001;
            ctrl = 3'b110;
          


        end

endmodule // test
