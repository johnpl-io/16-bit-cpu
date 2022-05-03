`include "imem.v"
module imem_tb();
reg [15:0] pc;
wire [15:0] instruction;

imem imem_test(pc, instruction);

   initial // initial block executes only once
        begin
           
            pc <= 16'b0;
            $monitor("%b", instruction);

        end
endmodule