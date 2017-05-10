module ControllersWrapper(
			input clk,
			input rst_n,
			input cs,
			input rw,
			input addr,
			inout [7:0] cpubus,
			input rxd1,
			input rxd2,
			output txd1,
			output txd2,
			output [7:0] rx_data_peek,
			// for testing
			input send_cpu_states,
			input [63:0] cpuram_q,
			input [13:0] cpuram_wr_addr,
			output [13:0] cpuram_rd_addr,
			output cpuram_rd,
			output writing
			);

wire [7:0] rx_data_peek1, rx_data_peek2;
assign rx_data_peek = rx_data_peek1 | rx_data_peek2;
wire controller1_cs_n, controller2_cs_n;
assign controller1_cs_n = addr | cs;
assign controller2_cs_n = rw ? (~addr | cs) : (cs | addr);

Controller ctrl1(
	// output
	.txd( txd1 ), .rx_data_peek( rx_data_peek1 ),

	// input
	.clk( clk ), .rst_n( rst_n ),
	.cs( controller1_cs_n ), .rw( rw ), .rxd( rxd1 ),

	// inout
	.cpubus( cpubus )

	// testing
	//.send_cpu_states(send_cpu_states), .cpuram_q(cpuram_q), .writing(writing),
	//.cpuram_addr(cpuram_rd_addr), .cpuram_rd(cpuram_rd), .cpuram_wr_addr( cpuram_wr_addr )
);

Controller ctrl2(
  // output
  .txd( txd2 ), .rx_data_peek( rx_data_peek2 ),

  // input
  .clk( clk ), .rst_n( rst_n ),
  .cs( controller2_cs_n ), .rw( rw ), .rxd( rxd2 ),

  // inout
  .cpubus( cpubus )
);

endmodule
