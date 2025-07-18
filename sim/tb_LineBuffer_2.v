`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/01 22:22:41
// Design Name: 
// Module Name: tb_LineBuffer_2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_LineBuffer_2();
    reg rst_n;
    reg [31:0] d_in;
    reg in_valid;
    wire [31:0] d_out1;
    wire [31:0] d_out2;
    wire out_valid;
    reg clk;
    initial
    begin
        clk = 0;
        rst_n = 0;
        in_valid = 0;
        #20 rst_n = 1;
        d_in = 0;
    end
    always #5 clk = ~clk;
    always@(posedge clk)
    begin
        d_in <= d_in+1;
        in_valid <= ~in_valid;
    end
    LineBuffer_2 u0
    (
    .clk(clk),
    .rst_n(rst_n),
    .d_in(d_in),
    .in_valid(in_valid),
    .d_out1(d_out1),
    .d_out2(d_out2),
    .out_valid(out_valid)
    );
endmodule
