module 2to1_mux(input logic S,
					 input logic [15:0] In0, In1,
					 output logic [15:0] Out);
					 
always_comb
	begin
		if(S)
			Out = In1;
		else	
			Out = In0;
	end

endmodule	