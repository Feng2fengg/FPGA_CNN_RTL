`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/25 13:58:56
// Design Name: 
// Module Name: LineBuffer
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
// �������֤����Ŀ��Ŀ¼ LICENSE �ļ�

module LineBuffer #(
    parameter map_width = 28,//��������ͼ�Ŀ��
    parameter data_width = 16,//�������ݵĿ��
    parameter din_num = 28*28
    )
    (
    input clk,
    input rst_n,
    input [data_width-1:0] d_in,
    input in_valid,
    output reg [data_width-1:0] d_out1,
    output reg [data_width-1:0] d_out2,
    output reg [data_width-1:0] d_out3,
    output reg [data_width-1:0] d_out4,
    output reg [data_width-1:0] d_out5,
    output reg out_valid
    );
    
    reg [data_width-1:0] shift_r [map_width*4:0];
    reg [15:0] cnt;//���ڼ�¼���������ͼ���ݸ���
    reg in_valid_r;
    
    integer i;
    always@(posedge clk)
    begin
        if(in_valid) shift_r[0] <= d_in;
        else shift_r[0] <= shift_r[0];
        for(i=1; i<=map_width*4; i=i+1)
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
    
    always@(posedge clk)
    begin
        in_valid_r <= in_valid;
        d_out1 <= shift_r[4*map_width];
        d_out2 <= shift_r[3*map_width];
        d_out3 <= shift_r[2*map_width];
        d_out4 <= shift_r[1*map_width];
        d_out5 <= shift_r[0*map_width];
        out_valid <= (cnt>4*map_width) && in_valid_r;
    end
    
endmodule
