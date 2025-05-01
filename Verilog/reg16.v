module reg16(
    input  wire        clk,
    input  wire        rst,
    input  wire        load,
    input  wire        en,
    inout  wire [15:0] bus,
    output wire [15:0] q
);
    reg [15:0] data;
    assign q = data;
    always @(posedge clk or posedge rst)
        if (rst)      data <= 16'b0;
        else if (load) data <= bus;
    assign bus = en ? data : 16'bz;
endmodule