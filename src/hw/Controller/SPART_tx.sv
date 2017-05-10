module SPART_tx(
	input clk,
	input rst_n,
	input enable,
	input [7:0] tx_data,
	input iorw,
	input iocs,
	input [1:0] ioaddr,
	output reg tbr,
	output tx
	);
	
	// State Names
	typedef enum reg[1:0] {
		IDLE, // ready to transmit new data
		TRANSMITTING, // currently transmiting the byte in tx_buffer 
		SHIFT // place the next bit of tx_buffer on the tx line
	} state_t;
	
	// Internal Registers
	reg [4:0] en_count;
	reg [9:0] tx_buffer;
	reg [3:0] bit_cnt;
	reg load;
	reg shift;
	state_t state;
	state_t nxt_state;
	
	// tx shift register loads a new value on IOCS = 1 and IORW = 0
	// otherwise maintain the same value
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n)
			tx_buffer <= {1'b1, 8'h00, 1'b0};
		else if (load)
			tx_buffer <= {1'b1, tx_data, 1'b0};
		else if (shift)
			tx_buffer <= tx_buffer >> 1;
		else 
			tx_buffer <= tx_buffer;
	end
	
	// if the transmitter is busy that means tx_buffer should be driving the tx line
	assign tx = state == IDLE ? 1'b1 : tx_buffer[0];
	
	// enable count logic shifts out a new bit on first enable
	// and every 16th enable after that
	always @(posedge clk, negedge rst_n) begin
		if(!rst_n)
			en_count <= 4'h0;
		else if (enable && !tbr)
			en_count <= en_count + 1;
		else if (shift && !tbr)
			en_count <= 0;
		else
			en_count <= en_count;
	end
	
	// shift a new value onto the tx line every 16th enable
	assign shift = en_count == 16 ? 1 : 0;
	
	// bit count logic
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n)
			bit_cnt <= 4'h0;
		else if (shift && !tbr)
			bit_cnt <= bit_cnt + 1;
		else if (load)
			bit_cnt <= 0;
		else
			bit_cnt <= bit_cnt;
	end
	
	// State Register
	always_ff @(posedge clk, negedge rst_n) begin
		if(!rst_n) 
			state <= IDLE;
		else
			state <= nxt_state;
	end
	
	// Next state logic
	always_comb begin
		nxt_state = IDLE;
		load = 1'b0;
		tbr = 1'b1;
		case (state)
			IDLE: begin
				if (iocs && !iorw && ioaddr == 2'b0_0) begin
					tbr = 1'b0;
					load = 1'b1;
					nxt_state = TRANSMITTING;
				end
				else begin
					tbr = 1'b1;
					nxt_state = IDLE;
				end
			end
			
			TRANSMITTING: begin
				tbr = 0;
				if (shift) begin
					nxt_state <= SHIFT;
				end
				else begin
					nxt_state <= TRANSMITTING;
				end
			end
			
			SHIFT: begin
				if (bit_cnt < 10) begin
					tbr = 0;
					nxt_state = TRANSMITTING;
				end
				else begin
					nxt_state = IDLE;
				end
			end
		endcase
	end
	
endmodule