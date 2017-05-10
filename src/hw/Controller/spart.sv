module spart(
    input clk,
    input rst_n,
    input iocs,
    input iorw,
    output rda,
    output tbr,
    input [1:0] ioaddr,
    inout [7:0] databus,
    output txd,
    input rxd
    );

wire[7:0] bus_intf_data;
wire[7:0] rx_data;
wire enable;


SPART_rx rx(	.clk(clk),
		.rst_n(rst_n),
		.enable(enable),
		.iocs(iocs),
		.iorw(iorw),
		.rxd(rxd),
		.ioaddr(ioaddr),
		.rx_data(rx_data),
		.rda(rda));

SPART_tx tx(	.clk(clk),
		.rst_n(rst_n),
		.enable(enable),
		.tx_data(bus_intf_data),
		.iorw(iorw),
		.iocs(iocs),
		.ioaddr(ioaddr),
		.tbr(tbr),
		.tx(txd));

baud_rate_gen baud(
		.clk(clk),
		.rst_n(rst_n),
		.en(enable));

bus_intf bus(	.DATABUS(databus),
		.rb_data(rx_data),
		.IOADDR(ioaddr),
		.rda(rda),
		.tbr(tbr),
		.IORW(iorw),
		.rst_n(rst_n),
		.IOCS(iocs),
		.bus_intf_data(bus_intf_data));





endmodule
