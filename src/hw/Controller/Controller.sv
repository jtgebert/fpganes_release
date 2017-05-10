module Controller(
			input clk,
			input rst_n,
			input cs,
			input rw,
			inout [7:0] cpubus,
			input rxd,
			output txd,
			output [7:0] rx_data_peek,
			// for testing
			input send_cpu_states,
			input [63:0] cpuram_q,
			input [13:0] cpuram_wr_addr,
			output [13:0] cpuram_rd_addr,
			output cpuram_rd,
			output writing
			);

  wire iocs, iorw, rda, tbr;
  wire[1:0] ioaddr;
  wire[7:0] databus;
  wire[7:0] peek;

  assign rx_data_peek = peek;

  spart spart0(   .clk(clk),
                  .rst_n(rst_n),
                  .iocs(iocs),
                  .iorw(iorw),
                  .rda(rda),
                  .tbr(tbr),
                  .ioaddr(ioaddr),
                  .databus(databus),
                  .txd(txd),
                  .rxd(rxd)
              );

  driver driver0( .clk(clk),
                  .rst_n(rst_n),
                  .cs(cs),
                  .rw(rw),
                  .iocs(iocs),
                  .iorw(iorw),
                  .rda(rda),
                  .tbr(tbr),
                  .ioaddr(ioaddr),
                  .databus(databus),
                  .cpubus(cpubus),
									// for testing
		  						.rx_data_peek(peek),
									.send_cpu_states(send_cpu_states),
									.cpuram_q(cpuram_q),
									.cpuram_rd_addr(cpuram_rd_addr),
									.cpuram_rd(cpuram_rd),
									.writing(writing),
									.cpuram_wr_addr( cpuram_wr_addr )
              );

endmodule
