module control_fsm(
    input  wire        clk,
    input  wire        rst,
    input  wire [3:0]  opcode,
    output reg [6:0]   T,
    output reg         ld_PC, ld_IR, ld_AR, ld_DR, ld_AC, ld_TR,
    output reg         en_PC, en_IR, en_AR, en_DR, en_AC, en_TR, en_ALU,
    output reg         mem_rd, mem_wr
);
    reg [2:0] state;
    always @(posedge clk or posedge rst)
        if (rst) state <= 3'd0;
        else     state <= (state == 3'd6 ? 3'd0 : state + 1);
    always @(*) begin
        T = 7'b0;
        T[state] = 1'b1;
    end
    always @(*) begin
        {ld_PC, ld_IR, ld_AR, ld_DR, ld_AC, ld_TR,
         en_PC, en_IR, en_AR, en_DR, en_AC, en_TR, en_ALU,
         mem_rd, mem_wr} = 15'b0;
        if (T[0]) begin en_PC = 1; ld_AR = 1; end
        if (T[1]) begin mem_rd = 1; ld_IR = 1; ld_PC = 1; end
        case(opcode)
            4'h0,4'h1,4'h2,4'h3,4'h4: begin
                if (T[2]) en_DR = 1;
                if (T[3]) begin en_AC = 1; en_DR = 1; en_ALU = 1; ld_AC = 1; end
            end
            4'h5: begin
                if (T[2]) begin en_IR = 1; ld_AR = 1; end
                if (T[3]) mem_rd = 1;
                if (T[4]) begin en_AR = 1; mem_rd = 1; ld_DR = 1; end
                if (T[5]) begin en_DR = 1; ld_AC = 1; end
            end
            4'h6: begin
                if (T[2]) begin en_IR = 1; ld_AR = 1; end
                if (T[3]) begin en_AC = 1; ld_DR = 1; end
                if (T[4]) begin en_AR = 1; en_DR = 1; mem_wr = 1; end
            end
            4'h7: if (T[2]) begin en_IR = 1; ld_PC = 1; end
            4'h8: begin
                if (T[2]) begin en_IR = 1; ld_AR = 1; end
                if (T[3]) begin en_PC = 1; ld_DR = 1; end
                if (T[4]) begin en_AR = 1; en_DR = 1; mem_wr = 1; end
                if (T[5]) ld_PC = 1;
            end
            4'h9: begin
                if (T[2]) begin en_IR = 1; ld_AR = 1; end
                if (T[3]) begin mem_rd = 1; ld_DR = 1; end
                if (T[4]) begin en_DR = 1; ld_DR = 1; end
                if (T[5]) begin en_AR = 1; en_DR = 1; mem_wr = 1; end
                if (T[6]) ld_PC = 1;
            end
            4'hA: begin if (T[2]) ld_DR = 1; if (T[3]) begin en_DR = 1; ld_AC = 1; end end
            4'hB: begin if (T[2]) begin en_AC = 1; ld_DR = 1; end end
            4'hF: ;
        endcase
    end
endmodule