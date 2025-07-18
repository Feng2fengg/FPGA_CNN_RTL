`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/01 23:47:42
// Design Name: 
// Module Name: tb_pool_kernel
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


module tb_pool_kernel();
    reg clk;
    reg rst_n;
    reg [32-1:0] d_in1;
    reg [32-1:0] d_in2;
    reg in_valid;
    wire [32-1:0] d_out;
    wire out_valid;
    initial
    begin
        clk = 0;
        rst_n = 0;
        #20 rst_n = 1;
        in_valid = 3'b00;
        d_in1 = 0;
        d_in2 = 0;
    end
    pool_kernel u0(
    .clk(clk),
    .rst_n(rst_n),
    .d_in1(d_in1),
    .d_in2(d_in2),
    .in_valid(in_valid),
    .d_out(d_out),
    .out_valid(out_valid)
    );
    always@(posedge clk)
    begin
        d_in1 <= d_in1 + 1;
        d_in2 <= d_in2 + 1;
        in_valid <= ~in_valid;
    end
    always #5 clk = ~clk;
endmodule
