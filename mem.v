module mem (
    input clk,
    input we,
    input [15:0] address,
    input [15:0] data_in,
    output [15:0] data_out
);

reg [15:0] ram [0:255];

always @ (posedge clk)
    begin
        if (we) begin
   //     $display("%b %b", data_in, address);
            ram[address] <= data_in;
        end
        $monitor("ram [0]: %b \nram [1]: %b\n ", ram[0], ram[1]);
    end
    assign data_out = ram[address];
      

endmodule


