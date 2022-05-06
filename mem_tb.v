module memfile_tb();
reg clk;
reg we;
reg [8:0] address;
reg [15:0] data_in;
wire [15:0] data_out;


mem memfile_tb(.clk(clk), .we(we), .address(address), .data_in(data_in), .data_out(data_out));

initial begin 
    clk = 0;
    we = 0;
    address = 0;
end
always #10 clk =~ clk;
initial begin 
    we <= 1;
    #100
    address <= 8'b0;
    
    #100
    data_in <= 16'b00000011;
     // $monitor("%b", data_out);
    #100
    we <= 0;
    #100
    address <= 8'b0;
    #100
    $monitor("%b yo", data_out);
    #100
  
$finish();
end
endmodule