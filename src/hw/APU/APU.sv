/*
//////////////////// ACTUAL FORMULA ////////////////////
output = pulse_out + tnd_out

                            95.88
pulse_out = ------------------------------------
             (8128 / (pulse1 + pulse2)) + 100

                                       159.79
tnd_out = -------------------------------------------------------------
                                    1
           ----------------------------------------------------- + 100
            (triangle / 8227) + (noise / 12241) + (dmc / 22638)

//////////////////// LINEAR APPROXIMATION ////////////////////
output = pulse_out + tnd_out

pulse_out = 0.00752 * (pulse1 + pulse2)

tnd_out = 0.00851 * triangle + 0.00494 * noise + 0.00335 * dmc

//////////////////// LOOKUP TABLE ////////////////////
31 entry table for pulse, 203 for other
output = pulse_out + tnd_out

pulse_table [n] = 95.52 / (8128.0 / n + 100)

pulse_out = pulse_table [pulse1 + pulse2]

tnd_table [n] = 163.67 / (24329.0 / n + 100)

tnd_out = tnd_table [3 * triangle + 2 * noise + dmc]
*/


module APU (
	input clk, // APU system clock
	input rst_n, // active low reset
	inout [7:0] data, // line for APU->CPU and APU->PPU data
	input [4:0] address, // PPU register select
	input rw, // APU register read/write toggle
	input cs_in // APU chip select
	);

	parameter READ = 0;
	parameter WRITE = 1;

	reg [7:0] PULSE_1_REG_0, PULSE_1_REG_0_D;
	reg [7:0] PULSE_1_REG_1, PULSE_1_REG_1_D;
	reg [7:0] PULSE_1_REG_2, PULSE_1_REG_2_D;
	reg [7:0] PULSE_1_REG_3, PULSE_1_REG_3_D;

	reg [7:0] PULSE_2_REG_0, PULSE_2_REG_0_D;
	reg [7:0] PULSE_2_REG_1, PULSE_2_REG_1_D;
	reg [7:0] PULSE_2_REG_2, PULSE_2_REG_2_D;
	reg [7:0] PULSE_2_REG_3, PULSE_2_REG_3_D;

	reg [7:0] TRIANGLE_REG_0, TRIANGLE_REG_0_D;
	reg [7:0] TRIANGLE_REG_1, TRIANGLE_REG_1_D;
	reg [7:0] TRIANGLE_REG_2, TRIANGLE_REG_2_D;
	reg [7:0] TRIANGLE_REG_3, TRIANGLE_REG_3_D;

	reg [7:0] NOISE_REG_0, NOISE_REG_0_D;
	reg [7:0] NOISE_REG_1, NOISE_REG_1_D;
	reg [7:0] NOISE_REG_2, NOISE_REG_2_D;
	reg [7:0] NOISE_REG_3, NOISE_REG_3_D;

	reg [7:0] DMC_REG_0, DMC_REG_0_D;
	reg [7:0] DMC_REG_1, DMC_REG_1_D;
	reg [7:0] DMC_REG_2, DMC_REG_2_D;
	reg [7:0] DMC_REG_3, DMC_REG_3_D;

	reg [7:0] APU_STATUS, APU_STATUS_D;
	reg [7:0] APU_FRAME_COUNT, APU_FRAME_COUNT_D;

	reg [7:0] data_out;

	// enables for each channel
	/* setting dmc will restart if bytes remaining is 0
		 clearing dmc will set bytes remaining to 0 and dmc will finish when emptied
		 clearing any other reg will immediately set their length counter to 0
	*/
	reg dmc_en, n_en, tri_en, sq1_en, sq2_en;


	always_ff @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			PULSE_1_REG_0 <= 8'h00;
			PULSE_1_REG_1 <= 8'h00;
			PULSE_1_REG_2 <= 8'h00;
			PULSE_1_REG_3 <= 8'h00;

			PULSE_2_REG_0 <= 8'h00;
			PULSE_2_REG_1 <= 8'h00;
			PULSE_2_REG_2 <= 8'h00;
			PULSE_2_REG_3 <= 8'h00;

			TRIANGLE_REG_0 <= 8'h00;
			TRIANGLE_REG_1 <= 8'h00;
			TRIANGLE_REG_2 <= 8'h00;
			TRIANGLE_REG_3 <= 8'h00;

			NOISE_REG_0 <= 8'h00;
			NOISE_REG_1 <= 8'h00;
			NOISE_REG_2 <= 8'h00;
			NOISE_REG_3 <= 8'h00;

			DMC_REG_0 <= 8'h00;
			DMC_REG_1 <= 8'h00;
			DMC_REG_2 <= 8'h00;
			DMC_REG_3 <= 8'h00;

			APU_STATUS <= 8'h00;
			APU_FRAME_COUNT <= 8'h00;
		end
		else begin
			PULSE_1_REG_0 <= PULSE_1_REG_0_D;
			PULSE_1_REG_1 <= PULSE_1_REG_1_D;
			PULSE_1_REG_2 <= PULSE_1_REG_2_D;
			PULSE_1_REG_3 <= PULSE_1_REG_3_D;

			PULSE_2_REG_0 <= PULSE_2_REG_0_D;
			PULSE_2_REG_1 <= PULSE_2_REG_1_D;
			PULSE_2_REG_2 <= PULSE_2_REG_2_D;
			PULSE_2_REG_3 <= PULSE_2_REG_3_D;

			TRIANGLE_REG_0 <= TRIANGLE_REG_0_D;
			TRIANGLE_REG_1 <= TRIANGLE_REG_1_D;
			TRIANGLE_REG_2 <= TRIANGLE_REG_2_D;
			TRIANGLE_REG_3 <= TRIANGLE_REG_3_D;

			NOISE_REG_0 <= NOISE_REG_0_D;
			NOISE_REG_1 <= NOISE_REG_1_D;
			NOISE_REG_2 <= NOISE_REG_2_D;
			NOISE_REG_3 <= NOISE_REG_3_D;

			DMC_REG_0 <= DMC_REG_0_D;
			DMC_REG_1 <= DMC_REG_0_D;
			DMC_REG_2 <= DMC_REG_0_D;
			DMC_REG_3 <= DMC_REG_0_D;

			APU_STATUS <= APU_STATUS_D;
			APU_FRAME_COUNT <= APU_FRAME_COUNT_D;
		end
	end

	always_comb begin
		PULSE_1_REG_0_D = PULSE_1_REG_0;
		PULSE_1_REG_1_D = PULSE_1_REG_1;
		PULSE_1_REG_2_D = PULSE_1_REG_2;
		PULSE_1_REG_3_D = PULSE_1_REG_3;

		PULSE_2_REG_0_D = PULSE_2_REG_0;
		PULSE_2_REG_1_D = PULSE_2_REG_1;
		PULSE_2_REG_2_D = PULSE_2_REG_2;
		PULSE_2_REG_3_D = PULSE_2_REG_3;

		TRIANGLE_REG_0_D = TRIANGLE_REG_0;
		TRIANGLE_REG_1_D = TRIANGLE_REG_1;
		TRIANGLE_REG_2_D = TRIANGLE_REG_2;
		TRIANGLE_REG_3_D = TRIANGLE_REG_3;

		NOISE_REG_0_D = NOISE_REG_0;
		NOISE_REG_1_D = NOISE_REG_1;
		NOISE_REG_2_D = NOISE_REG_2;
		NOISE_REG_3_D = NOISE_REG_3;

		DMC_REG_0_D = DMC_REG_0;
		DMC_REG_1_D = DMC_REG_0;
		DMC_REG_2_D = DMC_REG_0;
		DMC_REG_3_D = DMC_REG_0;

		APU_STATUS_D = APU_STATUS;
		APU_FRAME_COUNT_D = APU_FRAME_COUNT;

		data_out = 8'h00;

		if (!cs_in) begin
			if (rw == WRITE) begin
				case(address)
					8'h00: PULSE_1_REG_0_D = data;
					8'h01: PULSE_1_REG_1_D = data;
					8'h02: PULSE_1_REG_2_D = data;
					8'h03: PULSE_1_REG_3_D = data;
					8'h04: PULSE_2_REG_0_D = data;
					8'h05: PULSE_2_REG_1_D = data;
					8'h06: PULSE_2_REG_2_D = data;
					8'h07: PULSE_2_REG_3_D = data;
					8'h08: TRIANGLE_REG_0_D = data;
					8'h09: TRIANGLE_REG_1_D = data;
					8'h0a: TRIANGLE_REG_2_D = data;
					8'h0b: TRIANGLE_REG_3_D = data;
					8'h0c: NOISE_REG_0_D = data;
					8'h0d: NOISE_REG_1_D = data;
					8'h0e: NOISE_REG_2_D = data;
					8'h0f: NOISE_REG_3_D = data;
					8'h10: DMC_REG_0_D = data;
					8'h11: DMC_REG_1_D = data;
					8'h12: DMC_REG_2_D = data;
					8'h13: DMC_REG_3_D = data;
					8'h15: APU_STATUS_D = data; /* begin
						APU_STATUS_D = data;
						dmc_en = data[4];
						n_en = data[3];
						tri_en = data[2];
						sq2_en = data[1];
						sq1_en = data[0];
						// should clear dmc interrupt too
					end */
					8'h17: APU_FRAME_COUNT_D = data;
					default: begin end
				endcase
			end
			else begin
				case(address)
					8'h00: data_out = PULSE_1_REG_0;
					8'h01: data_out = PULSE_1_REG_1;
					8'h02: data_out = PULSE_1_REG_2;
					8'h03: data_out = PULSE_1_REG_3;
					8'h04: data_out = PULSE_2_REG_0;
					8'h05: data_out = PULSE_2_REG_1;
					8'h06: data_out = PULSE_2_REG_2;
					8'h07: data_out = PULSE_2_REG_3;
					8'h08: data_out = TRIANGLE_REG_0;
					8'h09: data_out = TRIANGLE_REG_1;
					8'h0a: data_out = TRIANGLE_REG_2;
					8'h0b: data_out = TRIANGLE_REG_3;
					8'h0c: data_out = NOISE_REG_0;
					8'h0d: data_out = NOISE_REG_1;
					8'h0e: data_out = NOISE_REG_2;
					8'h0f: data_out = NOISE_REG_3;
					8'h10: data_out = DMC_REG_0;
					8'h11: data_out = DMC_REG_1;
					8'h12: data_out = DMC_REG_2;
					8'h13: data_out = DMC_REG_3;
					8'h15: data_out = APU_STATUS; // {dmc_interrupt, frame_interrupt, 1'b0, dmc_active, n_active, tri_active, sq2_active, sq1_active};
					8'h17: data_out = 8'h00;
					default: begin end
				endcase
			end
		end
	end

	assign data = (rw == READ && !cs_in) ? (data_out) : 8'hzz;

endmodule
