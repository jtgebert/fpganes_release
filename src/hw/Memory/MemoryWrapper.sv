import Games::*;

module MemoryWrapper(	
			input clk,
			input rst_n,
			input [9:0] SW,
			input cs, // active low
			input rd,
			input wr,
			input [15:0] addr,
			inout [7:0] databus,
			input [3:0] game,
		// test
			output [13:0] ram_addr_peek
			
			);
			
wire [10:0] ram_addr;
wire [14:0] rom_addr;
wire [7:0] q_rom, q_ram, q, q_rom_mario, q_rom_dk, q_rom_pm, q_rom_galaga, q_rom_d2, q_rom_tennis, q_rom_golf, q_rom_pb;
wire ram_cs, rom_cs;
wire rom_rd, ram_rd, ram_wr;

assign ram_addr_peek = ram_addr;


assign ram_cs = (!cs & (addr < 16'h2000)) ? 1'b0 : 1'b1;
assign rom_cs = (!cs & (addr >= 16'h8000)) ? 1'b0 : 1'b1;
assign ram_addr = addr[10:0];
assign rom_addr = addr[14:0];
assign ram_rd = !ram_cs ? rd : 0;
assign ram_wr = !ram_cs ? wr : 0;
assign rom_rd = !rom_cs ? rd : 0;
assign q = (!rom_cs) ? q_rom : q_ram;
assign databus = (rd & !cs) ? q : 8'hzz;

assign q_rom = (game == MARIO) ? q_rom_mario : 
					(game == DONKEY_KONG) ? q_rom_dk :
					(game == PACMAN) ? q_rom_pm :
					(game == GALAGA) ? q_rom_galaga :
					(game == DEFENDER2) ? q_rom_d2 :
					(game == TENNIS) ? q_rom_tennis :
					(game == GOLF) ? q_rom_golf :
					(game == PINBALL) ? q_rom_pb :
					8'hEA; // NOP


MarioProgramRom	mario_rom(.address ( rom_addr ),
				.clock ( clk ),
				.rden ( rom_rd ),
				.q ( q_rom_mario )
				);

DonkeyKongProgramRom dk_rom(.address ( rom_addr[13:0] ),
				.clock ( clk ),
				.rden ( rom_rd ),
				.q ( q_rom_dk )
				);
				
MsPacManProgramRom pm_rom(.address ( rom_addr ),
				.clock ( clk ),
				.rden ( rom_rd ),
				.q ( q_rom_pm )
				);
				
GalagaProgramRom galaga_rom(.address ( rom_addr ),
				.clock ( clk ),
				.rden ( rom_rd ),
				.q ( q_rom_galaga )
				);
				
Defender2ProgramRom d2_rom(.address ( rom_addr[13:0] ),
				.clock ( clk ),
				.rden ( rom_rd ),
				.q ( q_rom_d2 )
				);
				
TennisProgramRom tennis_rom(.address ( rom_addr[13:0] ),
				.clock ( clk ),
				.rden ( rom_rd ),
				.q ( q_rom_tennis )
				);
				
GolfProgramRom golf_rom(.address ( rom_addr[13:0] ),
				.clock ( clk ),
				.rden ( rom_rd ),
				.q ( q_rom_golf )
				);
				
PinballProgramRom pb_rom(.address ( rom_addr[13:0] ),
				.clock ( clk ),
				.rden ( rom_rd ),
				.q ( q_rom_pb )
				);		
				
ProgramRam	ProgramRam_inst(.address ( ram_addr ),
				.clock ( clk ),
				.data ( databus ),
				.rden ( ram_rd ),
				.wren ( ram_wr ),
				.q ( q_ram )
				);

endmodule
