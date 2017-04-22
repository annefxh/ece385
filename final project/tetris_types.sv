package tetris_types;


parameter DOWN 8'h51;
parameter LEFT 8'h50;
parameter RIGHT 8'h4F;
parameter UP 8'h52;
parameter SPACE 8'h2C;
parameter ESC 8'h29;

parameter GAME_ROW 20;
parameter GAME_COL 40;


parameter COLOR_WIDTH 3

typedef struct packed{
	logic [GAME_ROW_WIDTH-1:0] x[0:3];	
	logic [GAME_COL_WIDTH-1:0] y[0:3];
	logic [COLOR_WIDTH-1:0] shape;
	logic [1:0] orientation;
}shape_t;

typedef struct packed{
	logic[COLOR_WIDTH:0] screen [0:GAME_ROW_WIDTH-1][0:GAME_COL_WIDTH-1];
	shape_t next_block;
}game_t;



endpackage : tetris_types