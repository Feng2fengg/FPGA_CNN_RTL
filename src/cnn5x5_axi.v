`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/11 11:43:24
// Design Name: 
// Module Name: cnn5x5_axi
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

module cnn5x5_axi_stream #
  (
    // Parameters for AXI Stream interfaces
    parameter integer C_M00_AXIS_TDATA_WIDTH = 32,
    parameter integer C_S00_AXIS_TDATA_WIDTH = 32
  )
  (
    // Ports of Axi Master Bus Interface M00_AXIS
    input wire m00_axis_aclk,
    input wire m00_axis_aresetn,
    output wire m00_axis_tvalid,
    output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
    output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1 : 0] m00_axis_tstrb,
    output wire m00_axis_tlast,
    input wire m00_axis_tready,

    // Ports of Axi Slave Bus Interface S00_AXIS
    input wire s00_axis_aclk,
    input wire s00_axis_aresetn,
    output wire s00_axis_tready,
    input wire [C_S00_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
    input wire [(C_S00_AXIS_TDATA_WIDTH/8)-1 : 0] s00_axis_tstrb,
    input wire s00_axis_tlast,
    input wire s00_axis_tvalid
  );

  // Internal signals for integration
    wire [7:0] cnn_d_in;      // Input to CNN module (32-bit)
    wire cnn_in_valid;         // Valid signal for CNN input
    wire [31:0] cnn_d_out;   // Output from CNN module (32-bit)
    wire cnn_out_valid;        // Output valid signal from CNN module
    wire cnn_rd_en;
    //wire cnn_we_en;

  cnn_top cnn_inst (
    .clk(m00_axis_aclk),
    .rst_n(m00_axis_aresetn),
    .d_in(cnn_d_in),
    .in_valid(cnn_in_valid),
    .d_out(cnn_d_out),
    .rd_en(cnn_rd_en),
    //.we_en(cnn_we_en),
    .out_valid(cnn_out_valid),
    .out_last(cnn_out_last)
  );

  assign m00_axis_tdata = cnn_d_out;
  assign m00_axis_tstrb = 4'b1111;
  assign s00_axis_tready = 1'b1;
  assign m00_axis_tvalid = cnn_out_valid;
  assign m00_axis_tlast = cnn_out_last;
  
  assign cnn_rd_en = m00_axis_tready;
  assign cnn_in_valid = s00_axis_tvalid;
  assign cnn_d_in = s00_axis_tdata[7:0];
    
endmodule

