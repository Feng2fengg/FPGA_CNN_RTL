`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/02/03 13:48:29
// Design Name: 
// Module Name: cnn_top
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

module cnn_top(
    input clk,
    input rst_n,
    input [7:0] d_in,
    input in_valid,
    input rd_en,
    //output we_en,
    output [42:0] d_out,
    output out_valid,
    output out_last
    );
    
wire [16*25-1:0] weight1 [3:0];
wire [16*25-1:0] weight2 [15:0];
wire [15:0] bias1 [3:0];
wire [15:0] bias2 [3:0];

//conv1.weight
assign weight1[0] = 400'hF7E0EEBC2C624CB91626E1ACE97FD6522CA4380ACB14C887D093285F4A34BE65E7F8C143293E37C7F54FEEF6EBA718023E4F;
assign weight1[1] = 400'h9E78AB10D15CE066D63EC0DFBA86B42DDF14CE77578313661623F315EE2D3F2F3B342A4229DAFE0C27F91DC60F4317991C4B;
assign weight1[2] = 400'h1D4A0C0EF89DF0081331F8210A40E4A2FB1C273FDDB8F64811062B3C222C283729452E7D11FCDF513D842A890F2120CF1067;
assign weight1[3] = 400'h0130EE4EF4D3C3FAD636F4D9ED8BC484C5890FA2F5B6C96ECD0CC2A026FCD868C5E7E73CFB186B06B5E0E61CCFC601185E0D;

//conv1.bias
assign bias1[0] = 16'h9120;
assign bias1[1] = 16'h1E8E;
assign bias1[2] = 16'hFAC4;
assign bias1[3] = 16'h23FE;

//conv2.weight
assign weight2[0]  = 400'hE9B1ED13D8F000380D450A5DDC69DC60EBEFFF501124EE660053153E1E6CF806FB3C11FA1611FF8DE58AD6F2E2CFEA50ECBD;
assign weight2[1]  = 400'h116209AC09EA1094EDEDFD950AB020962E2829C6FF9514F51F973E4B0CFA0D52160910AF2528042C052108BFFB05FA10EE35;
assign weight2[2]  = 400'h1595024A11961ABD0E7A07412B0D3BD0148CCFCCDF9DF36501FE0921E62AC844B6AFFFBC2EE5360EF1E12A4E1A1410160678;
assign weight2[3]  = 400'hF619FB08EB52F49BEAF9F88DE9FDC696CE74C8390360DE3DC191CC95CADEF8410BA4F2D1ED79FACB0D810F0F13D60346FF44;
assign weight2[4]  = 400'hECD307C717A5F4820C69085332E237F51611F8AD25422B7B27CAE4C4E9C11A491372FE55E3FEFA16D8A1FD05E83AFEEC0563;
assign weight2[5]  = 400'h0EF7118B13440FA70F4C11CD1088F8ECEFDFEE11EAACFC09F0B9E40EE25CE526E2EADA0ACBF0E22EE990E830EAB60124F876;
assign weight2[6]  = 400'hF5A30D5702F2F773F2BBD702F2FF033CFDC9D6A5FA6F37E227CBC93EAB0E65A430AFF3AAC70DDA4F50FC049D0EE7FB61FF8E;
assign weight2[7]  = 400'h00BEEC05ED33EA320D42FD3BFC53100CFF1205F60E2F3A8A1CACF2F6F8813102322AF9FBF4B1FA560ADF0D0303DA0D660DEC;
assign weight2[8]  = 400'h12ADF518F99AFF60FAE225E7206B1DD9F91D1C3009AC34ED20060083155312B54CFE3A972055075E1B4B1F600500164FDCD3;
assign weight2[9]  = 400'h1A38007610EDFE0610530BAC157EF20EDF5FEC63F2BDF016CFA0E2AFF7110367C60DA89FD4891DDDDF9FCD56D407E46B1FD5;
assign weight2[10] = 400'hF9E5E589C5D6DB28D379FF4522C2F6A5F5F9B8EF1FF11C24EE87FD54D27F206009A2E33F2516135625FF27A83C33582234DF;
assign weight2[11] = 400'h02B60F3A21393337FC8AFEFD1D6733282F68089AFACA191C21F71F8B072808F21FC3E4EDED3BED85FBF4D7CABF5DD8FECEAD;
assign weight2[12] = 400'h0923EB9FEEEEF6F90D15FD0EE15FF01D03DEF30BE58CE82EDEDCF686E40BF5010206E498F1E5FFDB27AA0C8BEB93E436F9CD;
assign weight2[13] = 400'h1D6E031BF993F836066114D00A7700720F5826ED16DBF59805DE029E088A0C64EFFFEED6F9EEE8C6FEBAFB69EC88F5B6FE95;
assign weight2[14] = 400'hBC3FD752EF2BE088F494CA57C6E8F37213F533DBFE5CF6BE2E733FEBFC0D11A43A4D2AA102E317ADFC611733135D03780C6D;
assign weight2[15] = 400'h0CDD08CC0244EED90253F47AFB80FF480641FD4F0A701048173511AEF35C08E5035C108F108CFDC706AC091711CFE72CE50D;

//conv2.bias
assign bias2[0] = 16'h163B;
assign bias2[1] = 16'hDEDA;
assign bias2[2] = 16'h2E04;
assign bias2[3] = 16'hEAE0;

//仅列输出信号，以下为第一个卷积层与对应的激活函数
wire [8:0] LineBuffer1_d_out1, LineBuffer1_d_out2, LineBuffer1_d_out3, LineBuffer1_d_out4, LineBuffer1_d_out5;
wire LineBuffer1_out_valid;

LineBuffer #(28,9,28*28) LineBuffer1 
    (
    clk,
    rst_n,
    {1'b0,d_in},
    in_valid,
    LineBuffer1_d_out1,
    LineBuffer1_d_out2,
    LineBuffer1_d_out3,
    LineBuffer1_d_out4,
    LineBuffer1_d_out5,
    LineBuffer1_out_valid
    );
    
wire [20:0] conv1_d_out [3:0];
wire conv1_out_valid [3:0];
wire [20:0] ReLU1_d_out[3:0];
wire ReLU1_out_valid [3:0];

genvar i;
generate
    for(i=0; i<4; i=i+1)
    begin:conv1
    conv_kernel #(9,16,28) conv1
        (
        clk,
        rst_n,
        LineBuffer1_d_out1,
        LineBuffer1_d_out2,
        LineBuffer1_d_out3,
        LineBuffer1_d_out4,
        LineBuffer1_d_out5,
        LineBuffer1_out_valid,
        weight1[i],
        bias1[i],
        conv1_d_out[i],
        conv1_out_valid[i]
        );
    ReLU #(21) ReLU1
        (
        clk,
        rst_n,
        conv1_out_valid[i],
        conv1_d_out[i],
        ReLU1_d_out[i],
        ReLU1_out_valid[i]
        );
    end
endgenerate

//第一个池化层
wire [20:0] LineBuffer_21_d_out1 [3:0], LineBuffer_21_d_out2 [3:0];
wire LineBuffer_21_out_valid [3:0];
wire [20:0] pool1_d_out [3:0];
wire pool1_out_valid [3:0];

genvar j;
generate
    for(j=0; j<4; j=j+1)
    begin:pool1
    LineBuffer_2 #(24,21,24*24) LineBuffer_21
        (
        clk,
        rst_n,
        ReLU1_d_out[j],
        ReLU1_out_valid[j],
        LineBuffer_21_d_out1[j],
        LineBuffer_21_d_out2[j],
        LineBuffer_21_out_valid[j]
        );
    pool_kernel #(21,16,12*24) pool1
        (
        clk,
        rst_n,
        LineBuffer_21_d_out1[j],
        LineBuffer_21_d_out2[j],
        LineBuffer_21_out_valid[j],
        pool1_d_out[j],
        pool1_out_valid[j]
        );
    end
endgenerate

//第二个卷积层
wire [20:0] LineBuffer2_d_out1 [3:0], LineBuffer2_d_out2 [3:0], LineBuffer2_d_out3 [3:0], LineBuffer2_d_out4 [3:0], LineBuffer2_d_out5 [3:0];
wire LineBuffer2_out_valid[3:0];
//第一次池化后数据放入存储器
reg [7:0] pool1_out_addr;
reg [1:0] num_conv2_kernel;//写入时为0，读取时为1，每次执行第二个卷积层需要在写入后再读取三次
wire [104:0] LineBuffer2_d_out [3:0];
wire [104:0] pool1_out_ram_dout [3:0];

//控制存储器的地址
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n) pool1_out_addr <= 0;
    else if(num_conv2_kernel == 0 && LineBuffer2_out_valid[0] && pool1_out_addr == 8*12-1) pool1_out_addr <= 0;
    else if(num_conv2_kernel == 0 && LineBuffer2_out_valid[0]) pool1_out_addr <= pool1_out_addr + 1;
    else if(num_conv2_kernel != 0 && pool1_out_addr == 8*12-1) pool1_out_addr <= 0;
    else if(num_conv2_kernel != 0) pool1_out_addr <= pool1_out_addr + 1;
    else pool1_out_addr <= pool1_out_addr;
end

//控制num_conv2_kernel
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n) num_conv2_kernel <= 0;
    else if(LineBuffer2_out_valid[0] && pool1_out_addr == 8*12-1) num_conv2_kernel <=  1;
    else if(num_conv2_kernel != 0 && pool1_out_addr == 8*12-1) num_conv2_kernel <= num_conv2_kernel + 1;
    else num_conv2_kernel <= num_conv2_kernel;
end

genvar k;
generate
    for(k=0; k<4; k=k+1)
    begin:LineBuffer2_poolram 
    LineBuffer #(12,21,12*12) LineBuffer2
        (
        clk,
        rst_n,
        pool1_d_out[k],
        pool1_out_valid[k],
        LineBuffer2_d_out1[k],
        LineBuffer2_d_out2[k],
        LineBuffer2_d_out3[k],
        LineBuffer2_d_out4[k],
        LineBuffer2_d_out5[k],
        LineBuffer2_out_valid[k]
        );
    pool1_out_ram pool1_out_ram1 (
      .clka(clk),    // input wire clka
      .wea(LineBuffer2_out_valid[k]),      // input wire [0 : 0] wea
      .addra(pool1_out_addr),  //input wire [6 : 0] addra
      .dina({LineBuffer2_d_out1[k],
        LineBuffer2_d_out2[k],
        LineBuffer2_d_out3[k],
        LineBuffer2_d_out4[k],
        LineBuffer2_d_out5[k]}),    // input wire [104 : 0] dina
      .douta(pool1_out_ram_dout[k])  // output wire [104 : 0] douta
    );
    assign LineBuffer2_d_out[k] = (num_conv2_kernel == 0) ?
   {LineBuffer2_d_out1[k],
    LineBuffer2_d_out2[k],
    LineBuffer2_d_out3[k],
    LineBuffer2_d_out4[k],
    LineBuffer2_d_out5[k]} :
    pool1_out_ram_dout[k];
    end
endgenerate

wire [42:0] conv2_d_out;
wire conv2_out_valid;
wire [42:0] ReLU2_d_out;
wire ReLU2_out_valid;
wire conv2_in_valid;
reg conv2_in_valid_r;

//控制卷积核输入数据是否有效，具体配置需要看仿真
always@(posedge clk or negedge rst_n)
begin
    if(!rst_n) conv2_in_valid_r <= 0;
    else if(num_conv2_kernel == 0) conv2_in_valid_r <= 0;
    else if(num_conv2_kernel != 0) conv2_in_valid_r <= 1;
    else conv2_in_valid_r <= conv2_in_valid_r;
end

assign conv2_in_valid = conv2_in_valid_r || LineBuffer2_out_valid[0];

conv_kernel4x5x5 #(21,16,12) conv2
    (
    clk,
    rst_n,
	LineBuffer2_d_out[0][104:84],
    LineBuffer2_d_out[0][83:63] ,
    LineBuffer2_d_out[0][62:42] ,
    LineBuffer2_d_out[0][41:21] ,
    LineBuffer2_d_out[0][20:0]  ,
    conv2_in_valid,
	LineBuffer2_d_out[1][104:84],
    LineBuffer2_d_out[1][83:63] ,
    LineBuffer2_d_out[1][62:42] ,
    LineBuffer2_d_out[1][41:21] ,
    LineBuffer2_d_out[1][20:0]  ,
    conv2_in_valid,
	LineBuffer2_d_out[2][104:84],
    LineBuffer2_d_out[2][83:63] ,
    LineBuffer2_d_out[2][62:42] ,
    LineBuffer2_d_out[2][41:21] ,
    LineBuffer2_d_out[2][20:0]  ,
    conv2_in_valid,
	LineBuffer2_d_out[3][104:84],
    LineBuffer2_d_out[3][83:63] ,
    LineBuffer2_d_out[3][62:42] ,
    LineBuffer2_d_out[3][41:21] ,
    LineBuffer2_d_out[3][20:0]  ,
    conv2_in_valid,
    weight2[num_conv2_kernel*4+0],
	weight2[num_conv2_kernel*4+1],
	weight2[num_conv2_kernel*4+2],
	weight2[num_conv2_kernel*4+3],
    bias2[num_conv2_kernel],
    conv2_d_out,
    conv2_out_valid
    );
ReLU #(43) ReLU2
    (
    clk,
    rst_n,
    conv2_out_valid,
    conv2_d_out,
    ReLU2_d_out,
    ReLU2_out_valid
    );


//第二个池化层
wire [42:0] LineBuffer_22_d_out1, LineBuffer_22_d_out2;
wire LineBuffer_22_out_valid;
wire [42:0] pool2_d_out;
wire pool2_out_valid;

LineBuffer_2 #(8,43,8*8) LineBuffer_22
    (
    clk,
    rst_n,
    ReLU2_d_out,
    ReLU2_out_valid,
    LineBuffer_22_d_out1,
    LineBuffer_22_d_out2,
    LineBuffer_22_out_valid
    );
pool_kernel #(43,16,4*8) pool2
    (
    clk,
    rst_n,
    LineBuffer_22_d_out1,
    LineBuffer_22_d_out2,
    LineBuffer_22_out_valid,
    pool2_d_out,
    pool2_out_valid
    );

fifo_pool2_out u0 (
  .clk(clk),                  // input wire clk
  .srst(!rst_n),                // input wire srst
  .din(pool2_d_out[42:11]),                  // input wire [31 : 0] din
  .wr_en(pool2_out_valid),              // input wire wr_en
  .rd_en(rd_en),              // input wire rd_en
  .dout(d_out),                // output wire [31 : 0] dout
  .full(full),                // output wire full
  .empty(empty),              // output wire empty
  .wr_rst_busy(wr_rst_busy),  // output wire wr_rst_busy
  .rd_rst_busy(rd_rst_busy)  // output wire rd_rst_busy
);

//reg we_en_r;
reg rd_en_r;
reg empty_r;
reg last;
//reg [15:0] num_in;
reg [15:0] num_out;

always@(posedge clk or negedge rst_n)
begin
    if(!rst_n) begin rd_en_r <= 0; empty_r <= 0; end
    else begin
    rd_en_r <= rd_en;
    empty_r <= empty;
    end
end

always@(posedge clk or negedge rst_n)
begin
    if(!rst_n) begin num_out <= 0; last = 0; end
    else if(rd_en && !empty && (num_out == 4*4*4-1)) begin num_out <= 0; last = 1; end
    else if(rd_en && !empty) begin num_out <= num_out + 1; last = 0; end
    else begin num_out <= num_out; last = 0; end
end

/*always@(posedge clk or negedge rst_n)
begin
    if(!rst_n) begin num_in <= 0; we_en_r <= 1; end
    else if(we_en_r && (num_in == 28*28)) begin num_in <= 0; we_en_r <= 0; end
    else if(we_en_r && (num_in < 28*28)) begin num_in <= num_in + 1; we_en_r <= 1; end
    else if(!we_en_r && last) begin num_in <= 0; we_en_r <= 1; end
    else begin num_in <= num_in; we_en_r <= we_en_r; end
end*/

assign out_valid = rd_en_r && !empty_r;
assign out_last = last;
//assign we_en = we_en_r;

endmodule