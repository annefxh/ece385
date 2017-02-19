module datapath(input logic ld_pc, ld_ir, ld_mdr, ld_mar, clk,
						input logic [1:0]pcmux_sel,
						input logic mio_en, marmux_sel,
						input logic [15:0] mem_rdata,
						output logic[19:0] mem_address, 
						output logic[15:0] mem_wdata,
						output logic[15:0] IR);
						
						
logic[15:0] pc_out, mar_out, mdr_out, pcmux_out, ir_out, marmux_out, mdrmux_out;

mux4 pcmux
(
	.S(pcmux_sel),
	.In0(4'h0000),
	.In1(4'h0000),
	.In2(pc_out+1),
	.In3(4'h0000),
	.Out(pcmux_out)
);

register pc_reg
(
    .clk,
	 .load(ld_pc),
	 .in(pcmux_out),
	 .out(pc_out)
);

register ir_reg
(
    .clk,
	 .load(ld_ir),
	 .in(mem_rdata),
	 .out(IR)
);

mux2 mdr_mux
(
	.S(mio_en),
	.In0(mem_wdata),
	.In1(),
	.Out(mdrmux_out)
);

register mdr_reg
(
    .clk,
	 .load(ld_mdr),
	 .in(mdrmux_out),
	 .out(mdr_out)
);

register mar_reg
(
    .clk,
	 .load(ld_mar),
	 .in(marmux_out),
	 .out(mar_out)
);

mux2 marmux
(
 .S(marmux_sel),
 .In0(pc_out), 
 .In1(),
 .Out(marmux_out)
 );
 
 zext mar_zext
 (
	.in(mar_out),
	.out(mem_address)
 );
 		
endmodule
 