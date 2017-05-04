//-------------------------------------------------------------------------
//      lab7_usb.sv                                                      --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Fall 2014 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 7                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab8( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,       //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             //input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK,      //SDRAM Clock
	    
	     inout wire [15:0] SRAM_DQ, //SRAM Data 16 Bits
	     output [17:0] SRAM_ADDR, //SRAM Address 18 Bits
  	     output SRAM_UB_N, //SRAM High Byte Data Mask
             output SRAM_LB_N, //SRAM Low Byte Data Mask
  	     output SRAM_WE_N, //SRAM Write Enable
  	     output SRAM_CE_N, //SRAM Chip Enable
  	     output SRAM_OE_N  //SRAM Output Enable
                    );
    
        logic Reset_h, Clk, game_start;
        logic [15:0] keycode;
    
        assign Clk = CLOCK_50;
        assign {Reset_h} = ~(KEY[0]);  // The push buttons are active low
	//assign {Reset_ball} = ~(KEY[2]);
	assign game_start = ~KEY[3];
	
	logic [1:0] hpi_addr;
	logic [15:0] hpi_data_in, hpi_data_out;
	logic hpi_r, hpi_w,hpi_cs;
	 
	logic [9:0] DrawX, DrawY;
	logic [2:0] blkreg_sel;
	logic [3:0] pixel;
	logic [2:0] shape_o, shape, color_w;
	logic [1:0] orientation_i, orientation_o, rotatein_sel, rotateo_o;
	logic [4:0] x0, x1, x2, x3, x0_o, x1_o, x2_o, x3_o, curr_x, 
		    x0mux_o, x1mux_o, x2mux_o, x3mux_o, rotatex_o, rotatexmux_o,
		    leftx0_o, leftx1_o, leftx2_o, leftx3_o, rightx0_o, rightx1_o, rightx2_o, rightx3_o,
		    rotatex0_o, rotatex1_o, rotatex2_o, rotatex3_o, downx0_o, downx1_o, downx2_o, downx3_o;
	logic [5:0] y0, y1, y2, y3, y0_o, y1_o, y2_o, y3_o, curr_y,
	            y0mux_o, y1mux_o, y2mux_o, y3mux_o, rotatey_o, rotateymux_o,
		    lefty0_o, lefty1_o, lefty2_o, lefty3_o, righty0_o, righty1_o, righty2_o, righty3_o,
		    rotatey0_o, rotatey1_o, rotatey2_o, rotatey3_o, downy0_o, downy1_o, downy2_o, downy3_o;
	logic r_color, r_generate, r_write, r_initialize, blkreg_ld, r_rotate, blk_sel, r_down, r_left, r_right;
	
	//SRAM Interfaces
	logic sram_we; //1 when writing to sram
	logic sram_re; //1 when reading from sram
	logic [15:0] color_in; //color read from sram
	logic [15:0] color_out; //so far not used(?)
	
	assign SRAM_DQ = sram_we? 16'hzzzz :{12'd0 ,color_w}; //SRAM Data 16 Bits
	assign SRAM_ADDR = sram_we?{curr_x, curr_y, 7'd0}: (sram_re?{curr_x, curr_y, 7'd0}:{((DrawX-240)/8),((DrawY-80)/8),7'd0}); //SRAM Address 18 Bits
  	assign SRAM_UB_N = 0; //SRAM High Byte Data Mask
        assign SRAM_LB_N = 0; //SRAM Low Byte Data Mask
  	assign SRAM_WE_N = sram_we? 1'b0 : 1'b1; //SRAM Write Enable
  	assign SRAM_CE_N = 0; //SRAM Chip Enable
  	assign SRAM_OE_N = 0; //SRAM Output Enable
	assign color_in = sram_re ? SRAM_DQ : 16'h0000;
	
	//control variables
	assign blkreg_ld = r_initialize | r_down | r_left | r_right | r_rotate;
	
    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),    
                            .OTG_RST_N(OTG_RST_N)//,   
                            //.OTG_INT(OTG_INT)
    );
     
     //The connections for nios_system might be named different depending on how you set up Qsys
     nios_system nios_system(
                             .clk_clk(Clk),         
                             .reset_reset_n(KEY[0]),   
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_clk_clk(DRAM_CLK),
                             .keycode_export(keycode),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w)
    );
    
    //Fill in the connections for the rest of the modules 
    VGA_controller vga_controller_instance(
	    			.Clk,         // 50 MHz clock
                                           .Reset(Reset_h),       // reset signal
                                           .VGA_HS,      // Horizontal sync pulse.  Active low
                                           .VGA_VS,      // Vertical sync pulse.  Active low
                                           .VGA_CLK,     // 25 MHz VGA clock output
                                           .VGA_BLANK_N, // Blanking interval indicator.  Active low.
                                           .VGA_SYNC_N,  // Composite Sync signal.  Active low.  We don't use it in this lab,
                                                        // but the video DAC on the DE2 board requires an input for it.
                                           .DrawX,       // horizontal coordinate
                                           .DrawY        // vertical coordinate
														 );
													
   
    /*ball ball_instance(.Reset(Reset_ball), 
                       .frame_clk(VGA_VS),          
							  .keycode(keycode[7:0]),	  
							  .BallX, 
							  .BallY, 
							  .BallS
							 );*/
    
