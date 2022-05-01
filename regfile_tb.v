`timescale 1ns / 10ps 
module regfile_tb();
reg clk;



alu alu_test(.A(a), .B(b), .ALU_Code(ctrl), .ALU_Out(res), .Carry(Carry), .isZero(isZero));

   initial // initial block executes only once
        begin
            $monitor("sum %b", res);


            a = 8'd2;
            b = 8'd5;
            ctrl = 3'b001;
          


        end

endmodule // test
