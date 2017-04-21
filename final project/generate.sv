module generate (input logic[2:0]  data_in,
                 output logic[2:0] data_out
);

always_comb
begin
  if(reset)
    data_out = 3'b000;
  else
  begin
    data_out[0]=data_in[1] ^ data_in[2];
    data_out[1]=data_in[0];
    data_out[2]=data_in[1];
  end
end

endmodule: generate
