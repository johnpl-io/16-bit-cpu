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
            ram[address] <= data_in;
        end
    end
    assign data_out = ram[address];

endmodule


