
module tetris_control ( input logic clk,
				    reset,
				    decolored,
				    canmove,
				    reached_top,
				    reached_right,
		       		    start_game,
		       
		        input[7:0]  keycode,
		        output logic r_rotate,
		       		     r_down,
		       		     r_left,
		       		     r_right,
		       		     r_color,
		       		     r_wsram,
		       		     r_checkcanmove,
		       		     r_decolor,
		       		     game_start,
		       		     r_generate,
		       		     r_initialize,
		       		     sram_we,
		       		     sram_re,
				output logic [2:0] color_w,
		       	output logic [4:0] curr_x,
		       	output logic [5:0] curr_y
		       
);

	logic init_d;
	logic [4:0] init_x;
	logic [5:0] init_y;
	logic [1:0] blk;
	
enum int unsigned {
	s_reset,
	s_init,
	s_generate,
	s_initialize,
	s_color,
	s_wsram,
	s_wait, 
	s_checkcanmove,
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
	r_color = 0;
	r_wsram = 0;
	//r_wait = 0;
	r_checkcanmove = 0;
	r_decolor = 0;
	r_generate = 0;
	r_initialize = 0;
	sram_we = 0;
	sram_re = 0;
	curr_x = 5'd0;
	curr_y = 6'd0;
	color_w = 3'd7; //white
	
	case(state)
		s_reset:
			begin
				init_x = 5'd0;
				init_y = 6'd0;
			end
		
		s_init:
			begin
			// init is done, game start button pressed
				if(games_start == 1'b1 && init_y == 6'd40)
					begin
						init_x = 5'd0;
						init_y = 6'd0;
						blk = 2'd0;
						init_d = 1'b1;
					end
		    //game init in progress
				else
					begin
						sram_we = 1'b1;
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
		s_color:
			r_color=1;	
		s_wsram:
			r_wsram=1;
		s_wait:;
			//r_wait=1;
		s_checkcanmove:
			r_checkcanmove=1;
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
				if(decolored)
					next_state = s_decolor_2;
				else 
					next_state = s_wait;
			end

			s_wait:
			begin
				next_state = s_checkcanmove;
			end

			s_checkcanmove:
			begin
				if(canmove)
					next_state = s_decolor_1;
				else
					next_state = s_checkrow;
			end

			s_decolor_1:
			begin
				next_state = s_wsram;
			end

			s_decolor_2:
			begin
			next_state = state;
				case(keycode)
					8'h51:
						next_state = s_movedown;

					8'h50:
						next_state = s_moveleft;

					8'h4F:
						next_state = s_moveright;

					8'h52:
						next_state = s_rotate;

					8'h2C:;


					8'h29:;

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
