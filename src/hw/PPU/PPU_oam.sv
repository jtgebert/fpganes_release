module PPU_oam(
	input clk,
	input rst_n,
	input oam_en,
	input oam_rw,
	input [5:0] spr_select,
	input [1:0] byte_select,
	input [7:0] data_in,
	output reg [7:0] data_out
	);

	integer i;
	
	// The OAM is a memory that consists of 256 bytes
	// each object requires 4 bytes in OAM
	// Byte 0: Sprite Y position
	// Byte 1: Tile index number 
	// Byte 2: [2:0] - palette select, [5] - priority
	// Byte 3: Sprite X position
	reg [7:0] OAM [255:0];
	
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			for (i = 0; i < 256; i = i + 1)
				OAM[i] <= 8'h00;
			data_out <= 8'hzz;
		end
		else begin
			if (oam_en) begin
				if (oam_rw) begin
					data_out <= OAM[{spr_select, byte_select}];
				end
				else begin
					data_out <= 8'hzz;
					OAM[{spr_select, byte_select}] <= data_in;
				end
			end
			else
				data_out <= 8'hzz;
		end
	end
	
endmodule