# FPGA_CNN_RTL
本项目利用verilog在FPGA上实现一个CNN加速器  
项目所用CNN是用MINST数据集训练的卷积神经网络，参数导出在param5x5  
测试平台：Xilinx KV260  
使用方法：项目提供了AXIS接口，可以封装为带有AXIS接口的IP核。按照系统框图绘制block design，利用PYNQ即可快速验证IP  
其他：逻辑实现上舍弃了乘积的部分低bit，可能导致推理结果出现偏差  
