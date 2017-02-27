module ALU(input[1:0] sel, 
			  input[15:0]A, B,
			  output[15:0] aluout);
logic [15:0] out;
assign aluout = out;			  
always_comb
 begin			  
	unique case(sel)
		2'b00: out= A+B;
		2'b01: out= A&B;
		2'b10: out=~A;
		2'b11: out= A;
		default: out = 16'h0000;
	endcase
end

endmodule : ALU