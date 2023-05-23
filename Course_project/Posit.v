`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:56:04 05/21/2023
// Design Name:
// Module Name:    Posit
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
module Posit(input [15:0] posit_a,input clk, input [15:0] posit_b, output [31:0] result);
    // Declare internal variables
    reg [7:0] regime_a, regime_b, regime_out;
    reg [3:0] exponent_a, exponent_b, exponent_out;
    reg [14:0] fraction_a, fraction_b, fraction_out;
    reg sign_a, sign_b, sign_out;
    reg [31:0] intermediate_result;

	 assign posit_a[15] = sign_a;
    assign posit_b[15]= sign_b;
    assign posit_a[14:7]= regime_a;
    assign posit_b[14:7]= regime_b;;
    assign posit_a[6:3]= exponent_a;
    assign posit_b[6:3]= exponent_b;
    assign posit_a[2:0]= fraction_a;
    assign posit_b[2:0]= fraction_b;

    // Determine sign of output
	 always @(posedge clk)
	 begin
	 sign_out=sign_a^sign_b;
	 end


	 // Calculate regime of output
    always @(posedge clk)
	 begin
        if (regime_a == 8'b00000000 && regime_b == 8'b00000000)
		  begin
            regime_out = 8'b00000000;
        end
        else if (regime_a > regime_b)
		  begin
            regime_out = regime_a;
        end
        else
		  begin
            regime_out = regime_b;
        end
    end

	  // Calculate exponent of output
    always @(posedge clk)
	 begin
        if (regime_a == 8'b00000000 && regime_b == 8'b00000000)
		  begin
            exponent_out = 4'b0000;
        end
        else if (regime_a == regime_b) begin
            exponent_out = exponent_a + exponent_b;
        end
        else if (regime_a > regime_b) begin
            exponent_out = exponent_a + (regime_a - regime_b);
        end
        else begin
            exponent_out = exponent_b + (regime_b - regime_a);
        end
    end


    // Calculate fraction of output
    always @(posedge clk) begin
        intermediate_https://github.com/PoornimaSB/PoornimaBendigerimathresult = {1'b1, fraction_a} * {1'b1, fraction_b};
        fraction_out = intermediate_result[27:14];
    end


    // Combine values to create output
    assign result = {sign_out, regime_out, exponent_out, fraction_out};


endmodule
