module alu16(
    input  wire [15:0] A,
    input  wire [15:0] B,
    input  wire [3:0]  op,
    output reg  [15:0] Y
);
    always @(*) begin
        case(op)
            4'h0: Y = A + B;
            4'h1: Y = A & B;
            4'h2: Y = ~A;
            4'h3: Y = A >> 1;
            4'h4: Y = A << 1;
            default: Y = 16'h0000;
        endcase
    end
endmodule