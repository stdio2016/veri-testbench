`timescale 1ns / 1ps

// Warning! For simulation only

module uart(
    input clk, // The master clock for this module
    input rst, // Synchronous reset.
    input rx, // Incoming serial line
    output tx, // Outgoing serial line
    input transmit, // Signal to transmit
    input [7:0] tx_byte, // Byte to transmit
    output received, // Indicated that a byte has been received.
    output [7:0] rx_byte, // Byte received
    output is_receiving, // Low when receive line is idle.
    output is_transmitting, // Low when transmit line is idle.
    output recv_error
    );


reg [7:0] tx_countdown;
reg [1:0] tx_state;
assign recv_error = 0;
assign is_transmitting = tx_state!=0;

always @(posedge clk) begin
	tx_countdown = tx_countdown-1;
  if(rst) begin
		tx_state = 0;
	end
  else begin
		case(tx_state)
			0:
				if(transmit) begin
					//$display("Output: %2x (%c)",tx_byte, tx_byte);
					$write("%c", tx_byte);
					tx_state = 1;
					tx_countdown = 2;
				end
			1:
				tx_state = tx_countdown ? 1 : 0;
		endcase
	end
end

endmodule
