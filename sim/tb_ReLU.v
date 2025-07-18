`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/03 11:07:43
// Design Name: 
// Module Name: tb_ReLU
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


module tb_ReLU();
    reg clk;
    reg rst_n;
    reg in_valid;
    reg  [32-1:0] d_in;
    wire [32-1:0] d_out;
    wire out_valid;
    initial
    begin
        clk = 0;
        rst_n = 0;
        in_valid = 0;
        #20 rst_n = 1;
        d_in = 32'h7ffffffa;
    end
    always #5 clk = ~clk;
    always@(posedge clk)
    begin
        d_in <= d_in+1;
        in_valid <= ~in_valid;
    end
    ReLU u0(
    clk,
    rst_n,
    in_valid,
    d_in,
    d_out,
    out_valid
    );
endmodule
