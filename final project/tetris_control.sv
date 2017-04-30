
module tetris_control ( input logic clk,
				    				reset,
				    				//canmove,
				    				reached_top,
				    				reached_right,
		       		    			start_game,
					   input logic [4:0] rotate_x,
												x0_o,
												x1_o,
												x2_o,
												x3_o,
					   input logic [5:0] rotate_y,
												y0_o,
												y1_o,
												y2_o,
												y3_o,
		       			input [2:0] shape,
		        		input [7:0] keycode,
					    input [2:0] sram_color,
						 input logic games_start,
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
		       			output logic [2:0] blkreg_sel,
						output logic [2:0] color_w,
		       			output logic [4:0] curr_x,
		       			output logic [5:0] curr_y
);

	logic init_d; //init done
	logic decolor; //remove shape
	logic decolor_d; //removal done
	logic canmove;
	logic r_decolor;
	logic [4:0] init_x;
	logic [5:0] init_y;
	logic [2:0] blk; //square count
	logic [2:0] color_ctrl;
	logic [1:0] checkmove; //0:down, 1:left, 2:right, 3:rorate
	
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
	s_decolor_2,
	s_moveleft,
	s_moveright,
	s_movedown,
	s_rotate,
	s_checkrow,
	s_eliminaterow,
	s_shiftrows,
	s_decrementy,
	s_incrementx,
	s_readabove,
	s_write_to_current
} state, next_state;

always_comb
begin: state_actions
	
 	/* default output values */
	r_rotate = 0;
	r_down = 0;
	r_left = 0;
	r_right = 0;
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
	
	case(state)
		s_reset:
			begin
				init_x = 5'd0;
				init_y = 6'd0;
				init_d = 1'b0;
				decolor = 1'b0;
				decolor_d = 1'b0;
				blk = 2'd0;
				color_ctrl = 3'd7;
				canmove = 1'b1;
			end
		
		s_init:
			begin
			// init is done, game start button pressed
				if(games_start == 1'b1 && init_y == 6'd41)
					begin
						init_x = 5'd0;
						init_y = 6'd0;
						blk = 3'd0;
						init_d = 1'b1;
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
								init_x = 5'd0;
								init_y += 1;
							end
						else
							begin
								init_x += 1;
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
			if(blk == 3'd4)
				begin
					blk = 3'd0;
					if(decolor)
						begin
							decolor_d = 1'b1;
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
							end
						3'd2:
							begin
								curr_x = x2_o;
								curr_y = y2_o;
							end
						3'd3:
							begin
								curr_x = x3_o;
								curr_y = y3_o;
							end
						default:
							begin
								curr_x = x0_o;
								curr_y = y0_o;
							end	
					endcase
					blk += 1;
				end
		
		s_wait:
			begin
			case(keycode)
					8'h51:
						checkmove = 0;

					8'h50:
						checkmove = 1;

					8'h4F:
						checkmove = 2;

					8'h52:
						checkmove = 3;
				
					default: 
						checkmove = 0;
				endcase
			end
		
		s_checkcanmove_1:
			//r_checkcanmove=1;
			begin
				if(canmove)
					begin
						if(blk == 3'd4)
							blk = 3'd0;
						
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
														curr_y = y1_o+1;
													end
												3'd2:
													begin
														curr_x = x2_o;
														curr_y = y2_o+1;
													end
												3'd3:
													begin
														curr_x = x3_o;
														curr_y = y3_o+1;
													end
												default:
													begin
														curr_x = x0_o;
														curr_y = y0_o+1;
													end	
											endcase
										end	
									2'd1: //left
										begin
											case(blk)
												3'd1: 
													begin
														curr_x = x1_o-1;
														curr_y = y1_o;
													end
												3'd2:
													begin
														curr_x = x2_o-1;
														curr_y = y2_o;
													end
												3'd3:
													begin
														curr_x = x3_o-1;
														curr_y = y3_o;
													end
												default:
													begin
														curr_x = x0_o-1;
														curr_y = y0_o;
													end	
											endcase
										end
									2'd2://right
										begin
											case(blk)
												3'd1: 
													begin
														curr_x = x1_o+1;
														curr_y = y1_o;
													end
												3'd2:
													begin
														curr_x = x2_o+1;
														curr_y = y2_o;
													end
												3'd3:
													begin
														curr_x = x3_o+1;
														curr_y = y3_o;
													end
												default:
													begin
														curr_x = x0_o+1;
														curr_y = y0_o;
													end	
											endcase
										end
									//2'd3://rotate
										//begin
											//case(blk)
												//3'd1: 
													//begin
														//curr_x = x1_o;
														//curr_y = y1_o;
													//end
												//3'd2:
													//begin
														//curr_x = x2_o;
														//curr_y = y2_o;
													//end
												//3'd3:
													//begin
														//curr_x = x3_o;
														//curr_y = y3_o;
													//end
												//default:
													//begin
														//curr_x = x0_o;
														//curr_y = y0_o;
													//end	
											//endcase
										//end
									
								endcase
							end
					end
				else
					begin
						if (checkmove == 1'b0)
							blk = 3'd0;
					end
			end
		
		s_checkcanmove_2:
		
		s_decolor_1:
			r_decolor=1;
		
		s_decolor_2:
			
		s_moveleft:
			r_left=1;
		
		s_moveright:
			r_right=1;
		
		s_movedown:
		begin
			r_down=1;
		end
		
		s_rotate:
			r_rotate=1;
		s_checkrow: ;
		s_eliminaterow: ;
		s_shiftrows: ;
		s_decrementy: ;
		s_incrementx: ;
		s_readabove: ;
		s_write_to_current: ;
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
				if(init_d)
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
					next_state = s_decolor_2;
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
				next_state = s_wsram;
			end

			s_decolor_2:
			begin
			
				case(keycode)
					8'h51:
						next_state = s_movedown;

					8'h50:
						next_state = s_moveleft;

					8'h4F:
						next_state = s_moveright;

					8'h52:
						next_state = s_rotate;

					default: next_state = s_movedown;
				endcase
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
				next_state = s_eliminaterow;
			end

			s_eliminaterow:
			begin
				next_state = s_shiftrows;
			end

			s_shiftrows:
			begin
				next_state = s_decrementy;
			end

			s_decrementy:
			begin
				if(reached_top)
					next_state = s_generate;
				else
					next_state = s_readabove;
			end

			s_incrementx:
			begin
				if(reached_right)
					next_state = s_readabove;
				else
					next_state = s_decrementy;
			end

			s_readabove:
			begin
				next_state = s_write_to_current;
			end

			s_write_to_current:
			begin
				next_state = s_incrementx;
			end

		endcase
end

/* Assignment of next state on clock edge */
always_ff @(posedge clk)
begin: next_state_assignment
	if(reset)
		state <= s_reset;
	else
		state <= next_state;
end

endmodule : tetris_control
