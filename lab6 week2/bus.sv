module bus(input logic GateMDR, GateMARMUX, GatePC, GateALU,
			  input logic [15:0] mem_wdata, pc_out, alu_out, marmux_out,
			  output logic [15:0] out);
			  
always_comb
	begin
		if(GateMDR)
			out = mem_wdata;
		else if(GateMARMUX)
			out = marmux_out;
		else if(GatePC)
			out = pc_out;
		else if(GateALU)
			out = alu_out;
		else	
			out = 4'h0000;
	end
endmodule