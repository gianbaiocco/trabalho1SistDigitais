`timescale 1ns/1ps
// testbench self-checking
module alu_tb;
    logic [7:0]  a, b;
    logic [2:0]  op;
    logic [15:0] result;
    logic [15:0] expected;
    integer     errors = 0, tests = 0;
    integer     i, j, k;

    alu dut (.a(a), .b(b), .op(op), .result(result));

    task compute_expected;
        logic [8:0] t;
        begin
            case (op)
                3'b000: begin t = a + b;           expected = {7'b0, t}; end
                3'b001: begin t = {1'b0,a} - {1'b0,b}; expected = {7'b0, t[8], t[7:0]}; end
                3'b010: expected = a * b;
                3'b011: expected = {13'b0, (a < b), (a == b), (a > b)};
                3'b100: expected = {8'b0, a & b};
                3'b101: expected = {8'b0, a | b};
                3'b110: expected = {8'b0, ~a};
                3'b111: expected = {8'b0, a ^ b};
            endcase
        end
    endtask

    task check;
        begin
            #1;
            compute_expected;
            tests = tests + 1;
            if (result !== expected) begin
                errors = errors + 1;
                if (errors <= 20)
                    $display("ERRO t=%0t op=%b a=%0d b=%0d : obtido=%0d esperado=%0d",
                             $time, op, a, b, result, expected);
            end
        end
    endtask

    initial begin
        for (k = 0; k < 8; k = k + 1)
            for (i = 0; i < 256; i = i + 1)
                for (j = 0; j < 256; j = j + 1) begin
                    op = k[2:0]; a = i[7:0]; b = j[7:0];
                    check;
                end
        $display("Testes: %0d | Erros: %0d", tests, errors);
        if (errors == 0) $display("PASSOU");
        else             $display("FALHOU");
        $finish;
    end
endmodule
