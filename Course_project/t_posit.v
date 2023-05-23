`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   17:37:43 05/21/2023
// Design Name:   Posit
// Module Name:   /home/ise/Documents/Projects/Posit/t_posit.v
// Project Name:  Posit
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: Posit
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module t_posit;

	// Inputs
	reg [15:0] posit_a;
	reg clk;
	reg [15:0] posit_b;

	// Outputs
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	Posit uut (
		.posit_a(posit_a),
		.clk(clk),
		.posit_b(posit_b),
		.result(result)
	);

	initial begin
		// Initialize Inputs
		posit_a = 0;
		clk = 0;
		posit_b =0;

		// Wait 100 ns for global reset to finish
		#5 posit_a = 010100100;
		#5 posit_b = 001010110;
		// Add stimulus here
      #100;
	end
	always clk=clk+1;

endmodule

