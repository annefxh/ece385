module rotate(input x, y, square_no, orientation_in, shape,
				  output x_out, y_out,orientation_out
						
);
always_comb
begin
case(shape):
	orientation_out=2'b00;
	3'b000: 
	begin
		if(orientation_in == 2'00)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x+1;
						y_out = y-1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x-1;
						y_out = y+1;
					end
			
					2'b11:
					begin
						x_out = x-2;
						y_out = y+2;
					end
				endcase
				orientation_out = 2'b01;
			end
		else
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x-1;
						y_out = y+1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x+1;
						y_out = y-1;
					end
			
					2'b11:
					begin
						x_out = x+2;
						y_out = y-2;
					end
				endcase
				orientation_out = 2'b00;
			end
	end

	3'b001:
	begin
		x_out = x;
		y_out = y;
	end

	3'b011:
	begin
		begin
		if(orientation_in == 2'00)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x-1;
						y_out = y+1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x+1;
						y_out = y-1;
					end
			
					2'b11:
					begin
						x_out = x;
						y_out = y-1;
					end
				endcase
				orientation_out = 2'b01;
			end
			
		else if(orientation_in == 2'b01)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x+1;
						y_out = y+1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x-1;
						y_out = y-1;
					end
			
					2'b11:
					begin
						x_out = x-2;
						y_out = y;
					end
				endcase
				orientation_out = 2'b10;
			end
			
		else if(orientation_in == 2'b10)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x+1;
						y_out = y+1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x+1;
						y_out = y-1;
					end
			
					2'b11:
					begin
						x_out = x;
						y_out = y-2;
					end
				endcase
				orientation_out = 2'b11;
			end
			
		else if(orientation_in == 2'b11)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x-1;
						y_out = y-1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x+1;
						y_out = y+1;
					end
			
					2'b11:
					begin
						x_out = x+2;
						y_out = y;
					end
				endcase
				orientation_out = 2'b00;
			end
	end

	3'b010:
	begin
		begin
		if(orientation_in == 2'00)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x-1;
						y_out = y+1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x+1;
						y_out = y-1;
					end
			
					2'b11:
					begin
						x_out = x+2;
						y_out = y;
					end
				endcase
				orientation_out = 2'b01;
			end
			
		else if(orientation_in == 2'b01)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x+2;
						y_out = y+1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x-1;
						y_out = y-1;
					end
			
					2'b11:
					begin
						x_out = x;
						y_out = y-2;
					end
				endcase
				orientation_out = 2'b10;
			end
			
		else if(orientation_in == 2'b10)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x+1;
						y_out = y-1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x-1;
						y_out = y+1;
					end
			
					2'b11:
					begin
						x_out = x-2;
						y_out = y;
					end
				endcase
				orientation_out = 2'b11;
			end
			
		else if(orientation_in == 2'b11)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x-1;
						y_out = y-1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x+1;
						y_out = y+1;
					end
			
					2'b11:
					begin
						x_out = x;
						y_out = y+2;
					end
				endcase
				orientation_out = 2'b00;
			end
	end


	3'b100:
	begin
		if(orientation_in == 2'00)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x-1;
						y_out = y-1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x+1;
						y_out = y-1;
					end
			
					2'b11:
					begin
						x_out = x+2;
						y_out = y;
					end
				endcase
				orientation_out = 2'b01;
			end
		else
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x+1;
						y_out = y+1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x-1;
						y_out = y+1;
					end
			
					2'b11:
					begin
						x_out = x-2;
						y_out = y;
					end
				endcase
				orientation_out = 2'b00;
			end
	end

	3'b101:
	begin
		if(orientation_in == 2'00)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x+1;
						y_out = y-1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x-1;
						y_out = y-1;
					end
			
					2'b11:
					begin
						x_out = x-2;
						y_out = y;
					end
				endcase
				orientation_out = 2'b01;
			end
		else
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x-1;
						y_out = y+1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x+1;
						y_out = y+1;
					end
			
					2'b11:
					begin
						x_out = x+2;
						y_out = y;
					end
				endcase
				orientation_out = 2'b00;
			end
	end

	3'b110:
	begin
		begin
		if(orientation_in == 2'00)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x+1;
						y_out = y+1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x-1;
						y_out = y-1;
					end
			
					2'b11:
					begin
						x_out = x-1;
						y_out = y+1;
					end
				endcase
				orientation_out = 2'b01;
			end
			
		else if(orientation_in == 2'b01)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x+1;
						y_out = y-1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x-1;
						y_out = y+1;
					end
			
					2'b11:
					begin
						x_out = x+1;
						y_out = y+1;
					end
				endcase
				orientation_out = 2'b10;
			end
			
		else if(orientation_in == 2'b10)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x-1;
						y_out = y-1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x+1;
						y_out = y+1;
					end
			
					2'b11:
					begin
						x_out = x+1;
						y_out = y-1;
					end
				endcase
				orientation_out = 2'b11;
			end
			
		else if(orientation_in == 2'b11)
			begin
				case(square_no):
					2'b00:
					begin
						x_out = x-1;
						y_out = y+1;
					end
			
					2'b01:
					begin
						x_out = x;
						y_out = y;
					end
			
					2'b10:
					begin
						x_out = x+1;
						y_out = y-1;
					end
			
					2'b11:
					begin
						x_out = x-1;
						y_out = y-1;
					end
				endcase
				orientation_out = 2'b00;
			end
	end
endcase		
end
