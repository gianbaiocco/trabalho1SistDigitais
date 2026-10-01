// mux 8x8
module mul8 (input [7:0] a, input [7:0] b, output [15:0] p);
    logic [7:0] upper [0:7];   // parte alta acumulada apos cada linha
    logic [7:0] sum   [1:7];
    logic       cy    [1:7];

    // linha 0: produtos parciais a & b[0]
    assign p[0]     = a[0] & b[0];
    assign upper[0] = {1'b0, (a & {8{b[0]}}) >> 1};

    genvar i;
    generate
        for (i = 1; i < 8; i = i + 1) begin : g_row
            adder8 u_row (.a(upper[i-1]), .b(a & {8{b[i]}}), .cin(1'b0),
                          .s(sum[i]), .cout(cy[i]));
            assign p[i]     = sum[i][0];
            assign upper[i] = {cy[i], sum[i][7:1]};
        end
    endgenerate
    assign p[15:8] = upper[7];
endmodule