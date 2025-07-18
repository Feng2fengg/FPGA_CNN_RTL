`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/05 17:43:24
// Design Name: 
// Module Name: tb_cnn_top
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


module tb_cnn_top();
	reg clk;
    reg rst_n;
    reg [7:0] d_in;
    reg in_valid;
    wire [50:0] d_out;
    wire out_valid;
	reg [7:0] data [28*28-1:0];
	reg [15:0] i;
	initial
	begin
		$readmemb ("C:/Users/86178/jupyter/number_detect/image_mem.txt", data);
		clk = 0;
		rst_n = 0;
		#50 rst_n = 1;
		i = 0;
	end
	
	
	
	always #5 clk = ~clk;
	always@(posedge clk)
	begin
		d_in <= data[i];
		i <= i+1;
		in_valid <= 1&&(i>=0)&&(i<=28*28-1);
		if(i == 28*28+500) i <= 0;
	end
	
cnn_top u0(
    clk,
    rst_n,
    d_in,
    in_valid,
    d_out,
    out_valid
    );
endmodule
