module datapath(input logic ld_pc, ld_ir, ld_mdr, ld_mar, clk, reset,
						input logic GatePC, GateMDR, GateALU, GateMARMUX,
						input logic [1:0]pcmux_sel,
						input logic mio_en,
						input logic [15:0] mem_rdata, 
						output logic[19:0] mem_address, 
						output logic[15:0] mem_wdata,
						output logic[15:0] IR);
						
						
logic[15:0] pc_out, mar_out, pcmux_out, bus_out, mdrmux_out;

mux4 pcmux
(
	.S(pcmux_sel),
	.In0(pc_out + 4'h0001),
	.In1(),
	.In2(),
	.In3(),
	.Out(pcmux_out)
);

register pc_reg
(
    .clk,
	 .reset,
	 .load(ld_pc),
	 .in(pcmux_out),
	 .out(pc_out)
);

register ir_reg
(
    .clk,
	 .reset,
	 .load(ld_ir),
	 .in(bus_out),
	 .out(IR)
);

mux2 mdr_mux
(
	.S(mio_en),
	.In0(),
	.In1(mem_rdata),
	.Out(mdrmux_out)
);

register mdr_reg
(
    .clk,
	 .reset,
	 .load(ld_mdr),
	 .in(mdrmux_out),
	 .out(mem_wdata)
);

register mar_reg
(
    .clk,
	 .reset,
	 .load(ld_mar),
	 .in(bus_out),
	 .out(mar_out)
);

//mux2 marmux
//(
// .S(marmux_sel),
// .In0(pc_out), 
// .In1(),
// .Out(marmux_out)
// );
 
 zext mar_zext
 (
	.in(mar_out),
	.out(mem_address)
 );
 
bus bus1(.GateMDR(GateMDR), .GateMARMUX(GateMARMUX), .GatePC(GatePC), .GateALU(GateALU),
			.mem_wdata(mem_wdata), .pc_out(pc_out), .alu_out(alu_out), .marmux_out(),
			.out(bus_out));
 		
endmodule
 