`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 02/03/2024 04:52:05 PM
// Design Name: tb_counter
// Module Name: tb_counter
// Project Name: counter
// Target Devices:
// Tool Versions:
// Description: test bench for a 4 bit synchronous up/down counter with enable,
// asynchrnous reset and synchrnous load
//////////////////////////////////////////////////////////////////////////////////
// Test case 0:
// - Senario: after reset active low, counter starts running
// - Expected operation: counter counts up to 15 then counts down to 0
// Test case 1:
// - Senario: Disable counter then set up counter with a random value
// - Expected operation: counter resumes operation with value being setting up
// Test case 2:
// - Senario: Set up counter while counter still running.
// - Expected operation: counter continues operation with value being setting up
//////////////////////////////////////////////////////////////////////////////////
module tb_counter;
	//logic
	logic		clk 		= 1'b1;
	logic 		asyn_rstn	= 1'b0;
	logic 		enb 		= 1'b0;
	logic		load		= 1'b0;
	logic [3:0] data_in		= 4'd0;
	logic [3:0] count;
	// clock generator
	always clk = #10 ! clk;
	// stimulus
	//// asynchronous reset active low
	initial begin
		#125 asyn_rstn = 1'b1;
	end
	//// enable
	initial begin
		#200  enb <= 1'b1;
		#340  enb <= 1'b0;
		#80   enb <= 1'b1;
		#1500 $finish;
	end
	//// load value in
	initial begin
		#540 load <= 1'b1; data_in <= $urandom_range (0,15);
		#20  load <= 1'b0; data_in <= 4'd0;
		#521 load <= 1'b1; data_in <= $urandom_range (0,15);
		#20  load <= 1'b0; data_in <= 4'd0;
	end
	// design under test
	counter #(
		.WIDTH(4)
	) DUT (
		. clk 		(clk	  ),
		.asyn_rstn	(asyn_rstn),
		.enb		(enb	  ),
		.load       (load     ),
		.data_in    (data_in  ),
		.count      (count    )
	);
	//monitor
	always_ff @(posedge enb) $display ("%0t\t[Starting]\tEnable counter at 0x%0h", $time, count);
	always_ff @(negedge enb) $display ("%0t\t[Stopping]\tEnable counter at 0x%0h", $time, count);
	always_ff @(posedge clk) begin
		if (load) $display ("%0t\t[Setting ]\tSet up counter at value = 0x%0h", $time, data_in);
		if (enb) begin
			if (DUT.up  ) $display ("%0t\t[Running ]\tCounter going up  : counter = 0x%0h", $time, count);
			if (DUT.down) $display ("%0t\t[Running ]\tCounter going down: counter = 0x%0h", $time, count);
		end
	end
endmodule