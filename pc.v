`include "parameters.vh"

module pc(

input clk,
input rst,

input pc_WE,
input [`word_width - 1 : 0] pc_in,

output reg [`word_width - 1 : 0] pc_out
);

always @(posedge clk) begin
	if (rst) begin 
		pc_out <= `pc_start;
	end else begin
		if (pc_WE) begin 
			pc_out <= pc_in;
		end
	end
end

endmodule