import tetris_types::*;

module movement( input frame_clk,
					  input run,
					  input shape_t shape_in,
					  input[7:0]  keycode,
					  input [`GAME_ROW_WIDTH-1:0][`GAME_COL_WIDTH-1:0] screen_in,
					  output[`GAME_ROW_WIDTH-1:0] move_x[0:3], [`GAME_COL_WIDTH-1:0]move_y[0:3]
					  );

always_ff @ (posedge frame_clk)
begin
end

always_comb 
begin
	unique case(keycode[7:0])
	
	DOWN:
		
	
	UP:
	
	LEFT:
	
	RIGHT:
	
	default:
	
end