color_mapper color_instance(.pixel,       // Ball coordinates
									
                    		.VGA_R, 
							.VGA_G, 
							.VGA_B // VGA RGB output
);
										 
tetris_control control
( 
	.clk(Clk),
	.reset(Reset_h),
	.reached_top(),
	.reached_right(),
	.start_game(game_start),
	.rotatex0_o,
	.rotatex1_o,
	.rotatex2_o,
	.rotatex3_o,
	.x0_o,
	.x1_o,
	.x2_o,
	.x3_o,
	.rotatey0_o,
	.rotatey1_o,
	.rotatey2_o,
	.rotatey3_o,
	.y0_o,
	.y1_o,
	.y2_o,
	.y3_o,
	.shape(shape_o),
	.keycode(keycode[7:0]),
	.sram_color(color_in[2:0]),
	
	.r_rotate,
	.r_down,
	.r_left,
	.r_right,
	.r_generate,
	.r_initialize,
	.sram_we,
	.sram_re,
	.rotatein_sel,
	.blkreg_sel,
	.color_w,
	.curr_x,
	.curr_y
	
);

//generates a random block
generation generate0(
	.reset(game_start),
	.data_in(shape_o),
	.data_out(shape)			   
);	

//initializes the block generated
initialize initialize0(
	.shape(shape_o),
    .orientation(orientation_i),
    .x0, .x1, .x2, .x3,
    .y0, .y1, .y2, .y3
);
 
mux8 #(.width(5)) x0_mux
(
	.S(blk_sel),
	.In0(x0),
	.In1(downx0_o),
	.In2(leftx0_o),
	.In3(rightx0_o),
	.In4(rotatex0_o),
	.In5(),
	.In6(),
	.In7(),
	.Out(x0mux_o)
);

mux8 #(.width(5)) x1_mux
(
	.S(blk_sel),
	.In0(x1),
	.In1(downx1_o),
	.In2(leftx1_o),
	.In3(rightx1_o),
	.In4(rotatex1_o),
	.In5(),
	.In6(),
	.In7(),
	.Out(x1mux_o)
);
	
mux8 #(.width(5)) x2_mux
(
	.S(blk_sel),
	.In0(x2),
	.In1(downx2_o),
	.In2(leftx2_o),
	.In3(rightx2_o),
	.In4(rotatex2_o),
	.In5(),
	.In6(),
	.In7(),
	.Out(x2mux_o)
);

mux8 #(.width(5)) x3_mux
(
	.S(blk_sel),
	.In0(x3),
	.In1(downx3_o),
	.In2(leftx3_o),
	.In3(rightx3_o),
	.In4(rotatex3_o),
	.In5(),
	.In6(),
	.In7(),
	.Out(x3mux_o)
);
	
