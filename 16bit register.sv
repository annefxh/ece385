module Register_16bit(input logic Clk, Reset, Load, 
							 input logic [15:0] D, 
						    output logic [15:0] Data_Out);

always_ff @ (posedge Clk or posedge Reset)
begin
	if(Reset)
		Data_Out <= 16'h0;
	else if(Load)
		Data_Out <= D;
end

endmodule