`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:36:16 01/22/2016 
// Design Name: 
// Module Name:    alu_6502_tb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`define SUMS		5'b10000
`define ORS			5'b01000
`define XORS		5'b00100
`define ANDS		5'b00010
`define SRS			5'b00001
module alu_6502_tb(
    );
	
	reg [7:0] a;
	reg [7:0] b;
	reg [4:0] ctrl;
	
	wire [7:0] out;
	wire v;
	
	// Test bench
	initial begin
	// ADDITION
	// Regular addition: 100 + 11 = 111
		a <= 8'b01100100; // 100
		b <= 8'b00001011; // 11
		ctrl <= `SUMS;
		#10
	// Regular subtraction: 99 - 88 = 11
		a <= 8'b01100011; // 99
		b <= 8'b10101000; // -88
		ctrl <= `SUMS;
		#10
	// Overflow: 70 + 60 = -126
		a <= 8'b01000110; // 70
		b <= 8'b00111100; // 60
		ctrl <= `SUMS;
		#10
	// Underflow: -60 - 70 = 126
		a <= 8'b11000100; // -60
		b <= 8'b10111010; // -70
		ctrl <= `SUMS;
		#10
		
	// LOGICAL OR
	// 0xAA | 0x55 = 0xFF
		a <= 8'b10101010; // 0xAA
		b <= 8'b01010101; // 0x55
		ctrl <= `ORS;
		#10
	// 0x75 | 0xC2 = 0xF7
		a <= 8'b01110101; // 0x75
		b <= 8'b11000010; // 0xC2
		ctrl <= `ORS;
		#10
		
	// LOGICAL XOR
	// 0xAA ^ 0x55 = 0xFF
		a <= 8'b10101010; // 0xAA
		b <= 8'b01010101; // 0x55
		ctrl <= `XORS;
		#10
	// 0x75 ^ 0xC2 = 0xB7
		a <= 8'b01110101; // 0x75
		b <= 8'b11000010; // 0xC2
		ctrl <= `XORS;
		#10
		
	// LOGICAL AND
	// 0xAA & 0x55 = 0x00
		a <= 8'b10101010; // 0xAA
		b <= 8'b01010101; // 0x55
		ctrl <= `ANDS;
		#10
	// 0x75 & 0xE4 = 0x64
		a <= 8'b01110101; // 0x75
		b <= 8'b11100100; // 0xE4
		ctrl <= `ANDS;
		#10
		
	// SHIFT RIGHT
	// 0x3A >> 0x01 = 0x1D
		a <= 8'b00111010; // 0x3A
		b <= 8'b00000001; // 0x01
		ctrl <= `SRS;
		#10
	// 0x75 >> 0x04 = 0x07
		a <= 8'b01110101; // 0x75
		b <= 8'b00000100; // 0x04
		ctrl <= `SRS;
		#10
		$finish;
	end
	
	// Place ALU module into design
	alu_6502 alu(.regA(a), .regB(b), .control(ctrl), .regOut(out), .overflow(v));

endmodule
