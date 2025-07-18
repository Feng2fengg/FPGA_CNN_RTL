`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/01 23:47:15
// Design Name: 
// Module Name: pool_kernel
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

module pool_kernel #(
    parameter data_width = 16,
    parameter w_width = 16,
	parameter din_num = 12*24
    )
    (
    input clk,
    input rst_n,
    input [data_width-1:0] d_in1,
    input [data_width-1:0] d_in2,
    input in_valid,
    output reg [data_width-1:0] d_out,
    output reg out_valid
    );
    
	reg [15:0] cnt;
    reg [data_width-1:0] data [3:0];
    reg [data_width-1:0] d_max1, d_max2;
    reg out_valid_r;
    reg in_valid_r;
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) begin data[0] <= 0; data[1] <= 0; data[2] <= 0; data[3] <= 0; end
        else if(in_valid) begin data[3] <= data[1]; data[2] <= data[0]; data[1] <= d_in2; data[0] <= d_in1; end
        else begin data[0] <= data[0]; data[1] <= data[1]; data[2] <= data[2]; data[3] <= data[3]; end
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) begin d_max1 <= 0; d_max2 <=0; d_out <= 0; end
        else
        begin
            d_max1 <= (data[3] > data[2]) ? data[3] : data[2];
            d_max2 <= (data[1] > data[0]) ? data[1] : data[0];
            d_out <= (d_max1 > d_max2) ? d_max1 : d_max2;
        end
    end
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) begin cnt <= 0; out_valid <= 0; out_valid_r <=0; in_valid_r <= 0; end
        else if(in_valid && (cnt < din_num)) cnt <= cnt + 1;
        else if(in_valid && (cnt == din_num)) cnt <= 1;
        else cnt <= cnt;
        in_valid_r <= in_valid;
        out_valid_r <= in_valid_r && ((cnt % 2) == 0) && (cnt != 0);
        out_valid <= out_valid_r;
    end
    
endmodule