`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:39:18 01/12/2016 
// Design Name: 
// Module Name:    alu_6502 
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

module alu_6502(
	input wire [7:0] regA,
	input wire [7:0] regB,
	input wire [4:0] control,
	output reg [7:0] regOut,
	output reg overflow
	);
	
	wire [7:0] orOut;
	reg [7:0] sumOut;
	wire [7:0] xorOut;
	wire [7:0] andOut;
	wire [7:0] shiftOut;
	
	reg extraBit; // extra bit needed to detect overflow/underflow
	
	// Combinatorial functions
	assign orOut = regA | regB;
	assign xorOut = regA ^ regB;
	assign andOut = regA & regB;
	assign shiftOut = regA >> regB;
	
	// Detect overflow/underflow and perform addition
	always @(*) begin
	
		// Perform addition with an extra bit (which is the same as the value of the
		// MSB for the input register)
		// Store the result in sumOut and store the additional bit in extraBit
		{extraBit, sumOut} = {regA[7], regA} + {regB[7], regB};
		
		// If the extra bit and the MSB of the sum is 0x01, overflow
		// If the extra bit and the MSB of the sum is 0x10, underflow
		// Otherwise the overflow bit is set low
		overflow = ({extraBit, sumOut[7]} == 2'b01) || ({extraBit, sumOut[7]} == 2'b10);
	end
	
	// Multiplex the result according to the control
	always @(*) begin
		case(control)
			`SUMS: regOut = sumOut;
			`ORS:  regOut = orOut;
			`XORS: regOut = xorOut;
			`ANDS: regOut = andOut;
			`SRS:  regOut = shiftOut;
		endcase
	end
endmodule
