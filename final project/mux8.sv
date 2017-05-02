module mux8#(parameter width=5)
(
	input logic [2:0] S,
	input logic [width-1:0] In0,In1,In2,In3,In4,In5,In6,In7,
	output logic [width-1:0] Out
);
					 
always_comb
	begin
		if(S == 3'b000)
			Out = In0;
		else if(S == 3'b001)	
			Out = In1;
		else if(S == 3'b010)
			Out = In2;
		else if(S == 3'b011)
			Out = In3;
		else if(S == 3'b100)
			Out = In4;
		else if(S == 3'b101)
			Out = In5;
		else if(S == 3'b110)
			Out = In6;
		else 
			Out = In7;
	end

endmodule	
