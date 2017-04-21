module generate (input  clk,
                        reset,
                 input[2:0]  data_in,
                 output[2:0] data_out
);

always_comb
begin
data_out[0]=data_in[1] ^ data_in[2];
data_out[1]=data_in[0];
data_out[2]=data_in[1];
end

endmodule: generate
