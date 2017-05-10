import Games::*;

module PPUMemoryWrapper(input clk,
								input rst_n,
								input [3:0] game,
								input [13:0] addr,
								input [7:0] data,
								input rw,
								output [7:0] q);

wire [12:0] rom_addr;
wire [10:0] ram_addr;
wire [7:0] rom_q, ram_q, mario_rom_q, dk_rom_q, pm_rom_q, galaga_rom_q, d2_rom_q, tennis_rom_q, golf_rom_q, pb_rom_q;
wire ram_en, rom_en;

reg prev_rom_en;
reg prev_ram_en;

assign ram_en = addr[13];
assign rom_en = ~addr[13];

assign rom_addr = addr[12:0];
assign ram_addr = (game == MARIO ||  
						 game == DONKEY_KONG || 
						 game == DEFENDER2 || 
						 game == GOLF || 
						 game == TENNIS || 
						 game == PACMAN) ? addr[10:0] : {addr[11], addr[9:0]}; // vertical or horizontal mirroring?

assign q = prev_ram_en ? ram_q : prev_rom_en ? rom_q : 8'hzz;
assign rom_q = (game == MARIO) ? mario_rom_q :
					(game == DONKEY_KONG) ? dk_rom_q :
					(game == PACMAN) ? pm_rom_q :
					(game == GALAGA) ? galaga_rom_q :
					(game == DEFENDER2) ? d2_rom_q :
					(game == TENNIS) ? tennis_rom_q :
					(game == GOLF) ? golf_rom_q :
					(game == PINBALL) ? pb_rom_q :
					8'h00;
					
		
always @(posedge clk, negedge rst_n) begin
	if (!rst_n) begin
		prev_rom_en <= 1'b0;
		prev_ram_en <= 1'b0;
	end
	else begin
		prev_rom_en <= rom_en;
		prev_ram_en <= ram_en;
	end
end

		
MarioCharacterRom mario_rom(
	.address(rom_addr),
	.clock(clk),
	.rden(~rw),
	.q(mario_rom_q));
	
DonkeyKongCharacterRom dk_rom(
	.address(rom_addr),
	.clock(clk),
	.rden(~rw),
	.q(dk_rom_q));
	
MsPacManCharacterRom pm_rom(
	.address(rom_addr),
	.clock(clk),
	.rden(~rw),
	.q(pm_rom_q));
	
GalagaCharacterRom galaga_rom(
	.address(rom_addr),
	.clock(clk),
	.rden(~rw),
	.q(galaga_rom_q));
	
Defender2CharacterRom d2_rom(
	.address(rom_addr),
	.clock(clk),
	.rden(~rw),
	.q(d2_rom_q));
	
TennisCharacterRom tennis_rom(
	.address(rom_addr),
	.clock(clk),
	.rden(~rw),
	.q(tennis_rom_q));
	
GolfCharacterRom golf_rom(
	.address(rom_addr),
	.clock(clk),
	.rden(~rw),
	.q(golf_rom_q));

PinballCharacterRom pb_rom(
	.address(rom_addr),
	.clock(clk),
	.rden(~rw),
	.q(pb_rom_q));
	
OthelloCharacterRom othello_rom(
	.address(rom_addr),
	.clock(clk),
	.rden(~rw),
	.q(othello_rom_q));
	
PPUVram vram(
	.address(ram_addr),
	.clock(clk),
	.data(data),
	.rden(~rw),
	.wren(rw),
	.q(ram_q));

endmodule