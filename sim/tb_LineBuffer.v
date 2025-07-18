`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/25 14:45:35
// Design Name: 
// Module Name: tb_LineBuffer
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


module tb_LineBuffer();
    reg rst_n;
    reg [31:0] d_in;
    reg in_valid;
    wire [31:0] d_out1;
    wire [31:0] d_out2;
    wire [31:0] d_out3;
    wire [31:0] d_out4;
    wire [31:0] d_out5;
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
    LineBuffer u0
    (
    .clk(clk),
    .rst_n(rst_n),
    .d_in(d_in),
    .in_valid(in_valid),
    .d_out1(d_out1),
    .d_out2(d_out2),
    .d_out3(d_out3),
    .d_out4(d_out4),
    .d_out5(d_out5),
    .out_valid(out_valid)
    );
endmodule
