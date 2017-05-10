module bus_intf(inout[7:0] DATABUS,
		input[7:0] rb_data,
		input[1:0] IOADDR,
		input rda,
		input tbr,
		input IORW,
		input rst_n,
		input IOCS,
		output[7:0] bus_intf_data);

wire[7:0] out;

localparam TRANS_RECEIVE_COMMAND = 2'b00;
localparam SR_COMMAND = 2'b01;

assign out = (IOADDR[0]) ? {4'h0, rda, tbr} : rb_data;
assign DATABUS = (IOCS & IORW) ? out : 8'hzz;
assign bus_intf_data = DATABUS;
	
endmodule
