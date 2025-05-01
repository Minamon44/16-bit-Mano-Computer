`timescale 1ns / 1ps

module tb_cpu16;
    reg clk = 0;
    reg rst;

    cpu16 uut (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;

    initial begin
        rst = 1;
        #20 rst = 0;
        #1000 $finish;
    end
endmodule