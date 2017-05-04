module generation ( input logic reset,
                  input logic[2:0]  data_in,
                 output logic[2:0] data_out
);
  
always_comb
begin
  if(reset)
    data_out = 3'b101;
  else
  begin
    if(data_in == 3'd3) //special case where output will end up as 3'd7 (background)
       data_out = 3'b101;
    else
      begin
    data_out[0]=data_in[1] ^ data_in[2];
    data_out[1]=data_in[0];
    data_out[2]=data_in[1];
      end
  end
end

endmodule: generation