mux8 #(.width(6)) y0_mux
(
	.S(blk_sel),
	.In0(y0),
	.In1(downy0_o),
	.In2(lefty0_o),
	.In3(righty0_o),
	.In4(rotatey0_o),
	.In5(),
	.In6(),
	.In7(),
	.Out(y0mux_o)
);
	
mux8 #(.width(6)) y1_mux
(
	.S(blk_sel),
	.In0(y1),
	.In1(downy1_o),
	.In2(lefty1_o),
	.In3(righty1_o),
	.In4(rotatey1_o),
	.In5(),
	.In6(),
	.In7(),
	.Out(y1mux_o)
);
	
mux8 #(.width(6)) y2_mux
(
	.S(blk_sel),
	.In0(y2),
	.In1(downy2_o),
	.In2(lefty2_o),
	.In3(righty2_o),
	.In4(rotatey2_o),
	.In5(),
	.In6(),
	.In7(),
	.Out(y2mux_o)
);
	
mux8 #(.width(6)) y3_mux
(
	.S(blk_sel),
	.In0(y3),
	.In1(downy3_o),
	.In2(lefty3_o),
	.In3(righty3_o),
	.In4(rotatey3_o),
	.In5(),
	.In6(),
	.In7(),
	.Out(y3mux_o)
);
	
register #(.width(5)) x0_reg
(
        .clk(Clk),
	.load(blkreg_ld),
	.reset(Reset_h),
	.in(x0mux_o),
	.out(x0_o)
);
	 
register #(.width(5)) x1_reg
(
        .clk(Clk),
	.load(blkreg_ld),
	.reset(Reset_h),
	.in(x1mux_o),
	.out(x1_o)
);

register #(.width(5)) x2_reg
(
        .clk(Clk),
	.load(blkreg_ld),
	.reset(Reset_h),
	.in(x2mux_o),
	.out(x2_o)
);

register #(.width(5)) x3_reg
(
        .clk(Clk),
	.load(blkreg_ld),
	.reset(Reset_h),
	.in(x3mux_o),
	.out(x3_o)
);
	 
register #(.width(6)) y0_reg
(
        .clk(Clk),
	.load(blkreg_ld),
	.reset(Reset_h),
	.in(y0mux_o),
	.out(y0_o)
);

register #(.width(6)) y1_reg
(
        .clk(Clk),
	.load(blkreg_ld),
	.reset(Reset_h),
	.in(y1mux_o),
	.out(y1_o)
);

register #(.width(6)) y2_reg
(
        .clk(Clk),
	.load(blkreg_ld),
	.reset(Reset_h),
	.in(y2mux_o),
	.out(y2_o)
);

register #(.width(6)) y3_reg
(
        .clk(Clk),
	.load(blkreg_ld),
	.reset(Reset_h),
	.in(y3mux_o),
	.out(y3_o)
);

register #(.width(3)) shape_reg
(
    .clk(Clk),
	.load(r_init | game_start),
	.reset(Reset_h),
	.in(shape),
	.out(shape_o)
);

register #(.width(2)) orientation_reg
(
        .clk(Clk),
	.load(r_generate | r_rotate),
	.reset(Reset_h),
	.in(orientation_i),
	.out(orientation_o)
);

mux4 #(.width(5))rotatexmux 
(	
	.S(rotatein_sel),
	.In0(x0_o), 
	.In1(x1_o), 
	.In2(x2_o), 
	.In3(x3_o),
	.Out(rotatexmux_o)
);

mux4 #(.width(6))rotateymux 
(	
	.S(rotatein_sel),
	.In0(y0_o), 
	.In1(y1_o), 
	.In2(y2_o), 
	.In3(y3_o),
	.Out(rotateymux_o)
);

down down0(.reset(Reset_ball), 
	   .x(x0), 
	   .y(y0), 
	   .x_out(downx0_o), 
	   .y_out(downy0_o)
						
);

