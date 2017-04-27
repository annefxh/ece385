module down(input reset, 
	      input logic[4:0] x, 
	      input logic[5:0] y, 
	      output logic[4:0] x_out, 
	      output logic[5:0]y_out
						
);

always_comb
begin
	x_out = x;
	y_out = y+1;
end
endmodule