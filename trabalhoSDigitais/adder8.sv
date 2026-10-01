// somador 8 bits
module adder8 (input [7:0] a, input [7:0] b, input cin,
               output [7:0] s, output cout);
    logic [8:0] c;
    assign c[0] = cin;
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : g_fa
            fa u_fa (.a(a[i]), .b(b[i]), .cin(c[i]), .s(s[i]), .cout(c[i+1]));
        end
    endgenerate
    assign cout = c[8];
endmodule