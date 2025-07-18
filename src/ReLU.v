`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/03 10:47:46
// Design Name: 
// Module Name: ReLU
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

module ReLU #(
    data_width = 16
    )
    (
    input clk,
    input rst_n,
    input in_valid,
    input  [data_width-1:0] d_in,
    output reg [data_width-1:0] d_out,
    output reg out_valid
    );
    
    always@(posedge clk, negedge rst_n)
    begin
        if(!rst_n) begin d_out <= 0; out_valid <= 0; end
        else if(d_in[data_width-1])begin d_out <= 0; out_valid <= in_valid; end
        else if(!d_in[data_width-1]) begin d_out <= d_in; out_valid <= in_valid; end
        else begin d_out <= d_out; out_valid <= 0; end
    end
    
endmodule
