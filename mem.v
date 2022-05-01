module mem (
    input clk,
    input we,
    input [8:0] address,
    input [15:0] data_in,
    output reg [15:0] data_out
);

reg [15:0] ram [0:255];

always @ (posedge clk)
    begin
        if (we)
            ram[address] <= data_in;
        data_out <= ram[address];
    end

endmodule


