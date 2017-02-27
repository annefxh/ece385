module datapath(input logic ld_pc, ld_ir, ld_mdr, ld_mar, clk, reset, LD_BEN, LD_CC,
						input logic GatePC, GateMDR, GateALU, GateMARMUX,
						input logic [1:0]pcmux_sel, addr2mux_sel, ALUK, 
						input logic mio_en, drmux_sel, sr1mux_sel, LD_REG, sr2mux_sel, addr1mux_sel, 
						input logic [15:0] mem_rdata, 
						output logic BEN,
						output logic[19:0] mem_address, 
						output logic[15:0] mem_wdata,
						output logic[15:0] IR);
						
						
logic[15:0] pc_out, mar_out, pcmux_out, bus_out, mdrmux_out;
logic[15:0] addr1mux_out, addr2mux_out, addradder_out;
logic[15:0] sext11_out, sext9_out, sext6_out, sext5_out;
logic[2:0]  sr1muxout, drmuxout, nzp, nzpreg_out; 
logic[15:0] sr2mux_out, alu_out, sr1out, sr2out;


assign addradder_out = addr1mux_out + addr2mux_out;

mux4 pcmux
(
	.S(pcmux_sel),
	.In0(pc_out + 4'h0001),
	.In1(addradder_out),
	.In2(bus_out),
	.In3(16'b0),
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

ben_logic BEN_logic
(
	.bus_out,
	.nzp
);

register #(.width(3)) nzp_reg
(
	.clk,
	.load(LD_CC),
	.reset,
	.in(nzp),
	.out(nzpreg_out)
);

ben ben2logic
(
	.nzp(nzpreg_out),
	.NZP(IR[11:9]),
	.BEN
);

sext #(.width(11)) sext_11
(
	.a(IR[10:0]),
	.y(sext11_out)
);

sext #(.width(9)) sext_9
(
	.a(IR[8:0]),
	.y(sext9_out)
);

sext #(.width(6)) sext_6
(
	.a(IR[5:0]),
	.y(sext6_out)
);

sext #(.width(5)) sext_5
(
	.a(IR[4:0]),
	.y(sext5_out)
);

mux4 addr2mux
(
	.In0(sext11_out),
	.In1(sext9_out),
	.In2(sext6_out),
	.In3(16'b0),
	.S(addr2mux_sel),
	.Out(addr2mux_out)
);

mux2 addr1mux
(
	.In0(sr1out),
	.In1(pc_out),
	.S(addr1mux_sel),
	.Out(addr1mux_out)
);

mux2 sr2mux
(	
	.In0(sext5_out),
	.In1(sr2out),
	.S(sr2mux_sel),
	.Out(sr2mux_out)
);

ALU alu
(	
	.A(sr1out),
	.B(sr2mux_out),
	.sel(ALUK),
	.aluout(alu_out)
);

mux2 drmux
(
	.In0(3'b111),
	.In1(IR[11:9]),
	.S(drmux_sel),
	.Out(drmuxout)
);

mux2 sr1mux
(
	.In0(IR[11:9]),
	.In1(IR[8:6]),
	.S(sr1mux_sel),
	.Out(sr1muxout)
);

regfile register_file
(
	.clk,
	.LD_REG,
	.busout(bus_out),
	.drmuxout,
	.sr1muxout,
	.sr2(IR[2:0]),
	.sr2out,
	.sr1out
);

mux2 mdr_mux
(
	.S(mio_en),
	.In0(bus_out),
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

 
 zext mar_zext
 (
	.in(mar_out),
	.out(mem_address)
 );
 
bus bus1(.GateMDR(GateMDR), .GateMARMUX(GateMARMUX), .GatePC(GatePC), .GateALU(GateALU),
			.mem_wdata(mem_wdata), .pc_out(pc_out), .alu_out(alu_out), .marmux_out(),
			.out(bus_out));
 		
endmodule
 