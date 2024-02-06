`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 02/03/2024 04:52:05 PM
// Design Name: counter
// Module Name: counter
// Project Name: counter
// Target Devices:
// Tool Versions:
// Description: a 4 bit synchronous up/down counter with enable, asynchrnous reset
// and synchrnous load
//////////////////////////////////////////////////////////////////////////////////
module counter#(
	parameter WIDTH = 4
)(
	input				clk			,
	input				asyn_rstn	,
	input				enb			,
	input 				load		,
	input  [WIDTH-1:0]	data_in		,
	output [WIDTH-1:0]	count
);
	reg up	; // 1: counter going up
	reg down; // 1: counter going down
	reg [WIDTH-1:0] count_reg;
	reg [WIDTH-1:0] almost_max, almost_min;
	assign count = count_reg;
	assign almost_max = {WIDTH{1'b1}} - 1;
	assign almost_min = {WIDTH{1'b0}} + 1;

	//counter
	always_ff @(posedge clk or negedge asyn_rstn) begin
		if (!asyn_rstn) begin
			count_reg <= {WIDTH{1'b0}};
		end else begin
			if (load) begin
				count_reg <= data_in;
			end else begin
				if (load) begin
					count_reg <= data_in;
				end else begin
					if (enb) begin
						if (up)			count_reg <= count_reg + 1;
						else if (down)	count_reg <= count_reg - 1;
						else            count_reg <= count_reg	  ;
					end else begin
						count_reg <= count_reg;
					end
				end
			end
		end
	end
	// up and down selector
	always_ff @(posedge clk or negedge asyn_rstn) begin
		if (!asyn_rstn) begin
			up 	 <= 1'b1;
			down <= 1'b0;
		end else begin
			if (enb) begin
				if (count_reg == almost_max) begin
					up   <= 1'b0;
					down <= 1'b1;
				end else if (count_reg == almost_min) begin
					up   <= 1'b1;
					down <= 1'b0;
				end else begin
					up   <= up;
					down <= down;
				end
			end else begin
				up   <= up;
				down <= down;
			end
		end
	end
endmodule;