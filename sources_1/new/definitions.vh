// Screen dimmensions
`define WIDTH 96
`define HEIGHT 64
// Colors
`define BLACK 16'b0
`define WHITE ~`BLACK
`define MAGENTA 16'b11111_000000_11111
`define CYAN 16'b00000_111111_11111
`define YELLOW 16'b11111_111111_00000
`define GREEN 16'b00000_111111_00000
`define RED 16'b11111_000000_00000
`define BLUE 16'b00000_000000_11111
`define ORANGE 16'b11111_100110_00000
`define GREY 16'b01100_011000_01100

// Bit numbers for various
`define LDBIT       15
`define OLEDBIT     15
`define ANBIT       3
`define SEGDPBIT    7 //with dp
`define SEGBIT      6 //without dp
`define COLBIT      15 //colour
`define PIXELBIT    12 // Pixel_index from oled_display
`define PIXELXYBIT  6
// To clear AN/SEG
`define CLR_AN  ~4'b0
`define CLR_SEG ~8'b0 

// 7SEG DIGITS
`define DIG0    7'b1000000
`define DIG1    7'b1111001
`define DIG2    7'b0100100
`define DIG3    7'b0110000
`define DIG4    7'b0011001
`define DIG5    7'b0010010
`define DIG6    7'b0000010
`define DIG7    7'b1111000
`define DIG8    7'b0
`define DIG9    7'b0010000   