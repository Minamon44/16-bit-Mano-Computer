module mem16(
    input  wire clk,
    input  wire rd,
    input  wire wr,
    input  wire [11:0] addr,
    inout  wire [15:0] bus
);
    reg [15:0] mem [0:4095];
    initial $readmemh("instr_rom.mem", mem);
    always @(posedge clk) begin
        if (wr) mem[addr] <= bus;
    end
    assign bus = rd ? mem[addr] : 16'bz;
endmodule