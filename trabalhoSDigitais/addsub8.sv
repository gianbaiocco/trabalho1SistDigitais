// somadorr/subtrator: sub=0 -> A+B ; sub=1 -> A-B (A + ~B + 1)
// cout = 1 (A >= B)
module addsub8 (input [7:0] a, input [7:0] b, input sub,
                output [7:0] s, output cout);
    logic [7:0] bx;
    assign bx = b ^ {8{sub}};
    adder8 u_add (.a(a), .b(bx), .cin(sub), .s(s), .cout(cout));
endmodule
