package tetris_types;

typedef logic [9:0] coor_xy;

typedef enum {
	MOVE_DOWN;
	MOVE_LEFT;
	MOVE_RIGHT;
	MOVE_ROTATE;
	MOVE_SPACE;
} move_t;

`define DOWN 8'h51;
`define LEFT 8'h50;
`define RIGHT 8'h4F;
`define UP 8'h52;
`define SPACE 8'h2C;
`define ESC 8'h29;

`define GAME_ROW 20;
`define GAME_COL 40;
`define GAME_ROW_WIDTH $clog2(`GAME_ROW);
`define GAME_COL_WIDTH $clog2(`GAME_COL);

`define COLOR_WIDTH 3

typedef struct packed{
	logic [GAME_ROW_WIDTH-1:0] x[0:3];	
	logic [GAME_COL_WIDTH-1:0] y[0:3];
	logic [COLOR_WIDTH-1:0] shape;
	logic [1:0] orientation;
}shape_t;

typedef struct packed{
	logic[`COLOR_WIDTH:0] screen [0:`GAME_ROW_WIDTH-1][0:`GAME_COL_WIDTH-1];
	shape_t next_block;
}game_t;




