import Games::*;

module GameSelect(
		input rst_n,
		input [9:0] SW,
		output reg [3:0] game
	);

	
initial
	game = MARIO;
			
always @(negedge rst_n) begin
	if (SW == 10'b0000000001) begin// MARIO
		game = MARIO;
	end
	else if (SW == 10'b0000000010) begin // DK
		game = DONKEY_KONG;
	end
	else if (SW == 10'b0000000100) begin // PACMAN
		game = PACMAN;
	end
	else if (SW == 10'b0000001000) begin // GALAGA
		game = GALAGA;
	end
	else if (SW == 10'b0000010000) begin // DEFENDER 2
		game = DEFENDER2;
	end
	else if (SW == 10'b0000100000) begin // TENNIS
		game = TENNIS;
	end
	else if (SW == 10'b0001000000) begin // GOLF
		game = GOLF;
	end
	else if (SW == 10'b0010000000) begin // PINBALL
		game = PINBALL;
	end
	else begin
		game = game;
	end
end

endmodule