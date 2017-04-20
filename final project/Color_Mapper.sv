//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  03-03-2017                               --
//                                                                       --
//    Spring 2017 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

import tetris_types::*;
module  color_mapper ( input logic[3:0] pixel ;       // Ball coordinates
                                                             // Ball size (defined in ball.sv)
                       input  [9:0]             DrawX, DrawY,       // Coordinates of current drawing pixel
							  input [3:0] shape,
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    
    logic squre_on;
    logic [7:0] Red, Green, Blue;
     
 /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
    the single line is quite powerful descriptively, it causes the synthesis tool to use up three
    of the 12 available multipliers on the chip! Since the multiplicants are required to be signed,
    we have to first cast them from logic to int (signed by default) before they are multiplied. */
      
    /*int DistX, DistY, Size;
    assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = BallS;*/
    
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Compute whether the pixel corresponds to ball or background
    always_comb
    begin : Ball_on_proc
        //if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) 
		  if(DrawX >= 240 && DrawX <= 400 && DrawY >= 80 && DrawY <= 400)
            squre_on = 1'b1;
        else 
            squre_on = 1'b0;
    end
    
    // Assign color based on ball_on signal
    always_comb
    begin : RGB_Display
        if ((squre_on == 1'b1)) 
			case(pixel):
				3'b000:
					begin
						Red = 8'hff;
						Green = 8'hff;
						Blue = 8'h00;
					end
				3'b001:
					begin
						Red = 8'h00;
						Green = 8'hff;
						Blue = 8'hff;
					end
				3'b010:
					begin
						Red = 8'h00;
						Green = 8'hff;
						Blue = 8'h00;
					end
				3'b011:
					begin
						Red = 8'hff;
						Green = 8'h00;
						Blue = 8'h00;
					end
				3'b100:
					begin
						Red = 8'hff;
						Green = 8'h80;
						Blue = 8'h00;
					end
				3'b101:
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'hff;
					end
				3'b110:
					begin
						Red = 8'hff;
						Green = 8'h00;
						Blue = 8'hff;
					end
				3'b111:
					begin
						Red = 8'h00;
						Green = 8'h00;
						Blue = 8'h00;
					end
				endcase;
        else 
        begin
            // Background with nice color gradient
            Red = 8'hff; 
            Green = 8'hff;
            Blue = 8'hff; //.- {1'b0, DrawX[9:3]};
        end
    end 
    
endmodule

