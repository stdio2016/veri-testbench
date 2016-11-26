`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: No such company
// Engineer: stdio2016
// 
// Create Date:    10:23:53 11/01/2016 
// Design Name: 
// Module Name:    fake_sd_card 
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
module sd_card(

  /* spi signals, not used in simulation */
  output cs,
  output sclk,
  output mosi,
  input  miso,

  /* SD controller signals */
  input  clk,
  input  rst,
  input  rd_req,               // "rd_req <= 1" triggers the reading of a block.
  input  [31:0] block_addr,    // The block number of the SD card to read.
  output reg init_finish,      // SD card initialization is finished?
  output reg [7:0] dout,       // Output one byte of data in the block.
  output reg sd_valid          // The output byte in "dout" is ready
);

	// wire size must be equal to the test data size
	wire [0:8*140-1] fake_data;
	// Input test data here!
	assign fake_data={
	 "MATX_TAG",8'h0D,8'h0A,
	 "4F",8'h0D,8'h0A,
	 "7E",8'h0D,8'h0A,
	 "57",8'h0D,8'h0A,
	 "0F",8'h0D,8'h0A,
	 "14",8'h0D,8'h0A,
	 "53",8'h0D,8'h0A,
	 "66",8'h0D,8'h0A,
	 "62",8'h0D,8'h0A,
	 "46",8'h0D,8'h0A,
	 "10",8'h0D,8'h0A,
	 "21",8'h0D,8'h0A,
	 "22",8'h0D,8'h0A,
	 "65",8'h0D,8'h0A,
	 "50",8'h0D,8'h0A,
	 "45",8'h0D,8'h0A,
	 "15",8'h0D,8'h0A,
	 
	 "72",8'h0D,8'h0A,
	 "31",8'h0D,8'h0A,
	 "4C",8'h0D,8'h0A,
	 "4D",8'h0D,8'h0A,
	 "26",8'h0D,8'h0A,
	 "6E",8'h0D,8'h0A,
	 "2E",8'h0D,8'h0A,
	 "30",8'h0D,8'h0A,
	 "33",8'h0D,8'h0A,
	 "39",8'h0D,8'h0A,
	 "5C",8'h0D,8'h0A,
	 "69",8'h0D,8'h0A,
	 "7B",8'h0D,8'h0A,
	 "21",8'h0D,8'h0A,
	 "4C",8'h0D,8'h0A,
	 "54",8'h0D,8'h0A,
	 8'h0D,8'h0A
	};
	assign cs = 0;
	assign sclk = 0;
	assign mosi = 0;
	reg [9:0] counter;
	reg [1:0] prepare;
	initial begin
	  init_finish = 1;
		counter = 0;
	end
	always @(posedge clk) begin
		if(rd_req) begin
		 counter <= 0;
		 sd_valid <= 0;
		 prepare <= 1;
		end
		else begin
		 if(prepare == 2) begin
		  prepare <= 1;
			if(counter < 512) begin
				dout <= block_addr==32'h2005 ? fake_data[{counter, 3'b000} +: 8] : 8'h00;
				counter <= counter + 1;
				sd_valid <= 1;
			end
		 end
		 else begin
		  prepare <= prepare + 1;
		  sd_valid <= 0;
		 end
		end
	end

endmodule
/*
4F
7E
57
0F

14
53
66
62

46
10
21
22

65
50
45
15


72
31
4C
4D

26
6E
2E
30

33
39
5C
69

7B
21
4C
54
*/