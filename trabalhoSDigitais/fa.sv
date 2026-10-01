// full-adder 1 bit
module fa (input a, input b, input cin, output s, output cout);
    logic s1, c1, c2;
    ha u_ha0 (.a(a),  .b(b),   .s(s1), .cout(c1));
    ha u_ha1 (.a(s1), .b(cin), .s(s),  .cout(c2));
    assign cout = c1 | c2;
endmodule
