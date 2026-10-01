// top para Nexys A7: SW[15:8]=A, SW[7:0]=B, op = {BTNU, BTNC, BTND}, LED[15:0]=resultado
module alu_top (input [15:0] sw, input btnu, input btnc, input btnd,
                output [15:0] led);
    alu u_alu (.a(sw[15:8]), .b(sw[7:0]), .op({btnu, btnc, btnd}), .result(led));
endmodule
