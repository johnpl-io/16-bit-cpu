module imem(
    input [15:0] pc,
    output [15:0] instruction
);

    reg [15:0] ram [0:255];

    initial $readmemh("code.txt", ram);
    assign instruction = ram[pc];

endmodule