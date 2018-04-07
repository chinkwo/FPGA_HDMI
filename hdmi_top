`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 16:53:21
// Design Name: 
// Module Name: hdmi_top
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


module hdmi_top(
	input    wire     	sclk			,
	input    wire     	rst_n      		,
	                                     
	output   wire		r_ser_dat_p 	,
	output   wire		r_ser_dat_n 	,
	output   wire		g_ser_dat_p 	,
	output   wire		g_ser_dat_n 	,
	output   wire		b_ser_dat_p 	,
	output   wire		b_ser_dat_n 	,
	output	 wire 		pixel_start_flag,
	                                     
	output   wire		clk_ser_dat_p 	,
	output   wire		clk_ser_dat_n 	,
	                                     
	output   wire       hdmi_en          


    );

wire[23:0] rgb_data      	;
wire       pixel_de    		;
wire       pixel_clk   		;

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG

  pixel_clk_gen pixel_clk_gen_inst(
    // Clock out ports
    .pixel_clk(pixel_clk),     // output pixel_clk
   // Clock in ports
    .sclk(sclk)
    );      // input sclk
    
rgb_data_gen	rgb_data_gen_inst(
	.pixel_clk  (pixel_clk),//input    wire      pixel_clk    ,
	.rst_n      (rst_n    ),//input    wire      rst_n      	,
	.pixel_de   (pixel_de ),//input    wire      pixel_de     ,
	.rgb_data   (rgb_data )//output   reg[23:0] rgb_data    
    ); 
    
hdmi_ctrl	hdmi_ctrl_inst(
	.pixel_clk		(pixel_clk		),//input    wire     	pixel_clk		,
	.rst_n      	(rst_n      	),//input    wire     	rst_n      		, 
	.rgb_data      	(rgb_data      	),//input    wire       rgb_data      	,//from rgb_data_gen to vga_module rgb_data
    .pixel_start_flag(pixel_start_flag),                        	
	.pixel_de    	(pixel_de    	),//output	 wire       pixel_de    	,//to  rgb_data_gen                              	
	.r_ser_dat_p 	(r_ser_dat_p 	),//output   wire		r_ser_dat_p 	,
	.r_ser_dat_n 	(r_ser_dat_n 	),//output   wire		r_ser_dat_n 	,
	.g_ser_dat_p 	(g_ser_dat_p 	),//output   wire		g_ser_dat_p 	,
    .g_ser_dat_n 	(g_ser_dat_n 	),//output   wire		g_ser_dat_n 	,
    .b_ser_dat_p 	(b_ser_dat_p 	),//output   wire		b_ser_dat_p 	,
    .b_ser_dat_n 	(b_ser_dat_n 	),//output   wire		b_ser_dat_n 	,

    .clk_ser_dat_p 	(clk_ser_dat_p 	),//output   wire		clk_ser_dat_p 	,
    .clk_ser_dat_n 	(clk_ser_dat_n 	),//output   wire		clk_ser_dat_n 	,

    .hdmi_en        (hdmi_en        ) //output   wire       hdmi_en           
);      
    
    
    
    
endmodule
