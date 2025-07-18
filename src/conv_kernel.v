`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/26 20:55:36
// Design Name: 
// Module Name: conv_kernel
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

module conv_kernel #(
    parameter data_width = 16,
    parameter w_width = 16,
    parameter map_width = 28
    )   
    (
    input clk,
    input rst_n,
    input [data_width-1:0] d_in1,
	input [data_width-1:0] d_in2,
	input [data_width-1:0] d_in3,
	input [data_width-1:0] d_in4,
	input [data_width-1:0] d_in5,
	input in_valid,
	input [w_width*25-1:0] w_in,
	input [w_width-1:0] b_in,
	output [w_width+data_width-5:0] d_out,
	output out_valid
    );
    
    wire [w_width+data_width-5:0] d_out_t [4:0];
    wire out_valid_t [4:0];
    wire in_valid1, in_valid2, in_valid3, in_valid4, in_valid5;
    reg in_valid_r;
    reg [data_width-1:0] data [4:0];
    reg [15:0] col_cnt;
        
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) col_cnt <= 0;
        else if(in_valid && col_cnt < map_width) col_cnt <= col_cnt + 1;
        else if(in_valid && col_cnt == map_width) col_cnt <= 1;
        else col_cnt <= col_cnt;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n)
        begin
            data[0] <= 0;
            data[1] <= 0;
			data[2] <= 0;
            data[3] <= 0;
			data[4] <= 0;
        end
        else if(in_valid)
        begin
			data[0] <= d_in1;
            data[1] <= d_in2;
			data[2] <= d_in3;
            data[3] <= d_in4;
			data[4] <= d_in5;
        end
    end
    
	always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) in_valid_r <= 0; 
        else in_valid_r <= in_valid;
    end
    
    assign in_valid1 = in_valid_r && (col_cnt <= map_width-(map_width-0)%5) && (col_cnt >= 1);
    assign in_valid2 = in_valid_r && (col_cnt <= map_width-(map_width-1)%5) && (col_cnt >= 2);
    assign in_valid3 = in_valid_r && (col_cnt <= map_width-(map_width-2)%5) && (col_cnt >= 3);
    assign in_valid4 = in_valid_r && (col_cnt <= map_width-(map_width-3)%5) && (col_cnt >= 4);
    assign in_valid5 = in_valid_r && (col_cnt <= map_width-(map_width-4)%5) && (col_cnt >= 5);
    
    filter #(data_width,w_width) u1(
    .clk(clk),
    .rst_n(rst_n),
    .d_in1(data[0]),
    .d_in2(data[1]),
    .d_in3(data[2]),
    .d_in4(data[3]),
    .d_in5(data[4]),
    .w_in(w_in),
    .b_in(b_in),
    .in_valid(in_valid1),
    .d_out(d_out_t[0]),
    .out_valid(out_valid_t[0])
    );
	
	filter #(data_width,w_width) u2(
    .clk(clk),
    .rst_n(rst_n),
    .d_in1(data[0]),
    .d_in2(data[1]),
    .d_in3(data[2]),
    .d_in4(data[3]),
    .d_in5(data[4]),
    .w_in(w_in),
    .b_in(b_in),
    .in_valid(in_valid2),
    .d_out(d_out_t[1]),
    .out_valid(out_valid_t[1])
    );

	filter #(data_width,w_width) u3(
    .clk(clk),
    .rst_n(rst_n),
    .d_in1(data[0]),
    .d_in2(data[1]),
    .d_in3(data[2]),
    .d_in4(data[3]),
    .d_in5(data[4]),
    .w_in(w_in),
    .b_in(b_in),
    .in_valid(in_valid3),
    .d_out(d_out_t[2]),
    .out_valid(out_valid_t[2])
    );
	
	filter #(data_width,w_width) u4(
    .clk(clk),
    .rst_n(rst_n),
    .d_in1(data[0]),
    .d_in2(data[1]),
    .d_in3(data[2]),
    .d_in4(data[3]),
    .d_in5(data[4]),
    .w_in(w_in),
    .b_in(b_in),
    .in_valid(in_valid4),
    .d_out(d_out_t[3]),
    .out_valid(out_valid_t[3])
    );
	
	filter #(data_width,w_width) u5(
    .clk(clk),
    .rst_n(rst_n),
    .d_in1(data[0]),
    .d_in2(data[1]),
    .d_in3(data[2]),
    .d_in4(data[3]),
    .d_in5(data[4]),
    .w_in(w_in),
    .b_in(b_in),
    .in_valid(in_valid5),
    .d_out(d_out_t[4]),
    .out_valid(out_valid_t[4])
    );
    
    assign d_out =  ({w_width+data_width-4{out_valid_t[0]}} & d_out_t[0])+
                    ({w_width+data_width-4{out_valid_t[1]}} & d_out_t[1])+
                    ({w_width+data_width-4{out_valid_t[2]}} & d_out_t[2])+
                    ({w_width+data_width-4{out_valid_t[3]}} & d_out_t[3])+
                    ({w_width+data_width-4{out_valid_t[4]}} & d_out_t[4]);
    assign out_valid = out_valid_t[0] || out_valid_t[1] || out_valid_t[2] || out_valid_t[3] || out_valid_t[4];
    
endmodule