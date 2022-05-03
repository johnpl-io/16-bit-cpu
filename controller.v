module CPU();

wire [15:0] instruction;
reg clk;
wire [15:0] reg1, reg2, wreg;
wire [3:0] ALU_Code;
//decoding 
assign opcode = instruction[15:9];
assign wreg = instruction[8:6];
assign reg1 = instruction[5:3];
assign reg1 = instruction[2:0];

always @(posedge clk)
begin case(opcode)
    

endmodule