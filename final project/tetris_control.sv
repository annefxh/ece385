
module tetris_control ( input logic clk,
				    reset,
				    //canmove,
				    reached_top,
				    reached_right,
		       		    start_game,
		       input logic [4:0] rotatex0_o,
		       			rotatex1_o,
		       			rotatex2_o,
		       			rotatex3_o,
					  x0_o,
					  x1_o,
					  x2_o,
					  x3_o,
		       input logic [5:0] rotatey0_o,
		       			rotatey1_o,
		       			rotatey2_o,
		       			rotatey3_o,
					  y0_o,
					  y1_o,
					  y2_o,
					  y3_o,
		       	input [2:0] shape,
		        input [7:0] keycode,
		       	input [3:0] sram_color,
		       
		        output logic r_rotate,
							  r_down,
		       		     r_left,
		       		     r_right,
		       		     //r_color,
		       		     //r_wsram,
		       		     //r_checkcanmove,
		       		     //r_decolor,
		       		     //game_start,
		       		     r_generate,
		       		     r_initialize,
		       		     sram_we,
		       		     sram_re,
		       output logic [1:0] rotatein_sel, // used to select which input for check rotate in this module
		       output logic [2:0] blkreg_sel, //decides which value to be loaded in to x,y block registers
		       output logic [2:0] color_w, //color to write to sram
		       output logic [4:0] curr_x, //x-coordinate for sram ADDR
		       output logic [5:0] curr_y //y-coordinate for sram ADDR
);

	logic[4:0] check_x_in;
	logic[5:0] check_y_in;
	logic init_d_in; //init done
	logic decolor_in; //remove shape
	logic decolor_d_in; //removal done
	logic canmove_in;
	logic [4:0] init_x_in;
	logic [5:0] init_y_in;
	logic [2:0] blk_in; //square count
	logic [2:0] color_ctrl_in;
	logic [1:0] checkmove_in; //0:down, 1:left, 2:right, 3:rorate
	logic [5:0] y_gone_in;
	logic [4:0] shift_x;
	logic [5:0] shift_y;
	logic [2:0] shift_color;
	
	logic[4:0] check_x;
	logic[5:0] check_y;
	logic init_d; //init done
	logic decolor; //request to remove shape
	logic decolor_d; //removal done
	logic canmove;
	logic [4:0] init_x;
	logic [5:0] init_y;
	logic [2:0] blk; //square count
	logic [2:0] color_ctrl;
	logic [1:0] checkmove; //0:down, 1:left, 2:right, 3:rorate
	logic [5:0] y_gone;
	logic [4:0] shift_x_in;
	logic [5:0] shift_y_in;
	logic [2:0] shift_color_in;
	
/*initial begin
	init_d=0; //init done
	decolor=0; //remove shape
	decolor_d=0; //removal done
	canmove=0;
	r_decolor=0;
	init_x=5'd0;
	init_y=6'd0;
	blk=3'd0; //square count
	color_ctrl=3'd0;
	checkmove=2'd0; 
end*/
	
enum int unsigned {
	s_reset,
	s_init,
	s_generate,
	s_initialize,
	s_color,
	s_wsram,
	s_wait,
	s_checkcanmove,
	s_checkcanmove_1,
	s_checkcanmove_2,
	s_wait_1,
	s_decolor_1,
	s_moveleft,
	s_moveright,
	s_movedown,
	s_rotate,
	s_checkrow,
	s_eliminaterow,
	s_shiftrows,
	s_decrementy,
	s_incrementx,
	s_readabove_1,
	s_readabove_2,
	s_write_to_current
} state, next_state;

