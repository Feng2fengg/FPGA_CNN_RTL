`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/01/25 18:54:27
// Design Name: 
// Module Name: filter
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

module filter #(
    parameter data_width = 16,
    parameter w_width = 16
    )
    (
    input clk,
    input rst_n,
    input [data_width-1:0] d_in1,
    input [data_width-1:0] d_in2,
    input [data_width-1:0] d_in3,
    input [data_width-1:0] d_in4,
    input [data_width-1:0] d_in5,
    input [w_width*25-1:0] w_in,
    input [w_width-1:0] b_in,
    input in_valid,
    output [w_width+data_width-5:0] d_out,
    //output [w_width+data_width+3:0] d_out,
    output reg out_valid
    );
    
    wire [w_width-1:0] w_in1, w_in2, w_in3, w_in4, w_in5; 
    wire [w_width+data_width-2:0] p1, p2, p3, p4, p5;
    reg [w_width+data_width+3:0] P1, P2, P3, P4, P5;
    reg [w_width+data_width+3:0] P;
    reg [2:0] flag;
    reg in_valid_r;
    reg [2:0] flag_r;
    
    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) flag <= 3'b000;
        else if((flag == 3'b000) && in_valid) begin flag <= 3'b001; end
        else if((flag == 3'b001) && in_valid) begin flag <= 3'b010; end
        else if((flag == 3'b010) && in_valid) begin flag <= 3'b011; end
        else if((flag == 3'b011) && in_valid) begin flag <= 3'b100; end
        else if((flag == 3'b100) && in_valid) begin flag <= 3'b000; end
        else begin flag <= flag; end
    end
    
    assign w_in1 = (flag == 3'b000)? w_in[w_width*25-1:w_width*24] : (flag == 3'b001)? w_in[w_width*24-1:w_width*23] : (flag == 3'b010)? w_in[w_width*23-1:w_width*22] : (flag == 3'b011)? w_in[w_width*22-1:w_width*21] : w_in[w_width*21-1:w_width*20];
    assign w_in2 = (flag == 3'b000)? w_in[w_width*20-1:w_width*19] : (flag == 3'b001)? w_in[w_width*19-1:w_width*18] : (flag == 3'b010)? w_in[w_width*18-1:w_width*17] : (flag == 3'b011)? w_in[w_width*17-1:w_width*16] : w_in[w_width*16-1:w_width*15];
    assign w_in3 = (flag == 3'b000)? w_in[w_width*15-1:w_width*14] : (flag == 3'b001)? w_in[w_width*14-1:w_width*13] : (flag == 3'b010)? w_in[w_width*13-1:w_width*12] : (flag == 3'b011)? w_in[w_width*12-1:w_width*11] : w_in[w_width*11-1:w_width*10];
    assign w_in4 = (flag == 3'b000)? w_in[w_width*10-1:w_width*9]  : (flag == 3'b001)? w_in[w_width*9-1:w_width*8]   : (flag == 3'b010)? w_in[w_width*8-1:w_width*7]   : (flag == 3'b011)? w_in[w_width*7-1:w_width*6]   : w_in[w_width*6-1:w_width*5]  ;
    assign w_in5 = (flag == 3'b000)? w_in[w_width*5-1:w_width*4]   : (flag == 3'b001)? w_in[w_width*4-1:w_width*3]   : (flag == 3'b010)? w_in[w_width*3-1:w_width*2]   : (flag == 3'b011)? w_in[w_width*2-1:w_width*1]   : w_in[w_width*1-1:w_width*0]  ;
    
    /*assign w_in1 = (flag == 3'b000)? w_in[w_width*1-1:w_width*0]   : (flag == 3'b001)? w_in[w_width*2-1:w_width*1]   : (flag == 3'b010)? w_in[w_width*3-1:w_width*2]   : (flag == 3'b011)? w_in[w_width*4-1:w_width*3]   : w_in[w_width*5-1:w_width*4]  ;
    assign w_in2 = (flag == 3'b000)? w_in[w_width*6-1:w_width*5]   : (flag == 3'b001)? w_in[w_width*7-1:w_width*6]   : (flag == 3'b010)? w_in[w_width*8-1:w_width*7]   : (flag == 3'b011)? w_in[w_width*9-1:w_width*8]   : w_in[w_width*10-1:w_width*9] ;
    assign w_in3 = (flag == 3'b000)? w_in[w_width*11-1:w_width*10] : (flag == 3'b001)? w_in[w_width*12-1:w_width*11] : (flag == 3'b010)? w_in[w_width*13-1:w_width*12] : (flag == 3'b011)? w_in[w_width*14-1:w_width*13] : w_in[w_width*15-1:w_width*14];
    assign w_in4 = (flag == 3'b000)? w_in[w_width*16-1:w_width*15] : (flag == 3'b001)? w_in[w_width*17-1:w_width*16] : (flag == 3'b010)? w_in[w_width*18-1:w_width*17] : (flag == 3'b011)? w_in[w_width*19-1:w_width*18] : w_in[w_width*20-1:w_width*19];
    assign w_in5 = (flag == 3'b000)? w_in[w_width*21-1:w_width*20] : (flag == 3'b001)? w_in[w_width*22-1:w_width*21] : (flag == 3'b010)? w_in[w_width*23-1:w_width*22] : (flag == 3'b011)? w_in[w_width*24-1:w_width*23] : w_in[w_width*25-1:w_width*24];*/
    
multadd u1 (
  .A(d_in1),                // input wire [31 : 0] A
  .B(w_in1),                // input wire [31 : 0] B
  .C(16'h0000),                // input wire [31 : 0] C
  .SUBTRACT(1'b0),  // input wire SUBTRACT
  .P(p1),                // output wire [64 : 0] P
  .PCOUT()        // output wire [47 : 0] PCOUT
);

multadd u2 (
  .A(d_in2),                // input wire [31 : 0] A
  .B(w_in2),                // input wire [31 : 0] B
  .C(16'h0000),                // input wire [31 : 0] C
  .SUBTRACT(1'b0),  // input wire SUBTRACT
  .P(p2),                // output wire [64 : 0] P
  .PCOUT()        // output wire [47 : 0] PCOUT
);

multadd u3 (
  .A(d_in3),                // input wire [31 : 0] A
  .B(w_in3),                // input wire [31 : 0] B
  .C(16'h0000),                // input wire [31 : 0] C
  .SUBTRACT(1'b0),  // input wire SUBTRACT
  .P(p3),                // output wire [64 : 0] P
  .PCOUT()        // output wire [47 : 0] PCOUT
);

multadd u4 (
  .A(d_in4),                // input wire [31 : 0] A
  .B(w_in4),                // input wire [31 : 0] B
  .C(16'h0000),                // input wire [31 : 0] C
  .SUBTRACT(1'b0),  // input wire SUBTRACT
  .P(p4),                // output wire [64 : 0] P
  .PCOUT()        // output wire [47 : 0] PCOUT
);

multadd u5 (
  .A(d_in5),                // input wire [31 : 0] A
  .B(w_in5),                // input wire [31 : 0] B
  .C(16'h0000),                // input wire [31 : 0] C
  .SUBTRACT(1'b0),  // input wire SUBTRACT
  .P(p5),                // output wire [64 : 0] P
  .PCOUT()        // output wire [47 : 0] PCOUT
);

    always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n) P <= 0;
        else P <= P1 + P2 + P3 + P4 + P5;
    end
	
	always@(posedge clk or negedge rst_n)
	begin
	    if(!rst_n) begin P1 <= 0; P2 <= 0; P3 <= 0; P4 <= 0; P5 <= 0; end
	    else if((flag == 3'b000) && in_valid) P1 <= {{5{p1[w_width+data_width-2]}},p1} + {{5{p2[w_width+data_width-2]}},p2} + {{5{p3[w_width+data_width-2]}},p3} + {{5{p4[w_width+data_width-2]}},p4} + {{5{p5[w_width+data_width-2]}},p5};
        else if((flag == 3'b001) && in_valid) P2 <= {{5{p1[w_width+data_width-2]}},p1} + {{5{p2[w_width+data_width-2]}},p2} + {{5{p3[w_width+data_width-2]}},p3} + {{5{p4[w_width+data_width-2]}},p4} + {{5{p5[w_width+data_width-2]}},p5};
        else if((flag == 3'b010) && in_valid) P3 <= {{5{p1[w_width+data_width-2]}},p1} + {{5{p2[w_width+data_width-2]}},p2} + {{5{p3[w_width+data_width-2]}},p3} + {{5{p4[w_width+data_width-2]}},p4} + {{5{p5[w_width+data_width-2]}},p5};
        else if((flag == 3'b011) && in_valid) P4 <= {{5{p1[w_width+data_width-2]}},p1} + {{5{p2[w_width+data_width-2]}},p2} + {{5{p3[w_width+data_width-2]}},p3} + {{5{p4[w_width+data_width-2]}},p4} + {{5{p5[w_width+data_width-2]}},p5};
        else if((flag == 3'b100) && in_valid) P5 <= {{5{p1[w_width+data_width-2]}},p1} + {{5{p2[w_width+data_width-2]}},p2} + {{5{p3[w_width+data_width-2]}},p3} + {{5{p4[w_width+data_width-2]}},p4} + {{5{p5[w_width+data_width-2]}},p5};
        else begin P1 <= P1; P2 <= P2; P3 <= P3; P4 <= P4; P5 <= P5; end;
	end
	
	always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n) out_valid <= 0;
		else out_valid <= (in_valid_r && (flag_r == 3'b100));
	end
	
	always@(posedge clk)
	begin
	   	in_valid_r <= in_valid;
		flag_r <= flag;
	end
	
	wire [w_width+data_width+3:0] P_t;
	assign P_t = P >>> 8;
	
    assign d_out = P_t[w_width+data_width-5:0] + {{(data_width-4){b_in[w_width-1]}},b_in};
	
    //assign d_out = P + {{(data_width-4){b_in[w_width-1]}},b_in,{8{1'b0}}};
    
endmodule
