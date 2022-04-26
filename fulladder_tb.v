// half_adder_tb.v

 // time-unit = 1 ns, precision = 10 ps

module half_adder_tb;

    reg a, b;
    wire sum, carry;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns


    half_adder UUT (.a(a), .b(b), .sum(sum), .carry(carry));
    
    initial // initial block executes only once
        begin
            $monitor("sum %b", sum);


            a = 0;
            b = 1;

        end
endmodule
