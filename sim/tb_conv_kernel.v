`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/26 21:34:48
// Design Name: 
// Module Name: tb_conv_kernel
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


module tb_conv_kernel();
    reg clk;
    reg rst_n;
    reg [31:0] d_in1;
	reg [31:0] d_in2;
	reg [31:0] d_in3;
	reg [31:0] d_in4;
	reg [31:0] d_in5;
	reg in_valid;
	reg [799:0] w_in;
	reg [31:0] b_in;
	wire [31:0] d_out;
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
        d_in1 = 0;
        d_in2 = 0;
        d_in3 = 0;
        d_in4 = 0;
        d_in5 = 0;
    end
	
    conv_kernel u0(
    clk,
    rst_n,
    d_in1,
	d_in2,
	d_in3,
	d_in4,
	d_in5,
	in_valid,
	w_in,
	b_in,
	d_out,
	out_valid
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
