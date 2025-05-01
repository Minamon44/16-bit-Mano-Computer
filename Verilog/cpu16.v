module cpu16(
    input  wire clk,
    input  wire rst
);
    wire [15:0] BUS;
    wire [15:0] PC_out, AR_out, IR_out, DR_out, AC_out, TR_out;
    wire ld_PC, ld_IR, ld_AR, ld_DR, ld_AC, ld_TR;
    wire en_PC, en_IR, en_AR, en_DR, en_AC, en_TR, en_ALU;
    wire mem_rd, mem_wr;
    wire [3:0] opcode = IR_out[15:12];
    wire [15:0] alu_out;

    reg16 PC (.clk(clk), .rst(rst), .load(ld_PC), .en(en_PC), .bus(BUS), .q(PC_out));
    reg16 AR (.clk(clk), .rst(rst), .load(ld_AR), .en(en_AR), .bus(BUS), .q(AR_out));
    reg16 IR (.clk(clk), .rst(rst), .load(ld_IR), .en(en_IR), .bus(BUS), .q(IR_out));
    reg16 DR (.clk(clk), .rst(rst), .load(ld_DR), .en(en_DR), .bus(BUS), .q(DR_out));
    reg16 AC (.clk(clk), .rst(rst), .load(ld_AC), .en(en_AC), .bus(BUS), .q(AC_out));
    reg16 TR (.clk(clk), .rst(rst), .load(ld_TR), .en(en_TR), .bus(BUS), .q(TR_out));

    mem16 MEM (.clk(clk), .rd(mem_rd), .wr(mem_wr), .addr(AR_out[11:0]), .bus(BUS));
    alu16 ALU (.A(AC_out), .B(DR_out), .op(opcode), .Y(alu_out));
    assign BUS = en_ALU ? alu_out : 16'bz;

    control_fsm CTRL (
        .clk(clk), .rst(rst), .opcode(opcode), .T(),
        .ld_PC(ld_PC), .ld_IR(ld_IR), .ld_AR(ld_AR), .ld_DR(ld_DR),
        .ld_AC(ld_AC), .ld_TR(ld_TR), .en_PC(en_PC), .en_IR(en_IR),
        .en_AR(en_AR), .en_DR(en_DR), .en_AC(en_AC), .en_TR(en_TR),
        .en_ALU(en_ALU), .mem_rd(mem_rd), .mem_wr(mem_wr)
    );
endmodule