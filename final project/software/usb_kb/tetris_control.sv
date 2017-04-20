
module tetris_control ( input 	clk,
								reset,
								decolored,
								canmove,
								reached_top,
								reached_right,
						input[7:0] keycode


);

enum int unsigned {
	s_init,
	s_generate,
	s_color,
	s_wsram,
	s_wait, 
	s_checkcanmove,
	s_decolor_1,
	s_decolor_2,
	s_moveleft,
	s_moveright,
	s_movedown,
	s_rorate,
	s_checkrow,
	s_eliminaterow,
	s_shiftrows,
	s_decrementy,
	s_incrementx,
	s_readabove,
	s_write_to_current
} state, next_state;


always_comb
begin:  next_state_logic
		next_state = state;

		case(state)
			s_init:
			begin
				next_state = s_generate;
			end

			s_generate:
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
				case(keycode)
					DOWN:
						next_state = s_movedown;

					LEFT:
						next_state = s_moveleft;

					RIGHT:
						next_state = s_moveright;

					UP:
						next_state = s_moveup;

					SPACE:


					ESC:

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

			s_rorate:
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
				next_state = s_incrementy;
			end

		endcase
end

/* Assignment of next state on clock edge */
always_ff @(posedge clk)
begin: next_state_assignment
	state <= next_state;
end

endmodule : tetris_control