down down1(.reset(Reset_ball), 
	   .x(x1), 
	   .y(y1), 
	   .x_out(downx1_o), 
	   .y_out(downy1_o)
						
);

down down2(.reset(Reset_ball), 
	   .x(x2), 
	   .y(y2), 
	   .x_out(downx2_o), 
	   .y_out(downy2_o)
						
);

down down3(.reset(Reset_ball), 
	   .x(x3), 
	   .y(y3), 
	   .x_out(downx3_o), 
	   .y_out(downy3_o)
						
);
							    
left left0(.reset(Reset_ball), 
	   .x(x0_o), 
	   .y(y0_o), 
	   .x_out(leftx0_o), 
	   .y_out(lefty0_o)
						
);
	
left left1(.reset(Reset_ball), 
	   .x(x1_o), 
	   .y(y1_o), 
	   .x_out(leftx1_o), 
	   .y_out(lefty1_o)
						
);

left left2(.reset(Reset_ball), 
	   .x(x2_o), 
	   .y(y2_o), 
	   .x_out(leftx2_o), 
	   .y_out(lefty2_o)
						
);

left left3(.reset(Reset_ball), 
	   .x(x3_o), 
	   .y(y3_o), 
	   .x_out(leftx3_o), 
	   .y_out(lefty3_o)
						
);
							    
right right0(.reset(Reset_ball), 
	     .x(x0_o), 
	     .y(y0_o), 
	     .x_out(rightx0_o), 
	     .y_out(righty0_o)
						
);

right right1(.reset(Reset_ball), 
	     .x(x1_o), 
	     .y(y1_o), 
	     .x_out(rightx1_o), 
	     .y_out(righty1_o)
						
);

right right2(.reset(Reset_ball), 
	     .x(x2_o), 
	     .y(y2_o), 
	     .x_out(rightx2_o), 
	     .y_out(righty2_o)
						
);

right right3(.reset(Reset_ball), 
	     .x(x3_o), 
	     .y(y3_o), 
	     .x_out(rightx3_o), 
	     .y_out(righty3_o)
						
);
	
rotate rotate0
(
	.reset(Reset_ball), //run,
	.x(x0_o), 
	.y(y0_o), 
	.square_no(2'b00), 
	.orientation_in(orientation_o), 
	.shape(shape_o),
	.x_out(rotatex0_o), 
	.y_out(rotatey0_o),
	.orientation_out(rotateo_o)						
);
	
rotate rotate1
(
	.reset(Reset_ball), //run,
	.x(x1_o), 
	.y(y1_o), 
	.square_no(2'b01), 
	.orientation_in(orientation_o), 
	.shape(shape_o),
	.x_out(rotatex1_o), 
	.y_out(rotatey1_o),
	.orientation_out()	//dont fill					
);

rotate rotate2
(
	.reset(Reset_h), //run,
	.x(x2_o), 
	.y(y2_o), 
	.square_no(2'b10), 
	.orientation_in(orientation_o), 
	.shape(shape_o),
	.x_out(rotatex2_o), 
	.y_out(rotatey2_o),
	.orientation_out() //dont fill						
);

rotate rotate3
(
	.reset(Reset_h), //run,
	.x(x3_o), 
	.y(y3_o), 
	.square_no(2'b11), 
	.orientation_in(orientation_o), 
	.shape(shape_o),
	.x_out(rotatex3_o), 
	.y_out(rotatey3_o),
	.orientation_out() 						
);

    HexDriver hex_inst_0 (keycode[3:0], HEX0);
    HexDriver hex_inst_1 (keycode[7:4], HEX1);
	
always @(*)
	begin
		if(DrawX >= 240 & DrawX <= 400 & DrawY >= 80 & DrawY <= 400)
			begin
				pixel <= {1'b0, SRAM_DQ[2:0]};
			end
		else
			begin
				pixel <= 4'd8;
			end
    end
endmodule: lab8
