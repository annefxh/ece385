module rotate(input [9:0] x0_min_in, x0_max_in, y0_min_in, y0_max_in, 
								x1_min_in, x1_max_in, y1_min_in, y1_max_in,
								x2_min_in, x2_max_in, y2_min_in, y2_max_in,
								x3_min_in, x3_max_in, y3_min_in, y3_max_in,
					input [2:0] orientation_in, orientation_out,
					output [9:0]  x0_min_out, x0_max_out, y0_min_out, y0_max_out, 
								x1_min_out, x1_max_out, y1_min_out, y1_max_out,
								x2_min_out, x2_max_out, y2_min_out, y2_max_out,
								x3_min_out, x3_max_out, y3_min_out, y3_max_out)

case(shape):
	orientation_out=2'b00;
	3'b000: 
	begin
		x0_min_out=x0_min_in; 
		x0_max_out=x0_max_in; 
		y0_min_out=y0_min_in; 
		y0_max_out=y0_max_in;
				
		x1_min_out=x1_min_in; 
		x1_max_out=x1_max_in;
		y1_min_out=y1_min_in;
		y1_max_out=y1_max_in;
				
		x2_min_out=x2_min_in;
		x2_max_out=x2_max_in; 
		y2_min_out=y2_min_in;
		y2_max_out=y2_max_in;
				
		x3_min_out=x3_min_in; 
		x3_max_out=x3_max_in; 
		y3_min_out=y3_min_in; 
		y3_max_out=y3_max_in;
	end

	3'b001:
	begin
		if (orientation_in==0)
		begin
		x0_min_out=x0_min_in-8; 
		x0_max_out=x0_max_in-8; 
		y0_min_out=y0_min_in; 
		y0_max_out=y0_max_in;
				
		x1_min_out=x1_min_in; 
		x1_max_out=x1_max_in;
		y1_min_out=y0_min_in;
		y1_max_out=y0_max_in;
				
		x2_min_out=x2_min_in+8;
		x2_max_out=x2_max_in+8; 
		y2_min_out=y0_min_in;
		y2_max_out=y0_max_in;
				
		x3_min_out=x3_min_in+16; 
		x3_max_out=x3_max_in+16; 
		y3_min_out=y0_min_in; 
		y3_max_out=y0_max_in;
		
		orientation_out=2'b01;
		end
		
		else
		begin
		x0_min_out=x0_min_in+8; 
		x0_max_out=x0_max_in+8; 
		y0_min_out=y0_min_in; 
		y0_max_out=y0_max_in;
				
		x1_min_out=x1_min_in+8; 
		x1_max_out=x1_max_in+8;
		y1_min_out=y1_min_in+8;
		y1_max_out=y1_max_in+8;
				
		x2_min_out=x2_min_in-8;
		x2_max_out=x2_max_in-8; 
		y2_min_out=y2_min_in+16;
		y2_max_out=y2_max_in+16;
				
		x3_min_out=x3_min_in-16; 
		x3_max_out=x3_max_in-16; 
		y3_min_out=y3_min_in+24; 
		y3_max_out=y3_max_in+24;
		
		orientation_out=2'b00;
		end
	end

	3'b011:
	begin
		if(orientation_in == 0)
		begin
		x0_min_out=x0_min_in-8; 
		x0_max_out=x0_max_in-8; 
		y0_min_out=y0_min_in; 
		y0_max_out=y0_max_in;
				
		x1_min_out=x1_min_in; 
		x1_max_out=x1_max_in;
		y1_min_out=y1_min_in-8;
		y1_max_out=y1_max_in-8;
				
		x2_min_out=x2_min_in+8;
		x2_max_out=x2_max_in+8; 
		y2_min_out=y2_min_in;
		y2_max_out=y2_max_in;
				
		x3_min_out=x3_min_in+16; 
		x3_max_out=x3_max_in+16; 
		y3_min_out=y3_min_in-8; 
		y3_max_out=y3_max_in-8;
		
		orientation_out=2'b01;
		end
		
		else
		begin
		x0_min_out=x0_min_in+8; 
		x0_max_out=x0_max_in+8; 
		y0_min_out=y0_min_in; 
		y0_max_out=y0_max_in;
				
		x1_min_out=x1_min_in; 
		x1_max_out=x1_max_in;
		y1_min_out=y1_min_in+8;
		y1_max_out=y1_max_in+8;
				
		x2_min_out=x2_min_in-8;
		x2_max_out=x2_max_in-8; 
		y2_min_out=y2_min_in;
		y2_max_out=y2_max_in;
				
		x3_min_out=x3_min_in-16; 
		x3_max_out=x3_max_in-16; 
		y3_min_out=y3_min_in+8; 
		y3_max_out=y3_max_in+8;
		
		orientation_out=2'b00;
		end
	end

	3'b010:
	begin
		if(orientation_in==0)
		begin
		x0_min_out=x0_min_in+16; 
		x0_max_out=x0_max_in+16; 
		y0_min_out=y0_min_in+8; 
		y0_max_out=y0_max_in+8;
				
		x1_min_out=x1_min_in+8; 
		x1_max_out=x1_max_in+8;
		y1_min_out=y1_min_in;
		y1_max_out=y1_max_in;
				
		x2_min_out=x2_min_in;
		x2_max_out=x2_max_in; 
		y2_min_out=y2_min_in+8;
		y2_max_out=y2_max_in+8;
				
		x3_min_out=x3_min_in-8; 
		x3_max_out=x3_max_in-8; 
		y3_min_out=y3_min_in; 
		y3_max_out=y3_max_in;
		
		orientation_out=2'b01;
		end
		
		else
		begin
		x0_min_out=x0_min_in-16; 
		x0_max_out=x0_max_in-16; 
		y0_min_out=y0_min_in-8; 
		y0_max_out=y0_max_in-8;
				
		x1_min_out=x1_min_in-8; 
		x1_max_out=x1_max_in-8;
		y1_min_out=y1_min_in;
		y1_max_out=y1_max_in;
				
		x2_min_out=x2_min_in;
		x2_max_out=x2_max_in; 
		y2_min_out=y2_min_in-8;
		y2_max_out=y2_max_in-8;
				
		x3_min_out=x3_min_in+8; 
		x3_max_out=x3_max_in+8; 
		y3_min_out=y3_min_in; 
		y3_max_out=y3_max_in;
		
		orientation_out=2'b00;
		end
	end

	3'b100:
	begin
		if(orientation_in == 0)
		begin
		x0_min_out=x0_min_in+16; 
		x0_max_out=x0_max_in+16; 
		y0_min_out=y0_min_in+8; 
		y0_max_out=y0_max_in+8;
				
		x1_min_out=x1_min_in+8; 
		x1_max_out=x1_max_in+8;
		y1_min_out=y1_min_in;
		y1_max_out=y1_max_in;
				
		x2_min_out=x2_min_in;
		x2_max_out=x2_max_in; 
		y2_min_out=y2_min_in-8;
		y2_max_out=y2_max_in-8;
				
		x3_min_out=x3_min_in-8; 
		x3_max_out=x3_max_in-8; 
		y3_min_out=y3_min_in; 
		y3_max_out=y3_max_in;
		
		orientation_out=2'b01;
		end
		if (orientation_in == 2'b01)
		begin
		x0_min_out=x0_min_in-8; 
		x0_max_out=x0_max_in-8; 
		y0_min_out=y0_min_in+16; 
		y0_max_out=y0_max_in+16;
				
		x1_min_out=x1_min_in; 
		x1_max_out=x1_max_in;
		y1_min_out=y1_min_in+8;
		y1_max_out=y1_max_in+8;
				
		x2_min_out=x2_min_in+8;
		x2_max_out=x2_max_in+8; 
		y2_min_out=y2_min_in;
		y2_max_out=y2_max_in;
				
		x3_min_out=x3_min_in; 
		x3_max_out=x3_max_in; 
		y3_min_out=y3_min_in-8; 
		y3_max_out=y3_max_in-8;
		
		orientation_out=2'b10;
		end
		
		if (orientation_in == 2'b10)
		begin
		x0_min_out=x0_min_in-8; 
		x0_max_out=x0_max_in-8; 
		y0_min_out=y0_min_in-8; 
		y0_max_out=y0_max_in-8;
				
		x1_min_out=x1_min_in; 
		x1_max_out=x1_max_in;
		y1_min_out=y1_min_in;
		y1_max_out=y1_max_in;
				
		x2_min_out=x2_min_in+8;
		x2_max_out=x2_max_in+8; 
		y2_min_out=y2_min_in+8;
		y2_max_out=y2_max_in+8;
				
		x3_min_out=x3_min_in+16; 
		x3_max_out=x3_max_in+16; 
		y3_min_out=y3_min_in; 
		y3_max_out=y3_max_in;
		
		orientation_out=2'b11;
		end
		
		if(orientation_in == 2'b11)
		begin
		x0_min_out=x0_min_in+8; 
		x0_max_out=x0_max_in+8; 
		y0_min_out=y0_min_in-16; 
		y0_max_out=y0_max_in-16;
				
		x1_min_out=x1_min_in; 
		x1_max_out=x1_max_in;
		y1_min_out=y1_min_in-8;
		y1_max_out=y1_max_in-8;
				
		x2_min_out=x2_min_in-8;
		x2_max_out=x2_max_in-8; 
		y2_min_out=y2_min_in;
		y2_max_out=y2_max_in;
				
		x3_min_out=x3_min_in; 
		x3_max_out=x3_max_in; 
		y3_min_out=y3_min_in+8; 
		y3_max_out=y3_max_in+8;
		
		orientation_out=2'b00;
		end
		
	end

	3'b101:
	begin
	if (orientation_in == 0)
	begin
		x0_min_out=x0_min_in+8; 
		x0_max_out=x0_max_in+8; 
		y0_min_out=y0_min_in+16; 
		y0_max_out=y0_max_in+16;
				
		x1_min_out=x1_min_in; 
		x1_max_out=x1_max_in;
		y1_min_out=y1_min_in+8;
		y1_max_out=y1_max_in+8;
				
		x2_min_out=x2_min_in-8;
		x2_max_out=x2_max_in-8; 
		y2_min_out=y2_min_in;
		y2_max_out=y2_max_in;
				
		x3_min_out=x3_min_in; 
		x3_max_out=x3_max_in; 
		y3_min_out=y3_min_in-8; 
		y3_max_out=y3_max_in-8;
		
		orientation_out=2'b01;
	end
	if (orientation_in == 2'b01)
		begin
		x0_min_out=x0_min_in-8; 
		x0_max_out=x0_max_in-8; 
		y0_min_out=y0_min_in+8; 
		y0_max_out=y0_max_in+8;
				
		x1_min_out=x1_min_in; 
		x1_max_out=x1_max_in;
		y1_min_out=y1_min_in+8;
		y1_max_out=y1_max_in+8;
				
		x2_min_out=x2_min_in+8;
		x2_max_out=x2_max_in+8; 
		y2_min_out=y2_min_in-8;
		y2_max_out=y2_max_in-8;
				
		x3_min_out=x3_min_in+16; 
		x3_max_out=x3_max_in+16; 
		y3_min_out=y3_min_in; 
		y3_max_out=y3_max_in;
		
		orientation_out=2'b10;
		end
		
		if (orientation_in == 2'b10)
		begin
		x0_min_out=x0_min_in-16; 
		x0_max_out=x0_max_in-16; 
		y0_min_out=y0_min_in-16; 
		y0_max_out=y0_max_in-16;
				
		x1_min_out=x1_min_in-8; 
		x1_max_out=x1_max_in-8;
		y1_min_out=y1_min_in-8;
		y1_max_out=y1_max_in-8;
				
		x2_min_out=x2_min_in;
		x2_max_out=x2_max_in; 
		y2_min_out=y2_min_in;
		y2_max_out=y2_max_in;
				
		x3_min_out=x3_min_in-8; 
		x3_max_out=x3_max_in-8; 
		y3_min_out=y3_min_in+8; 
		y3_max_out=y3_max_in+8;
		
		orientation_out=2'b11;
		end
		
		if(orientation_in == 2'b11)
		begin
		x0_min_out=x0_min_in+8; 
		x0_max_out=x0_max_in+8; 
		y0_min_out=y0_min_in-8; 
		y0_max_out=y0_max_in-8;
				
		x1_min_out=x1_min_in; 
		x1_max_out=x1_max_in;
		y1_min_out=y1_min_in;
		y1_max_out=y1_max_in;
				
		x2_min_out=x2_min_in-8;
		x2_max_out=x2_max_in-8; 
		y2_min_out=y2_min_in+8;
		y2_max_out=y2_max_in+8;
				
		x3_min_out=x3_min_in-16; 
		x3_max_out=x3_max_in-16; 
		y3_min_out=y3_min_in; 
		y3_max_out=y3_max_in;
		
		orientation_out=2'b00;
		end

	3'b110:
	begin
		if(orientation_in == 0)
		begin
		x0_min_out=x0_min_in+8; 
		x0_max_out=x0_max_in+8; 
		y0_min_out=y0_min_in+8; 
		y0_max_out=y0_max_in+8;
				
		x1_min_out=x1_min_in+8; 
		x1_max_out=x1_max_in+8;
		y1_min_out=y1_min_in-8;
		y1_max_out=y1_max_in-8;
				
		x2_min_out=x2_min_in;
		x2_max_out=x2_max_in; 
		y2_min_out=y2_min_in;
		y2_max_out=y2_max_in;
				
		x3_min_out=x3_min_in-8; 
		x3_max_out=x3_max_in-8; 
		y3_min_out=y3_min_in+8; 
		y3_max_out=y3_max_in+8;
		
		orientation_out=2'b01;
		end
		if (orientation_in == 2'b01)
		begin
		x0_min_out=x0_min_in-8; 
		x0_max_out=x0_max_in-8; 
		y0_min_out=y0_min_in+8; 
		y0_max_out=y0_max_in+8;
				
		x1_min_out=x1_min_in+8; 
		x1_max_out=x1_max_in+8;
		y1_min_out=y1_min_in+8;
		y1_max_out=y1_max_in+8;
				
		x2_min_out=x2_min_in;
		x2_max_out=x2_max_in; 
		y2_min_out=y2_min_in;
		y2_max_out=y2_max_in;
				
		x3_min_out=x3_min_in-8; 
		x3_max_out=x3_max_in-8; 
		y3_min_out=y3_min_in-8; 
		y3_max_out=y3_max_in-8;
		
		orientation_out=2'b10;
		end
		
		if (orientation_in == 2'b10)
		begin
		x0_min_out=x0_min_in-8; 
		x0_max_out=x0_max_in-8; 
		y0_min_out=y0_min_in-8; 
		y0_max_out=y0_max_in-8;
				
		x1_min_out=x1_min_in-8; 
		x1_max_out=x1_max_in-8;
		y1_min_out=y1_min_in+8;
		y1_max_out=y1_max_in+8;
				
		x2_min_out=x2_min_in+8;
		x2_max_out=x2_max_in+8; 
		y2_min_out=y2_min_in+8;
		y2_max_out=y2_max_in+8;
				
		x3_min_out=x3_min_in+8; 
		x3_max_out=x3_max_in+8; 
		y3_min_out=y3_min_in-8; 
		y3_max_out=y3_max_in-8;
		
		orientation_out=2'b11;
		end
		
		if(orientation_in == 2'b11)
		begin
		x0_min_out=x0_min_in+8; 
		x0_max_out=x0_max_in+8; 
		y0_min_out=y0_min_in-8; 
		y0_max_out=y0_max_in-8;
				
		x1_min_out=x1_min_in-8; 
		x1_max_out=x1_max_in-8;
		y1_min_out=y1_min_in-8;
		y1_max_out=y1_max_in-8;
				
		x2_min_out=x2_min_in;
		x2_max_out=x2_max_in; 
		y2_min_out=y2_min_in;
		y2_max_out=y2_max_in;
				
		x3_min_out=x3_min_in+8; 
		x3_max_out=x3_max_in+8; 
		y3_min_out=y3_min_in+8; 
		y3_max_out=y3_max_in+8;
		
		orientation_out=2'b00;
		end
		
	end