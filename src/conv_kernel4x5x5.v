`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/03 15:45:39
// Design Name: 
// Module Name: conv_kernel4x5x5
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
// Copyright (c) 2025 Feng2fengg. MIT License.
// 完整许可证见项目根目录 LICENSE 文件

module conv_kernel4x5x5 #(
    parameter data_width = 16,
    parameter w_width = 16,
    parameter map_width = 28
    )   
    (
    input clk,
    input rst_n,
    input [data_width-1:0] d_in1_1,
	input [data_width-1:0] d_in2_1,
	input [data_width-1:0] d_in3_1,
	input [data_width-1:0] d_in4_1,
	input [data_width-1:0] d_in5_1,
	input in_valid_1,
	input [data_width-1:0] d_in1_2,
	input [data_width-1:0] d_in2_2,
	input [data_width-1:0] d_in3_2,
	input [data_width-1:0] d_in4_2,
	input [data_width-1:0] d_in5_2,
	input in_valid_2,
	input [data_width-1:0] d_in1_3,
	input [data_width-1:0] d_in2_3,
	input [data_width-1:0] d_in3_3,
	input [data_width-1:0] d_in4_3,
	input [data_width-1:0] d_in5_3,
	input in_valid_3,
	input [data_width-1:0] d_in1_4,
	input [data_width-1:0] d_in2_4,
	input [data_width-1:0] d_in3_4,
	input [data_width-1:0] d_in4_4,
	input [data_width-1:0] d_in5_4,
	input in_valid_4,
	input [w_width*25-1:0] w_in1,
	input [w_width*25-1:0] w_in2,
	input [w_width*25-1:0] w_in3,
	input [w_width*25-1:0] w_in4,
	input [w_width-1:0] b_in,
	output [w_width+data_width+5:0] d_out,
	output out_valid
    );
    
    wire [w_width+data_width+3:0] d_out1, d_out2, d_out3, d_out4;
    wire out_valid1, out_valid2, out_valid3, out_valid4;
    
conv_kernel2 #(data_width, w_width, map_width) conv1   
    (
    clk,
    rst_n,
    d_in1_1,
    d_in2_1,
    d_in3_1,
    d_in4_1,
    d_in5_1,
    in_valid_1,
    w_in1,
    0,
    d_out1,
    out_valid1
    );            

conv_kernel2 #(data_width, w_width, map_width) conv2   
    (
    clk,
    rst_n,
    d_in1_2,
    d_in2_2,
    d_in3_2,
    d_in4_2,
    d_in5_2,
    in_valid_2,
    w_in2,
    0,
    d_out2,
    out_valid2
    );
    
conv_kernel2 #(data_width, w_width, map_width) conv3   
    (
    clk,
    rst_n,
    d_in1_3,
    d_in2_3,
    d_in3_3,
    d_in4_3,
    d_in5_3,
    in_valid_3,
    w_in3,
    0,
    d_out3,
    out_valid3
    );            

conv_kernel2 #(data_width, w_width, map_width) conv4   
    (
    clk,
    rst_n,
    d_in1_4,
    d_in2_4,
    d_in3_4,
    d_in4_4,
    d_in5_4,
    in_valid_4,
    w_in4,
    0,
    d_out4,
    out_valid4
    );

assign d_out = {{2{d_out1[w_width+data_width+3]}},d_out1} + {{2{d_out2[w_width+data_width+3]}},d_out2} + {{2{d_out3[w_width+data_width+3]}},d_out3} + {{2{d_out4[w_width+data_width+3]}},d_out4} +{{data_width-w_width+7{b_in[w_width-1]}},b_in,{w_width-1{1'b0}}};
assign out_valid = out_valid1 && out_valid2 && out_valid3 && out_valid4;

endmodule
