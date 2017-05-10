module fpganes_controller_test_tb();

	//////////// CLOCK //////////
	reg		          		CLOCK2_50;
	reg      	          		CLOCK3_50;
	reg 		          		CLOCK4_50;
	reg 		          		CLOCK_50;

	//////////// SEG7 //////////
	wire		     [6:0]		HEX0;
	wire		     [6:0]		HEX1;
	wire		     [6:0]		HEX2;
	wire		     [6:0]		HEX3;
	wire		     [6:0]		HEX4;
	wire		     [6:0]		HEX5;

	//////////// KEY //////////
	reg 		     [3:0]		KEY;

	//////////// LED //////////
	wire		     [9:0]		LEDR;

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	wire 		    [35:0]		GPIO;


fpganes_controller_test DUT(

	//////////// CLOCK //////////
	CLOCK2_50,
	CLOCK3_50,
	CLOCK4_50,
	CLOCK_50,

	//////////// SEG7 //////////
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,

	//////////// KEY //////////
	KEY,

	//////////// LED //////////
	LEDR,

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	GPIO
);

always
	#5 CLOCK_50 = ~CLOCK_50;

always
	#5 CLOCK2_50 = ~CLOCK2_50;

always
	#5 CLOCK3_50 = ~CLOCK3_50;

always
	#5 CLOCK4_50 = ~CLOCK4_50;

assign GPIO[5] = 0;

initial begin

	CLOCK_50 = 0;
	CLOCK2_50 = 0;
	CLOCK3_50 = 0;
	CLOCK4_50 = 0;

	KEY = 4'hF;

	repeat(20) @(negedge CLOCK_50);
	KEY = 4'hE;

end


endmodule
