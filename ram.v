`include "parameters.vh"

module ram_1 #(
parameter inst_size = `instr_block_size,
parameter data_size = `data_block_size
)(
input clk,
input [`address_width - 3 : 0] A1, A2,
input [`byte_width - 1 : 0] W1, W2,
input WE1, WE2,
output reg [`byte_width - 1 : 0] R1, R2);
reg [`byte_width - 1 : 0] ram_block [(`register_quantity + data_size + inst_size) - 1 : 0];

initial begin
	$readmemh("ram_1.mem", ram_block);
end

always @(posedge clk) begin 	
	R1 <= ram_block[A1];
	if(WE1) begin
		ram_block[A1] <= W1;
	end
end

always @(posedge clk) begin 	
	R2 <= ram_block[A2];
	if(WE2) begin
		ram_block[A2] <= W2;
	end
end

endmodule




module ram_2 #(
parameter inst_size = `instr_block_size,
parameter data_size = `data_block_size
)(
input clk,
input [`address_width - 3 : 0] A1, A2,
input [`byte_width - 1 : 0] W1, W2,
input WE1, WE2,
output reg [`byte_width - 1 : 0] R1, R2);
reg [`byte_width - 1 : 0] ram_block [(`register_quantity + data_size + inst_size) - 1 : 0];

initial begin
        $readmemh("ram_2.mem", ram_block);
    end

always @(posedge clk) begin 	
	R1 <= ram_block[A1];
	if(WE1) begin
		ram_block[A1] <= W1;
	end
end

always @(posedge clk) begin 	
	R2 <= ram_block[A2];
	if(WE2) begin
		ram_block[A2] <= W2;
	end
end

endmodule

module ram_3 #(
parameter inst_size = `instr_block_size,
parameter data_size = `data_block_size
)(
input clk,
input [`address_width - 3 : 0] A1, A2,
input [`byte_width - 1 : 0] W1, W2,
input WE1, WE2,
output reg [`byte_width - 1 : 0] R1, R2);
reg [`byte_width - 1 : 0] ram_block [(`register_quantity + data_size + inst_size) - 1 : 0];

initial begin
        $readmemh("ram_3.mem", ram_block);
    end

always @(posedge clk) begin 	
	R1 <= ram_block[A1];
	if(WE1) begin
		ram_block[A1] <= W1;
	end
end

always @(posedge clk) begin 	
	R2 <= ram_block[A2];
	if(WE2) begin
		ram_block[A2] <= W2;
	end
end

endmodule

module ram_4 #(
parameter inst_size = `instr_block_size,
parameter data_size = `data_block_size
)(
input clk,
input [`address_width - 3 : 0] A1, A2,
input [`byte_width - 1 : 0] W1, W2,
input WE1, WE2,
output reg [`byte_width - 1 : 0] R1, R2);
reg [`byte_width - 1 : 0] ram_block [(`register_quantity + data_size + inst_size) - 1 : 0];

initial begin
        $readmemh("ram_4.mem", ram_block);
    end

always @(posedge clk) begin 	
	R1 <= ram_block[A1];
	if(WE1) begin
		ram_block[A1] <= W1;
	end
end

always @(posedge clk) begin 	
	R2 <= ram_block[A2];
	if(WE2) begin
		ram_block[A2] <= W2;
	end
end

endmodule

module memory #(
parameter inst_size = `instr_block_size,
parameter data_size = `data_block_size
)(
input clk,
input [`address_width - 1 : 2] A1, A2,	//[`address_width - 1 : 0]
input [`word_width - 1 : 0] W1, W2,
input [`WE_width - 1: 0] WE1, WE2,
output [`word_width - 1 : 0] R1, R2);


ram_1 #(.inst_size(inst_size), .data_size(data_size)) ram_1 (
.clk (clk),
.A1 (A1[`address_width - 1 : 2]),
.A2 (A2[`address_width - 1 : 2]),
.W1 (W1[`byte_width - 1 : 0]),
.W2 (W2[`byte_width - 1 : 0]),
.WE1 (WE1[0]),
.WE2 (WE2[0]),
.R1 (R1[`byte_width - 1 : 0]),
.R2 (R2[`byte_width - 1 : 0]));

ram_2 #(.inst_size(inst_size), .data_size(data_size)) ram_2 (
.clk (clk),
.A1 (A1[`address_width - 1 : 2]),
.A2 (A2[`address_width - 1 : 2]),
.W1 (W1[`half_width - 1 : `byte_width]),
.W2 (W2[`half_width - 1 : `byte_width]),
.WE1 (WE1[1]),
.WE2 (WE2[1]),
.R1 (R1[`half_width - 1 : `byte_width]),
.R2 (R2[`half_width - 1 : `byte_width]));

ram_3 #(.inst_size(inst_size), .data_size(data_size)) ram_3 (
.clk (clk),
.A1 (A1[`address_width - 1 : 2]),
.A2 (A2[`address_width - 1 : 2]),
.W1 (W1[`half_width + `byte_width - 1 : `half_width]),
.W2 (W2[`half_width + `byte_width - 1 : `half_width]),
.WE1 (WE1[2]),
.WE2 (WE2[2]),
.R1 (R1[`half_width + `byte_width - 1 : `half_width]),
.R2 (R2[`half_width + `byte_width - 1 : `half_width]));

ram_4 #(.inst_size(inst_size), .data_size(data_size)) ram_4 (
.clk (clk),
.A1 (A1[`address_width - 1 : 2]),
.A2 (A2[`address_width - 1 : 2]),
.W1 (W1[`word_width - 1 : `half_width + `byte_width]),
.W2 (W2[`word_width - 1 : `half_width + `byte_width]),
.WE1 (WE1[3]),
.WE2 (WE2[3]),
.R1 (R1[`word_width - 1 : `half_width + `byte_width]),
.R2 (R2[`word_width - 1 : `half_width + `byte_width]));

endmodule