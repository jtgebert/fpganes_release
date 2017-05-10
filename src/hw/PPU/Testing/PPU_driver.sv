module PPU_driver (
	input clk, // CPU clock
	input rst_n, // global reset
	input nmi, // PPU nmi out
	output reg [2:0] address, // address to ppu
	output reg [7:0] ppu_data,
	output reg ppu_rw,
	output reg ppu_cs
	);
	
	typedef enum reg[7:0] {
		IDLE,
		WRITE_FINE_X_SCROLL,
		WAIT_3,
		WRITE_SPR_Y_ADDR,
		WAIT_0,
		WRITE_SPR_Y,
		WAIT_1,
		WRITE_SPR_X_ADDR,
		WAIT_2,
		WRITE_SPR_X,
		WRITE_NEXT_BYTE,
		WAIT_4
	} driver_state;

	driver_state state, nxt_state;
	reg prev_nmi;
	reg [7:0] index, index_d;
	reg [7:0] spr_x[199:0];
	reg [7:0] spr_y[199:0];
	reg [7:0] fine_scroll, fine_scroll_d;
	
	initial begin
		$readmemh("I:/ECE554/fpganes/src/hw/PPU/spr_x.txt", spr_x);
		$readmemh("I:/ECE554/fpganes/src/hw/PPU/spr_y.txt", spr_y);
	end
	
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			state <= IDLE;
			prev_nmi <= 1'b0;
			index <= 0;
			fine_scroll = 0;
		end
		else begin
			state <= nxt_state;
			prev_nmi <= nmi;
			index <= index_d;
			fine_scroll = fine_scroll_d;
		end
	end
	
	always_comb begin
	
		nxt_state = IDLE;
		index_d = index;
		ppu_cs = 1;
		ppu_rw = 0;
		address = 3'hz;
		ppu_data = 8'hzz;
		fine_scroll_d = fine_scroll;
		
		case(state)
			IDLE: begin
				if (!prev_nmi && nmi)
					nxt_state = WRITE_FINE_X_SCROLL;
				else
					nxt_state = IDLE;
			end
			WRITE_FINE_X_SCROLL: begin
				fine_scroll_d = fine_scroll + 1;
				ppu_cs = 0;
				ppu_rw = 1;
				address = 3'h5;
				ppu_data = {fine_scroll[7:3], 3'b000};
				nxt_state = WAIT_4;
			end
			WAIT_4 : begin
				nxt_state = WRITE_NEXT_BYTE;
			end
			WRITE_NEXT_BYTE : begin
				ppu_cs = 0;
				ppu_rw = 1;
				address = 3'h5;
				ppu_data = 8'h00;
				nxt_state = WAIT_3;
			end
			WAIT_3: begin
				nxt_state = WRITE_SPR_Y_ADDR;
			end
			WRITE_SPR_Y_ADDR: begin
				ppu_cs = 0;
				ppu_rw = 1;
				address = 3'h3;
				ppu_data = 0;
				nxt_state = WAIT_0;
			end
			WAIT_0: begin
				nxt_state = WRITE_SPR_Y;
			end
			WRITE_SPR_Y: begin
				ppu_cs = 0;
				ppu_rw = 1;
				address = 3'h4;
				ppu_data = spr_y[index];
				nxt_state = WAIT_1;
			end
			WAIT_1: begin
				nxt_state = WRITE_SPR_X_ADDR;
			end
			WRITE_SPR_X_ADDR: begin
				ppu_cs = 0;
				ppu_rw = 1;
				address = 3'h3;
				ppu_data = 3;
				nxt_state = WAIT_2;
			end
			WAIT_2: begin
				nxt_state = WRITE_SPR_X;
			end
			WRITE_SPR_X: begin
				ppu_cs = 0;
				ppu_rw = 1;
				address = 3'h4;
				ppu_data = spr_x[index];
				nxt_state = IDLE;
				
				if (index < 199)
					index_d = index + 1;
				else
					index_d = 0;

			end
		endcase
	end

endmodule 