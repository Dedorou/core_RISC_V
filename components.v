`include "parameters.vh"

module mux_2 (
input [`word_width - 1 : 0] a, b,
input sel,

output reg [`word_width - 1 : 0] out
); 

always @(a or b or sel) begin 
	case (sel)
		1'b0 : out <= a;
		1'b1 : out <= b;
		default : out <= a;
	endcase 
end

endmodule

module mux_2_addr (
input [`address_width - 1 : 2] a, b,	//[`address_width - 1 : 0]
input sel,

output reg [`address_width - 1 : 2] out	//[`address_width - 1 : 0]
); 

always @(a or b or sel) begin 
	case (sel)
		1'b0 : out <= a;
		1'b1 : out <= b;
		default : out <= a;
	endcase 
end

endmodule

module mux_3 (
input [`word_width - 1 : 0] a, b, c,
input [1 : 0] sel,

output reg [`word_width - 1 : 0] out
); 

always @(a or b or c or sel) begin 
	case (sel)
		2'b00 : out <= a;
		2'b01 : out <= b;
		2'b10 : out <= c;
		default : out <= a;
	endcase 
end

endmodule

module mux_3_addr (
input [`address_width - 1 : 2] a, b, c,	//[`address_width - 1 : 0]
input [1 : 0] sel,

output reg [`address_width - 1 : 2] out	//[`address_width - 1 : 0]
); 

always @(a or b or c or sel) begin 
	case (sel)
		2'b00 : out <= a;
		2'b01 : out <= b;
		2'b10 : out <= c;
		default : out <= a;
	endcase 
end

endmodule

module mux_4 (
input [`word_width - 1 : 0] a, b, c, d,
input [1 : 0] sel,

output reg [`word_width - 1 : 0] out
); 

always @(a or b or c or d or sel) begin 
	case (sel)
		2'b00 : out <= a;
		2'b01 : out <= b;
		2'b10 : out <= c;
		2'b11 : out <= d;
		default : out <= a;
	endcase 
end

endmodule



module reg_32 (
input clk, 
input rst, 
input WE, 
input [`word_width - 1 : 0] D, 
output reg [`word_width - 1 : 0] Q);

always @(posedge clk) begin 
	if (rst) begin
	Q <= 0;
	end else begin 
		if (WE) begin 
			Q <= D;
		end
	end
end

endmodule


module param_reg #(
parameter N = 12)(
input clk, 
input rst,
input WE,
input [N-1 : 0] D,
output reg [N-1 : 0] Q);

always @(posedge clk) begin 
	if (rst) begin
	Q <= 0;
	end else begin 
		if (WE) begin 
			Q <= D;
		end
	end
end

endmodule
