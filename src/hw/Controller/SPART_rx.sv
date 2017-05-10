module SPART_rx(input clk,
		input rst_n,
		input enable,
		input iocs,
		input iorw,
		input rxd,
		input[1:0] ioaddr,
		output[7:0] rx_data,
		output reg rda);

reg shift, ready, start, busy;
reg[4:0] en_count;
reg[3:0] bit_count;
reg[7:0] rx_buffer;
reg[8:0] rx_shift_reg;

typedef enum reg[1:0] {IDLE, WAIT, SHIFT} state_t;
state_t state, nstate;

// infer state flops //
always_ff @(posedge clk, negedge rst_n) begin
	if (!rst_n)
		state <= IDLE;
	else
		state <= nstate;
end

// implement next state transition logic //
always_comb begin

	nstate = IDLE;
	ready = 0;
	start = 0;
	busy = 1;
	
	case (state)

		IDLE: begin
			if (!rxd) begin
				start = 1;
				nstate = WAIT;
			end
			else begin
				busy = 0;
				nstate = IDLE;
			end
		end

		WAIT: begin
			if (shift) begin
				nstate = SHIFT;
				ready = 0;
			end
			else begin
				nstate = WAIT;
				ready = 0;
			end
		end

		SHIFT: begin
			if (bit_count < 9) begin
				ready = 0;
				nstate = WAIT;
			end
			else begin
				ready = 1;
				nstate = IDLE;
			end
		end

	endcase

end


// enable counter //
always @(posedge clk, negedge rst_n) begin

	if (!rst_n)
		en_count <= 5'h00;
	else if (!ready && enable && busy)
		en_count <= en_count + 1;
	else if (/*!ready &&*/start || shift) // change back?
		en_count <= 5'h00;
	else
		en_count <= en_count;

end

// bit counter //
always @(posedge clk, negedge rst_n) begin

	if (!rst_n)
		bit_count <= 4'h0;
	else if (!ready && shift)
		bit_count <= bit_count + 1;
	else if (ready)
		bit_count <= 4'h0;
	else
		bit_count <= bit_count;

end

// shift register logic //
always @(posedge clk, negedge rst_n) begin
	if (!rst_n)
		rx_shift_reg <= 8'h00;
	else if (shift)
		rx_shift_reg <= {rxd, rx_shift_reg[8:1]};
	else
		rx_shift_reg <= rx_shift_reg;
end

// rx buffer logic //
assign rx_buffer = (ready) ? rx_shift_reg[7:0] : rx_buffer;

// shift signal logic //
always_comb begin
	if (bit_count == 0 && en_count == 24)
		shift = 1;
	else if (bit_count == 0 && en_count != 24)
		shift = 0;
	else if (en_count == 16)
		shift = 1;
	else
		shift = 0;
end

// rda signal logic //
always @(posedge clk, negedge rst_n) begin
	if (!rst_n)
		rda <= 0;
	else if (ready)
		rda <= 1;
	else if (iocs && iorw && ioaddr == 2'b00)
		rda <= 0;
	else
		rda <= rda;
end


assign rx_data = (rda && iorw && iocs && ioaddr == 2'b00) ? rx_buffer : 8'hzz;



endmodule
