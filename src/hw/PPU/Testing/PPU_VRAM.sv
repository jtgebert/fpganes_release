/*
 * This is the PPU VRAM interface. This module instantiates an ALTERA 1-port RAM IP core, and then creates
 * the create timing for the PPU spec.
 *
 * Eric Sullivan
 * ECE 554
 * UW-Madison Spring 2017
 */

module PPU_VRAM (
    input clk, // PPU system clock
    input rst_n, // active low reset signal
    input [10:0] vram_addr, // Address from VRAM to read to or write from
    input [7:0] vram_data_in, // The data to write to VRAM
    input vram_en, // The VRAM enable signal
    input vram_rw, // Selects if the current op is a read or write
    output [7:0] vram_data_out // The data that was read from VRAM on a read
	);

	wire [7:0] vram_q;
	
	VRAM vram(
		.address(vram_addr),
		.clock(clk),
		.data(vram_data_in),
		.wren(vram_rw),
		.q(vram_q)
	);
	
	assign vram_data_out = (vram_en && rst_n) ? vram_q : 8'h00;

endmodule