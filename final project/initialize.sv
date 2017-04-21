module initialize(
                    input logic[2:0] shape,
                    output logic[1:0] orientation,
                    output logic[4:0] x0, x1, x2, x3,
                    output logic[5:0] y0, y1, y2, y3
);

assign orientation = 0;

always_comb
begin
x0=0;
x1=0; 
x2=0;
x3=0;
y0=0; 
y1=0; 
y2=0; 
y3=0;

  case(shape)
    3'b000:
      begin
        x0=5'd8;
        x1=5'd9; 
        x2=5'd10;
        x3=5'd11;
      end
      
    3'b001:
      begin
        x0=5'd9;
        x1=5'd10; 
        x2=5'd9;
        x3=5'd10;
        y2=5'd1; 
        y3=5'd1;
      end
      
    3'b010:
      begin
        x0=5'd9;
        x1=5'd9; 
        x2=5'd9;
        x3=5'd10; 
        y1=5'd1; 
        y2=5'd2; 
        y3=5'd2;
      end
      
    3'b011:
      begin
        x0=5'd10;
        x1=5'd10; 
        x2=5'd10;
        x3=5'd9; 
        y1=5'd1; 
        y2=5'd2; 
        y3=5'd2;
      end
      
    3'b100:
      begin
        x0=5'd11;
        x1=5'd10; 
        x2=5'd10;
        x3=5'd9;
        y2=5'd1; 
        y3=5'd1;
      end
      
    3'b101:
      begin
        x0=5'd9;
        x1=5'd10; 
        x2=5'd10;
        x3=5'd11; 
        y2=5'd1; 
        y3=5'd1;
      end
      
    3'b110:
      begin
        x0=5'd9;
        x1=5'10; 
        x2=5'd11;
        x3=5'd10;
        y0=5'd1; 
        y1=5'd1; 
        y2=5'd1; 
      end
      
    endcase

end

endmodule: initialize
