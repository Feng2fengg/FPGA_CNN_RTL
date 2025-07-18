`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/01 15:02:37
// Design Name: 
// Module Name: LineBuffer_2
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

module LineBuffer_2 #(
    parameter map_width = 24,//输入特征图的宽度
    parameter data_width = 16,//输入数据的宽度
    parameter din_num = 24*24
    )
    (
    input clk,
    input rst_n,
    input [data_width-1:0] d_in,
    input in_valid,
    output reg [data_width-1:0] d_out1,
    output reg [data_width-1:0] d_out2,
    output reg out_valid
    );
    
    reg [data_width-1:0] shift_r [map_width*1:0];
    reg [15:0] cnt;//用于记录缓存的特征图数据个数
    reg in_valid_r;
    reg flag;
    
    integer i;
    always@(posedge clk)
    begin
        if(in_valid) shift_r[0] <= d_in;
        else shift_r[0] <= shift_r[0];
        for(i=1; i<=map_width*1; i=i+1)
        begin
            if(in_valid) shift_r[i] <= shift_r[i-1];
            else shift_r[i] <= shift_r[i];
        end
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n) cnt <= 8'b0;
        else if(in_valid && (cnt < din_num)) cnt <= cnt + 1;
        else if(in_valid && (cnt == din_num)) cnt <= 1;
        else cnt <= cnt;
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n) flag <= 0;
        else if(in_valid && ((cnt % map_width) == 0) && (cnt != 0)) flag <= flag + 1;
        else flag <= flag;
    end
    
    always@(posedge clk)
    begin
        in_valid_r <= in_valid;
        d_out1 <= shift_r[1*map_width];
        d_out2 <= shift_r[0*map_width];
        out_valid <= (cnt>1*map_width) && in_valid_r && flag;
    end
    
endmodule

