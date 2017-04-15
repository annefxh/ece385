module shape(input [3:0] shape_sw,
				 output[3:0] shape_hw,
				 output[9:0] x0_min, x0_max, y0_min, y0_max,
						  x1_min, x1_max, y1_min, y1_max,
						  x2_min, x2_max, y2_min, y2_max,
						  x3_min, x3_max, y3_min, y3_max
);

assign shape_hw = shape_sw;

always_comb
begin
	case(shape_sw):
		3'b000:
			begin
				x0_min=313; 
				x0_max=320; 
				y0_min=0; 
				y0_max=7;
				
			   x1_min=321; 
				x1_max=328;
				y1_min=0;
				y1_max=7;
				
				x2_min=313;
				x2_max=320; 
				y2_min=8;
				y2_max=15;
				
			   x3_min=321; 
				x3_max=328; 
				y3_min=8; 
				y3_max=15;
			end
		3'b001:
			begin
				x0_min =317; 
				x0_max =324; 
				y0_min =0; 
				y0_max =7;
				
			   x1_min=317; 
				x1_max=324;
				y1_min=8;
				y1_max=15;
				
				x2_min=317;
				x2_max=324; 
				y2_min=16;
				y2_max=23;
			   
				x3_min=317; 
				x3_max=324; 
				y3_min=24; 
				y3_max=31;
			end
		3'b010:
			begin
				x0_min =313; 
				x0_max =320; 
				y0_min =0; 
				y0_max =7;
				
			   x1_min=313; 
				x1_max=320;
				y1_min=8;
				y1_max=15;
				
				x2_min=321;
				x2_max=328; 
				y2_min=8;
				y2_max=15;
			   
				x3_min=321; 
				x3_max=328; 
				y3_min=16; 
				y3_max=23;
			end
		3'b011:
			begin
				x0_min =321; 
				x0_max =328; 
				y0_min =0; 
				y0_max =7;
				
			   x1_min=321; 
				x1_max=328;
				y1_min=8;
				y1_max=15;
				
				x2_min=313;
				x2_max=320; 
				y2_min=8;
				y2_max=15;
			   
				x3_min=313; 
				x3_max=320; 
				y3_min=16; 
				y3_max=23;
			end
		3'b100:
			begin
				x0_min =313; 
				x0_max =320; 
				y0_min =0; 
				y0_max =7;
				
			   x1_min=313; 
				x1_max=320;
				y1_min=8;
				y1_max=15;
				
				x2_min=313;
				x2_max=320; 
				y2_min=16;
				y2_max=23;
			   
				x3_min=321; 
				x3_max=328; 
				y3_min=16; 
				y3_max=23;
			end
		3'b101:
			begin
				x0_min =321; 
				x0_max =328; 
				y0_min =0; 
				y0_max =7;
				
			   x1_min=321; 
				x1_max=328;
				y1_min=8;
				y1_max=15;
				
				x2_min=321;
				x2_max=328; 
				y2_min=16;
				y2_max=23;
			   
				x3_min=313; 
				x3_max=320; 
				y3_min=16; 
				y3_max=23;
			end
		3'b110:
			begin
				x0_min =317; 
				x0_max =324; 
				y0_min =0; 
				y0_max =7;
				
			   x1_min=309; 
				x1_max=316;
				y1_min=8;
				y1_max=15;
				
				x2_min=317;
				x2_max=324; 
				y2_min=8;
				y2_max=15;
			   
				x3_min=325; 
				x3_max=332; 
				y3_min=8; 
				y3_max=15;
			end
end
