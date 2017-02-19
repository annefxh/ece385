module mux4(input logic [1:0] S,
					 input logic [15:0] In0, In1, In2, In3,
					 output logic [15:0] Out);
					 
always_comb
	begin
		if(S == 2'b00)
			Out = In0;
		else if(S == 2'b01)	
			Out = In1;
		else if(S == 2'b10)
			Out = In2;
		else 
			Out = In3;
	end

endmodule	