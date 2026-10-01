// ULA 8 bits
// op: 000 SUM | 001 SUB | 010 MUL | 011 COM | 100 AND | 101 OR | 110 NOT(A) | 111 XOR
module alu (input [7:0] a, input [7:0] b, input [2:0] op,
            output logic [15:0] result);
    localparam logic [2:0] OP_SUM = 3'b000, OP_SUB = 3'b001, OP_MUL = 3'b010,
                           OP_COM = 3'b011, OP_AND = 3'b100, OP_OR  = 3'b101,
                           OP_NOT = 3'b110;   // 3'b111 = XOR (default)

    logic       is_sub;
    assign is_sub = (op == OP_SUB) | (op == OP_COM);
    logic [7:0] as_s;
    logic       as_c;
    addsub8 u_addsub (.a(a), .b(b), .sub(is_sub), .s(as_s), .cout(as_c));

    logic [15:0] prod;
    mul8 u_mul (.a(a), .b(b), .p(prod));

    logic eq, lt, gt;
    assign eq = ~(|as_s);         // A-B == 0
    assign lt = ~as_c;            // borrow
    assign gt = as_c & ~eq;

    always_comb begin
        case (op)
            OP_SUM:  result = {7'b0, as_c, as_s};
            OP_SUB:  result = {7'b0, ~as_c, as_s};
            OP_MUL:  result = prod;
            OP_COM:  result = {13'b0, lt, eq, gt};
            OP_AND:  result = {8'b0, a & b};
            OP_OR:   result = {8'b0, a | b};
            OP_NOT:  result = {8'b0, ~a};
            default: result = {8'b0, a ^ b};   // 3'b111
        endcase
    end
endmodule
