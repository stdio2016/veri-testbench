`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:56:06 11/01/2016 
// Design Name: 
// Module Name:    nodebounce 
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
module debounce(input  clk, input btn_input, output btn_output);
 reg f;
 always @(posedge clk) begin
  f <= btn_input;
 end
 assign btn_output = f;
endmodule
