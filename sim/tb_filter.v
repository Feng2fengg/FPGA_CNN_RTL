`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/25 20:27:47
// Design Name: 
// Module Name: tb_filter
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


module tb_filter();
    reg clk;
    reg rst_n;
    reg [32-1:0] d_in1;
    reg [32-1:0] d_in2;
    reg [32-1:0] d_in3;
    reg [32-1:0] d_in4;
    reg [32-1:0] d_in5;
    reg [32*25-1:0] w_in;
    reg [32-1:0] b_in;
    reg in_valid;
    wire [32-1:0] d_out;
    wire out_valid;
    initial
    begin
        clk = 0;
        rst_n = 0;
        w_in = {
        32'h00000005,
        32'h00000004,
        32'h00000003,
        32'h00000002,
        32'h00000001,
        32'h00000005,
        32'h00000004,
        32'h00000003,
        32'h00000002,
        32'h00000001,
        32'h00000005,
        32'h00000004,
        32'h00000003,
        32'h00000002,
        32'h00000001,
        32'h00000005,
        32'h00000004,
        32'h00000003,
        32'h00000002,
        32'h00000001,
        32'h00000005,
        32'h00000004,
        32'h00000003,
        32'h00000002,
        32'h00000001
        };
        b_in = 32'h00000001;
        #20 rst_n = 1;
        in_valid = 3'b00;
        d_in1 = 32'b11111111111111111111111111111011;
        d_in2 = 32'b11111111111111111111111111111100;
        d_in3 = 32'b00000000000000000000000000000110;
        d_in4 = 32'b00000000000000000000000000110010;
        d_in5 = 32'b11111111111111111111111110111100;
    end
    filter u0(
    .clk(clk),
    .rst_n(rst_n),
    .d_in1(d_in1),
    .d_in2(d_in2),
    .d_in3(d_in3),
    .d_in4(d_in4),
    .d_in5(d_in5),
    .w_in(w_in),
    .b_in(b_in),
    .in_valid(in_valid),
    .d_out(d_out),
    .out_valid(out_valid)
    );
    always@(posedge clk)
    begin
        d_in1 <= d_in1 + 1;
        d_in2 <= d_in2 + 1;
        d_in3 <= d_in3 + 1;
        d_in4 <= d_in4 + 1;
        d_in5 <= d_in5 + 1;
        in_valid <= ~in_valid;
    end
    always #5 clk = ~clk;
endmodule
