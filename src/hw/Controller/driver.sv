module driver(
    input clk,
    input rst_n,
    input cs,
    input rw, // low for writes
    output reg iocs,
    output reg iorw,
    input rda,
    input tbr,
    output reg [1:0] ioaddr,
    inout reg [7:0] databus,
    inout reg [7:0] cpubus,
    // for testing
	 input[ 13:0 ] cpuram_wr_addr,
    output [7:0] rx_data_peek,
    input send_cpu_states,
    input [63:0] cpuram_q,
    output reg [13:0] cpuram_rd_addr,
    output cpuram_rd,
    output reg writing
    );

	typedef enum reg[2:0] {
		START, // Restart state
		READY, // Driver is ready to accept input from the uart
		READ, // Read received data
    // For Testing
		WRITE, // Write CPU state
    WRITING
	} state_t;

	reg load_data, shift, strobe;
	wire button_val;
	reg [7:0] data_out;
	reg [7:0] rx_data, button_states;
	state_t state;
	state_t nxt_state;

  // for Testing
  reg cpuram_bytewrote, last_byte;
  wire [7:0] cpuram_databyte;
  reg [2:0] byte_count;

  // read from ram and keep track of data byte
  always @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
      last_byte <= 0;
      cpuram_rd_addr <= 14'h0000;
      byte_count <= 0;
    end
	 else if( writing ) begin
		if (cpuram_bytewrote) begin
			if (byte_count == 3'b111) begin
				if (cpuram_rd_addr == cpuram_wr_addr) begin
				 last_byte <= 1;
				end
				else begin
				 last_byte <= 0;
				end

				cpuram_rd_addr <= cpuram_rd_addr - 1;
			end
			else
				cpuram_rd_addr <= cpuram_rd_addr;

			byte_count <= byte_count + 1;
		end
	 end
	 else if (send_cpu_states) begin
		cpuram_rd_addr <= cpuram_wr_addr - 1;
	 end
  end

  assign cpuram_rd = writing;
  assign cpuram_databyte = (byte_count == 3'b000) ? cpuram_q[7:0] :
                           (byte_count == 3'b001) ? cpuram_q[15:8] :
                           (byte_count == 3'b010) ? cpuram_q[23:16] :
                           (byte_count == 3'b011) ? cpuram_q[31:24] :
                           (byte_count == 3'b100) ? cpuram_q[39:32] :
                           (byte_count == 3'b101) ? cpuram_q[47:40] :
                           (byte_count == 3'b110) ? cpuram_q[55:48] :
                           cpuram_q[63:56];

	assign rx_data_peek = rx_data;

	// rx_data register
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n)
			rx_data <= 8'h00;
		else if (load_data)
			rx_data <= databus;
		else
			rx_data <= rx_data;
	end

  assign shift = (rw & !cs) ? 1 : 0;

  // strobe register
  always @(posedge clk, negedge rst_n) begin
    if (!rst_n)
      strobe <= 1'b0;
    else if (!rw && !cs)
      strobe <= cpubus[0];
    else
      strobe <= strobe;
  end

  // button_states register
  always @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
      button_states <= 8'h00;
    end
    else if (strobe) begin
      button_states <= rx_data;
    end
    else if (shift) begin
      button_states <= {1'b0, button_states[7:1]};
    end
    else begin
      button_states <= button_states;
    end
  end

  assign button_val = (shift) ? button_states[0] : 1'b0;

  assign cpubus = (shift) ? {7'h00, button_val} : 8'hzz;
	//assign cpubus = (shift /* && !strobe */ ) ? {7'h00, button_val} : (!cs2) ? 8'h00 : 8'hzz;
	
	// Current state register
	always @(posedge clk, negedge rst_n) begin
		if (!rst_n)
			state <= START;
		else
			state <= nxt_state;
	end

	// State machine logic
	always_comb begin
		// init default values
		ioaddr = 2'b00;
		iorw = 1;
		iocs = 0;
		load_data = 0;
		data_out = 8'hzz;
    cpuram_bytewrote = 0;
    writing = 0;

		case(state)
		START: begin
      if (send_cpu_states)
        nxt_state = WRITE;
      else
			   nxt_state = READY;
		end
    // wait for input from spart
		READY: begin
			iocs = 1;
			iorw = 1;
			ioaddr = 2'b01;
      if ( send_cpu_states)
        nxt_state = WRITE;
			// check if new data ready
			else if (databus[1] == 1)
				nxt_state = READ;
      else
				nxt_state = READY;
		end
    // read spart input
		READ: begin
			iocs = 1;
			iorw = 1;
			ioaddr = 2'b00;
			load_data = 1;
      if (send_cpu_states)
        nxt_state = WRITE;
      else
			   nxt_state = READY;
		end
    // for testing
    WRITE: begin
      iocs = 1;
      iorw = 1;
      ioaddr = 2'b01;
      writing = 1;
      if (last_byte)
        nxt_state = READY;
      else if (databus[0] == 1)
        nxt_state = WRITING;
      else
        nxt_state = WRITE;
    end
    // for testing
    WRITING: begin
      writing = 1;
      iocs = 1;
      iorw = 0;
      ioaddr = 2'b00;
      data_out = cpuram_databyte;
      cpuram_bytewrote = 1;
      nxt_state = WRITE;
    end
		default:
			nxt_state = START;
		endcase
	end

	// Only drive databus when a write op is happening
	assign databus = iorw == 1 ? 8'hzz : data_out;

endmodule
