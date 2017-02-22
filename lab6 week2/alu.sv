module ALU(input[1:0] sel, 
			  input[15:0]A, B,
			  output[15:0] aluout);

always @(sel) begin			  
	unique case(sel)
		2'b00: aluout= A+B;
		2'b01: aluout= A&B;
		2'b10: aluout=~A;
		default: aluout = 16'h0000;
	endcase
end

endmodule : ALU