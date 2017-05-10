localparam IRQ_H = 16'hFFFF;
localparam IRQ_L = 16'hFFFE;

localparam RESET_H= 16'hFFFD;
localparam RESET_L = 16'hFFFC;

localparam NMI_H = 16'hFFFB;
localparam NMI_L = 16'hFFFA;

typedef enum {
	C = 0,
	Z = 1,
	I = 2,
	D = 3,
	B = 4,
	U = 5,
	V = 6,
	N = 7
} STATUS;