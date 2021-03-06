`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Chinkwo Yue
// 
// Create Date: 2018/03/19 14:33:50
// Design Name: 
// Module Name: vga_module
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

 
module	vga_module(
		input	wire		sclk				,
		input	wire		rst_n				,
		input	wire		vga_clk				,
		input   wire[23:0]  	rgb_data			,
		output	reg		h_sync				,
		output	reg		v_sync				,
		output  wire        	pixel_de			,
		output  wire        	pixel_start_flag		,//屏幕上一副图片的开始，即打到屏幕上的第一个像素点
		output	wire[7:0]	r				,
		output	wire[7:0]	g				,
		output	wire[7:0]	b       			
);
//-----------------------------------------------------------//
// 水平扫描参数的设定1024*768 60Hz VGA
//-----------------------------------------------------------//
parameter LinePeriod =1344;            //行周期数
parameter H_SyncPulse=136;             //行同步脉冲（Sync a）
parameter H_BackPorch=160;             //显示后沿（Back porch b）
parameter H_ActivePix=1024;            //显示时序段（Display interval c）
parameter H_FrontPorch=24;             //显示前沿（Front porch d）
parameter Hde_start=296;
parameter Hde_end=1320;

//-----------------------------------------------------------//
// 垂直扫描参数的设定1024*768 60Hz VGA
//-----------------------------------------------------------//
parameter FramePeriod =806;           //列周期数
parameter V_SyncPulse=6;              //列同步脉冲（Sync o）
parameter V_BackPorch=29;             //显示后沿（Back porch p）
parameter V_ActivePix=768;            //显示时序段（Display interval q）
parameter V_FrontPorch=3;             //显示前沿（Front porch r）
parameter Vde_start=35;
parameter Vde_end=803;

//-----------------------------------------------------------//
// 水平扫描参数的设定800*600 VGA
//-----------------------------------------------------------//
//parameter LinePeriod =1056;           //行周期数
//parameter H_SyncPulse=128;            //行同步脉冲（Sync a）
//parameter H_BackPorch=88;             //显示后沿（Back porch b）
//parameter H_ActivePix=800;            //显示时序段（Display interval c）
//parameter H_FrontPorch=40;            //显示前沿（Front porch d）

//-----------------------------------------------------------//
// 垂直扫描参数的设定800*600 VGA
//-----------------------------------------------------------//
//parameter FramePeriod =628;           //列周期数
//parameter V_SyncPulse=4;              //列同步脉冲（Sync o）
//parameter V_BackPorch=23;             //显示后沿（Back porch p）
//parameter V_ActivePix=600;            //显示时序段（Display interval q）
//parameter V_FrontPorch=1;             //显示前沿（Front porch r）

//-----------------------------------------------------------//
// 水平扫描参数的设定640*480 60Hz VGA
//-----------------------------------------------------------//
//parameter LinePeriod =800;            //行周期数
//parameter H_SyncPulse=96;             //行同步脉冲（Sync a）
//parameter H_BackPorch=40;             //显示后沿（Back porch b）
//parameter H_ActivePix=640;            //显示时序段（Display interval c）
//parameter H_FrontPorch=8;             //显示前沿（Front porch d）
//parameter Hde_start=144;
//parameter Hde_end=784;

//-----------------------------------------------------------//
// 垂直扫描参数的设定640*480 60Hz VGA
//-----------------------------------------------------------//
//parameter FramePeriod =525;           //列周期数
//parameter V_SyncPulse=2;              //列同步脉冲（Sync o）
//parameter V_BackPorch=25;             //显示后沿（Back porch p）
//parameter V_ActivePix=480;            //显示时序段（Display interval q）
//parameter V_FrontPorch=2;             //显示前沿（Front porch r）
//parameter Vde_start=35;
//parameter Vde_end=515;


	reg[10:0]		h_cnt		;	//h_cnt==LinePeriod
	reg[10:0]		v_cnt		;	//v_cnt==FramePeriod
	reg			hsync_de	;	//行有效区域（Vde_start~Vde_end）
	reg			vsync_de	;	//场有效区域（Hde_start~Hde_end）

assign	pixel_start_flag	=(h_cnt==H_SyncPulse&&v_cnt==V_SyncPulse)?1'b1:1'b0;	
//H_cnt行计数器	
always@(posedge	vga_clk	or	negedge	rst_n)
		if(rst_n==0)
			h_cnt	<=	1'b0;
		else	if(h_cnt==LinePeriod-1)
			h_cnt	<=	1'b0;
		else
			h_cnt	<=	h_cnt	+	1'b1;
			
			
//V_cnt行计数器				
always@(posedge	vga_clk	or	negedge	rst_n)
		if(rst_n==0)
			v_cnt	<=	1'b0;
		else	if(v_cnt==(FramePeriod-1)&&h_cnt==(LinePeriod-1))
			v_cnt	<=	1'b0;
		else	if(h_cnt==LinePeriod-1)
			v_cnt	<=	v_cnt	+	1'b1;
			
//h_sync行同步信号
always@(posedge	vga_clk	or	negedge	rst_n)
		if(rst_n==0)
			h_sync	<=	1'b0;
		else	if(h_cnt==1)
			h_sync	<=	1'b0;
		else	if(h_cnt>=H_SyncPulse-1)
			h_sync	<=	1'b1;
			
//产生hsync_de信号
always@(posedge	vga_clk	or	negedge	rst_n)			
    	if(~rst_n) 
    		hsync_de <= 1'b0;
    	else if(h_cnt == Hde_start-1) 
       		hsync_de <= 1'b1;    
    	else if(h_cnt == Hde_end-1) 
       		hsync_de <= 1'b0;	
			
//v_sync行同步信号
always@(posedge	vga_clk	or	negedge	rst_n)
		if(rst_n==0)
			v_sync	<=	1'b1;
		else	if(v_cnt==0)
			v_sync	<=	1'b0;
		else	if(v_cnt==V_SyncPulse-1)
			v_sync	<=	1'b1;

//产生vsync_de信号
always@(posedge	vga_clk	or	negedge	rst_n)			
	    if(~rst_n) 
	    	vsync_de <= 1'b0;
        else if(v_cnt == Vde_start-1) 
       		vsync_de <= 1'b1;    
        else if(v_cnt == Vde_end-1) 
       		vsync_de <= 1'b0;	 
       		
assign	pixel_de	=	hsync_de&vsync_de;
assign  {r,g,b}	=	pixel_de?rgb_data:24'h0;

        			

		
endmodule
