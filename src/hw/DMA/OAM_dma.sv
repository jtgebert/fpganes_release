module OAM_dma(
	input clk, // CPU clock signal
	input rst_n, // global reset
	input [15:0] address_in, // DMA active low chip select
	inout [7:0] data, // Data that is read from CPU memory or sent from the CPU
	output reg cpu_ram_read,
	output reg ppu_oam_write,
	output reg cpu_stall,
	output reg [15:0] address_out // Drives the CPU address bus to select the PPU OAMDMA register
	);

	parameter OAMDMA_ADDR = 16'h4014;
	
	typedef enum reg [1:0] {
		IDLE, // Wait for a CPU command
		WAIT, // Wait for CPU writes to finish
		READ, // Read data from CPU memory
		WRITE // Write the CPU memory data to the PPU OAM
	} oam_dma_state;
	
	oam_dma_state dma_state;
	oam_dma_state nxt_dma_state;
	
	reg [7:0] dma_page, dma_page_d;
	reg [7:0] dma_byte, dma_byte_d;
	reg [7:0] cpu_mem_data, cpu_mem_data_d;
	reg [7:0] dma_data_out;
	
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			dma_state <= IDLE;
			dma_page <= 8'h00;
			dma_byte <= 8'h00;
			cpu_mem_data <= 8'h00;
		end
		else begin
			dma_state <= nxt_dma_state;
			dma_page <= dma_page_d;
			dma_byte <= dma_byte_d;
			cpu_mem_data <= cpu_mem_data_d;
		end
	end
	
	always_comb begin
	
		nxt_dma_state = dma_state;
		dma_page_d = dma_page;
		dma_byte_d = dma_byte;
		cpu_mem_data_d = cpu_mem_data;
		cpu_stall = 0;
		address_out = address_in;
		dma_data_out = 8'hzz;
		cpu_ram_read = 1'b0;
		ppu_oam_write = 1'b0;
		
		case(dma_state)
			IDLE: begin
				if (address_in == OAMDMA_ADDR) begin
					dma_page_d = data;
					dma_byte_d = 8'h00;
					nxt_dma_state = WAIT;
				end
			end
			WAIT: begin
				nxt_dma_state = READ;
			end
			READ: begin
				nxt_dma_state = WRITE;
				cpu_ram_read = 1;
				address_out = {dma_page, dma_byte};
				cpu_mem_data_d = data;
				cpu_stall = 1;
			end
			WRITE: begin
				if (dma_byte == 8'hff)
					nxt_dma_state = IDLE;
				else
					nxt_dma_state = READ;
				address_out = {16'h2004};
				ppu_oam_write = 1;
				dma_data_out = cpu_mem_data;
				dma_byte_d = dma_byte + 1;
				cpu_stall = 1;
			end
		endcase
		
	end
	
	assign data = dma_data_out;
	
endmodule