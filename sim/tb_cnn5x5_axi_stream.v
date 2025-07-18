`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/11 14:09:54
// Design Name: 
// Module Name: tb_cnn5x5_axi_stream
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


module tb_cnn5x5_axi_stream();
    reg m00_axis_aclk;
    reg m00_axis_aresetn;
    wire m00_axis_tvalid;
    wire [31 : 0] m00_axis_tdata;
    wire [3 : 0] m00_axis_tstrb;
    wire m00_axis_tlast;
    reg m00_axis_tready;
    reg s00_axis_aclk;
    reg s00_axis_aresetn;
    wire s00_axis_tready;
    reg [31 : 0] s00_axis_tdata;
    reg [3 : 0] s00_axis_tstrb;
    reg s00_axis_tlast;
    reg s00_axis_tvalid;
	
	reg [7:0] data [28*28-1:0];
	reg [15:0] i;
	
	initial
	begin
		$readmemb ("C:/Users/86178/jupyter/number_detect/image_mem.txt", data);
		m00_axis_aresetn = 0;
		s00_axis_aresetn = 0;
		#100
		m00_axis_aresetn = 1;
		s00_axis_aresetn = 1;
		m00_axis_aclk = 0;
		s00_axis_aclk = 0;
		s00_axis_tstrb = 4'b1111;
		i = 0;
		m00_axis_tready = 1;
	end
	
	always #5 m00_axis_aclk = ~m00_axis_aclk;
	always #5 s00_axis_aclk = ~s00_axis_aclk;
		
	always@(posedge m00_axis_aclk)
	begin
		s00_axis_tdata <= {{24{1'b0}},data[i]};
		s00_axis_tvalid <= 1&&(i>=0)&&(i<=28*28-1)&&s00_axis_tready;
		if(s00_axis_tvalid && s00_axis_tready) i <= i+1;
		else i <= i;
		if(i == 28*28-1) begin s00_axis_tlast <= 1;end
		else s00_axis_tlast <= 0;
	end
cnn5x5_axi_stream u0
  (
    m00_axis_aclk,
    m00_axis_aresetn,
    m00_axis_tvalid,
    m00_axis_tdata,
    m00_axis_tstrb,
    m00_axis_tlast,
    m00_axis_tready,
    s00_axis_aclk,
    s00_axis_aresetn,
    s00_axis_tready,
    s00_axis_tdata,
    s00_axis_tstrb,
    s00_axis_tlast,
    s00_axis_tvalid
  );
endmodule