always_comb
begin: state_actions
	
 	/* default output values */
	//r_rotate = 0;
	r_down = 0;
	r_left = 0;
	r_right = 0;
	rotatein_sel =0;
	r_rotate = 0;
	//r_color = 0;
	//r_wsram = 0;
	//r_wait = 0;
	//r_checkcanmove = 0;
	//r_decolor = 0;
	r_generate = 0;
	r_initialize = 0;
	sram_we = 0;
	sram_re = 0;
	curr_x = 5'd0;
	curr_y = 6'd0;
	color_w = 3'd7; //white
	blkreg_sel = 3'd0;
	
	init_d_in = init_d; //init done
	decolor_in = decolor; //remove shape
	decolor_d_in = decolor_d; //removal done
	canmove_in = canmove;
	init_x_in = init_x;
	init_y_in = init_y;
	blk_in = blk; //square count
	color_ctrl_in = color_ctrl;
	checkmove_in = checkmove; 
	check_x = check_x_in;
	check_y = check_y_in;
	y_gone = y_gone_in; 
	shift_x = shift_x_in;
	shift_y = shift_y_in;
	
	case(state)
		
		s_init:
			begin
			// init is done, game start button pressed
				if(init_y == 6'd41)
					begin
						init_x_in = 5'd0;
						init_y_in = 6'd0;
						blk_in = 3'd0;
						init_d_in = 1'b1;
						check_x_in = 5'd0;
						check_y_in = 6'd0;
					end
		    //game init in progress
				else
					begin
						sram_we = 1'b1;
						curr_x = init_x;
						curr_y = init_y;
						//finished a row: reset row counter, increment column counter
						if(init_x == 5'd20)
							begin
								init_x_in = 5'd0;
								init_y_in += 1'b1;
							end
						else
							begin
								init_x_in += 1'b1;
							end
					end
			end
		
		s_generate:
			r_generate=1;
		
		s_initialize:
			r_initialize=1;
				
		s_color: //;
		
		s_wsram:
			//drawing or removal done
			begin
			if(blk == 3'd4)
				begin
					blk_in = 3'd0;
					if(decolor)
						begin
							decolor_d_in = 1'b1;
						end
				end
			else
				begin
					sram_we = 1'b1;
					case(blk)
						3'd1: 
							begin
								curr_x = x1_o;
								curr_y = y1_o;
								if(decolor == 1'b0)
									color_w = shape;
									
							end
						3'd2:
							begin
								curr_x = x2_o;
								curr_y = y2_o;
								if(decolor == 1'b0)
									color_w = shape;
							end
						3'd3:
							begin
								curr_x = x3_o;
								curr_y = y3_o;
								if(decolor == 1'b0)
									color_w = shape;
							end
						default:
							begin
								curr_x = x0_o;
								curr_y = y0_o;
								if(decolor == 1'b0)
									color_w = shape;
							end	
					endcase
					blk_in += 1'b1;
				end
			end
		
		s_wait:
			begin
			case(keycode)
					8'h51:
						checkmove_in = 0;

					8'h50:
						checkmove_in = 1;

					8'h4F:
						checkmove_in = 2;

					8'h52:
						checkmove_in = 3;
				
					default: 
						checkmove_in = 0;
				endcase
			end
		
		s_checkcanmove_1:
			//r_checkcanmove=1;
			begin
				if(canmove)
					begin
						if(blk == 3'd4)
							blk_in = 3'd0;
						
						else
							begin
								sram_re = 1'b1;
								case(checkmove)
									2'd0://down
										begin
											case(blk)
												3'd1: 
													begin
														curr_x = x1_o;
														curr_y = y1_o+ 1'b1;
														check_x_in = x1_o;
														check_y_in = y1_o+ 1'b1;
													end
												3'd2:
													begin
														curr_x = x2_o;
														curr_y = y2_o+1'b1;
														check_x_in = x2_o;
														check_y_in = y2_o+1'b1;
													end
												3'd3:
													begin
														curr_x = x3_o;
														curr_y = y3_o+1'b1;
														check_x_in = x3_o;
														check_y_in = y3_o+1'b1;
													end
												default:
													begin
														curr_x = x0_o;
														curr_y = y0_o+1'b1;
														check_x_in = x0_o;
														check_y_in = y0_o+1'b1;
													end	
											endcase
										end	
									2'd1: //left
										begin
											case(blk)
												3'd1: 
													begin
														curr_x = x1_o-1'b1;
														curr_y = y1_o;
														check_x_in =  x1_o-1'b1;
														check_y_in = y1_o;
													end
												3'd2:
													begin
														curr_x = x2_o-1'b1;
														curr_y = y2_o;
														check_x_in = x2_o-1'b1;
														check_y_in = y2_o;
													end
												3'd3:
													begin
														curr_x = x3_o-1'b1;
														curr_y = y3_o;
														check_x_in = x3_o-1'b1;
														check_y_in = y3_o;
													end
												default:
													begin
														curr_x = x0_o-1'b1;
														curr_y = y0_o;
														check_x_in = x0_o-1'b1;
														check_y_in = y0_o;
													end	
											endcase
										end
									2'd2://right
										begin
											case(blk)
												3'd1: 
													begin
														curr_x = x1_o+1'b1;
														curr_y = y1_o;
														check_x_in = x1_o+1'b1;
														check_y_in = y1_o;
													end
												3'd2:
													begin
														curr_x = x2_o+1'b1;
														curr_y = y2_o;
														check_x_in = x2_o+1'b1;
														check_y_in =  y2_o;
													end
												3'd3:
													begin
														curr_x = x3_o+1'b1;
														curr_y = y3_o;
														check_x_in = x3_o+1'b1;
														check_y_in =  y3_o;
													end
												default:
													begin
														curr_x = x0_o+1'b1;
														curr_y = y0_o;
														check_x_in = x0_o+1'b1;
														check_y_in = y0_o;
													end	
											endcase
										end
									2'd3://rotate
										begin
											rotatein_sel = blk[1:0];
											case(blk)
												3'd0:
													begin
														curr_x = rotatex0_o;
														curr_y = rotatey0_o;
														check_x_in = rotatex0_o;
														check_y_in = rotatey0_o;
													end
												3'd1: 
													begin
														curr_x = rotatex1_o;
														curr_y = rotatey1_o;
														check_x_in = rotatex1_o;
														check_y_in = rotatey1_o;
													end
												3'd2:
													begin
														curr_x = rotatex2_o;
														curr_y = rotatey2_o;
														check_x_in = rotatex2_o;
														check_y_in = rotatey2_o;
													end
												3'd3:
													begin
														curr_x = rotatex3_o;
														curr_y = rotatey3_o;
														check_x_in = rotatex3_o;
														check_y_in = rotatey3_o;
													end
												default: /* do nothing */;
														
											endcase
										end
									
								endcase
							end
					end
				else
					begin
						if (checkmove == 1'b0) //can't move down anymore
							blk_in = 3'd0;
					end
			end
		
		s_checkcanmove_2:
			begin
			canmove_in = ((sram_color == 4'd7 || sram_color == {1'b0, shape}) //if color==white or itself
				      && check_x >= 5'd0 && check_x <= 5'd20 && check_y >= 6'd0 && check_x <= 6'd40);
			blk_in += 1'b1;
			 //if within boundary
			end
		
		s_decolor_1:
			if(decolor_d)
				decolor_in = 1'b0;
			else 
				decolor_in = 1'b1;
			
		s_moveleft:
			begin
			r_left=1; // load block registers in top level
			checkmove_in = 2'd0; //reset checkmove
			blkreg_sel = 3'd2; //chose the mux value to load the block registers with
			check_x_in = 5'd0; //reset variable for checking
			check_y_in = 6'd0;
			end
		
		s_moveright:
			begin
			r_right=1;
			checkmove_in = 2'd0;
			blkreg_sel = 3'd3;
			check_x_in = 5'd0; //reset variable for checking
			check_y_in = 6'd0;
			end
		
		s_movedown:
		begin
			r_down=1;
			checkmove_in = 2'd0;
			blkreg_sel = 3'd1;
			check_x_in = 5'd0; //reset variable for checking
			check_y_in = 6'd0;
		end
		
		s_rotate:
		begin
			r_rotate=1;
			checkmove_in = 2'd0;
			blkreg_sel = 3'd4;
			check_x_in = 5'd0; //reset variable for checking
			check_y_in = 6'd0;
		end
		
		s_checkrow: 
			begin
				if(blk == 3'd4)
					blk_in = 3'd0; // finished checking the four rows that will be affected
				else
					begin
						sram_re = 1'b1;
						if (init_x == 5'd20) // when we reach end end of the row
							begin
								init_x_in == 5'd0;
								if (sram_color == 4'd7) //white
									blk_in += 1;
								else
									init_x_in = 5'd0; // prepare to delete row
							end
						else
							begin
								if (sram_color == 4'd7) //white: the row is not filled
									begin
										init_x_in = 5'd0; 
										blk_in += 1;
									end
								else
									init_x_in += 1;
							end
					end
			end;
		
		s_eliminaterow: 
			begin
				if(init_x_in == 5'd20)
					begin
						shift_y_in = init_y;
						y_gone_in = init_y;
					end
				else
					begin
						sram_we = 1'b1;
						curr_x = init_x;
						curr_y = init_y;
						//write color is default white
					end
			end
		s_shiftrows: 
			begin
				if(shift_y == 6'd0)
					begin
						init_y_in = y_gone;
					end
			end;
		s_decrementy:
			begin
				shift_x_in = -5'd1;
				shift_y_in -= 1;
			end

		s_incrementx: 
			begin
				if(shift_x == 5'd20)
						shift_x_in = 5'd0;
				else
					shift_x_in += 1;
			end
		
		s_readabove_1: 
			begin
				sram_re = 1'b1;
				curr_x = shift_x;
				curr_y = shift_y -1;
			end
		
		s_readabove_2: 
			begin
				shift_color_in = sram_color;
			end
		
		s_write_to_current: 
			begin
				sram_we = 1'b1;
				curr_x = shift_x;
				curr_y = shift_y;
				color_w = shift_color;
			end
		
		s_lose: /*do nothing*/;
		
		default: /*do nothing*/;
	endcase
end
	
always_comb
begin:  next_state_logic
		next_state = state;

		case(state)
			s_reset:
				begin
					next_state = s_init;
				end
			
			s_init:
			begin
				if(init_y == 6'd41)
					next_state = s_generate;
			end

			s_generate:
			begin
				next_state = s_initialize;
			end
			
			s_initialize:
			begin
				next_state = s_color;
			end

			s_color:
			begin
				next_state = s_wsram;
			end

			s_wsram:
			begin
				if(decolor_d)
					next_state = s_decolor_1;
				else 
					next_state = s_wait_1;
			end
			
			s_wait:
			begin
				next_state = s_checkcanmove;
			end
			
			s_checkcanmove_1:
				begin
					if(canmove)
						if(blk == 3'd4)
							next_state = s_decolor_1;
						else
							next_state = s_checkcanmove_2;
					else
						begin
							if (checkmove == 1'b0)
								next_state = s_checkrow;
							else
								next_state = s_wait;
						end
				end

			s_checkcanmove_2:
			begin
				next_state = s_checkcanmove_1;
			end

			s_decolor_1:
			begin
				if(decolor_d == 1'b0)
					next_state = s_wsram;
				else
					begin
						case(checkmove)
							2'd0:
								next_state = s_movedown;
							2'd1:
								next_state = s_moveleft;
							2'd2:
								next_state = s_moveright;
							2'd3:
								next_state = s_rotate;
						endcase
					end
			end


			s_moveleft:
			begin
				next_state = s_color;
			end

			s_moveright:
			begin
				next_state = s_color;
			end

			s_movedown:
			begin
				next_state = s_color;
			end

			s_rotate:
			begin
				next_state = s_color;
			end

			s_checkrow:
			begin
				if(init_y == 6'd0)
					next_state = s_generate;
				else
					begin
					if(init_x == 5'd20)
						begin
						if(sram_color != 4'd7)
							next_state = s_eliminaterow;
						end
					end
			end

			s_eliminaterow:
			begin
				if (init_x == 5'd20)
					next_state = s_shiftrows;
				else
					next_state = s_eliminaterow;
			end

			s_shiftrows:
			begin
				if(shift_y == 6'd0)
					next_state = s_checkrow;
				else
					next_state = s_decrementy;
			end

			s_decrementy:
			begin
					next_state = s_incrementx;
			end

			s_incrementx:
			begin
				if(shift_x == 5'd20)
					next_state = s_readabove;
				else
					next_state = s_readabove;
			end

			s_readabove_1:
			begin
				next_state = s_readabove_2;
			end
			
			s_readabove_2:
			begin
				next_state = s_write_to_current;
			end

			s_write_to_current:
			begin
				next_state = s_incrementx;
			end
			
			default: ;

		endcase
end

/* Assignment of next state on clock edge */
always_ff @(posedge clk)
begin: next_state_assignment
	if(reset)
		begin
		state <= s_reset;
		init_d <=0; //init done
		decolor <=0; //remove shape
		decolor_d <=0; //removal done
		canmove <=0;
		init_x <=5'd0;
		init_y <=6'd0;
		blk <=3'd0; //square count
		color_ctrl <=3'd0;
		checkmove <=2'd0; 
		check_x <= 5'd0;
		check_y <= 6'd0;
		y_gone <= 6'd0;
		end
	else
		begin
		state <= next_state; 
		init_d <=init_d_in; //init done
		decolor <=decolor_in; //remove shape
		decolor_d <=decolor_d_in; //removal done
		canmove <=canmove_in;
		init_x <=init_x_in;
		init_y <=init_y_in;
		blk <=blk_in; //square count
		color_ctrl <=color_ctrl_in;
		checkmove <=checkmove_in; 
		check_x <= check_x_in;
		check_y <= check_y_in;
		y_gone <= y_gone_in
		end
end

endmodule : tetris_control
