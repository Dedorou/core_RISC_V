`include "parameters.vh"

module ALU_block(

input [`ALU_control_width - 1 : 0] ALU_control,

input [`imm_control_width - 1 : 0] imm_control,
input [`word_width - 1 : `opcode_width] imm_in,

input [`ALU_mux_1_control_width - 1 : 0] ALU_mux_1_control,
input [`ALU_mux_2_control_width - 1 : 0] ALU_mux_2_control,

input [`word_width - 1 : 0] mem_R1_ALU_in,
input [`word_width - 1 : 0] pc_ALU_in,
input [`word_width - 1 : 0] old_pc_ALU_in,

input [`word_width - 1 : 0] mem_R2_ALU_in,

output branch,
output [`word_width - 1 : 0] ALU_out

);

wire [`word_width - 1 : 0] ALU_mux_1_out;
wire [`word_width - 1 : 0] ALU_mux_2_out;
wire [`word_width - 1 : 0] imm_out;

imm_extention imm_extention (
	.instruction (imm_in), 
	.imm_control (imm_control),
	.imm_out (imm_out));
	
mux_3 ALU_mux_1 (
	.a (mem_R1_ALU_in),
	.b (pc_ALU_in),
	.c (old_pc_ALU_in),
	.sel (ALU_mux_1_control),
	.out (ALU_mux_1_out));
	
mux_3 ALU_mux_2 (
	.a (mem_R2_ALU_in),
	.b (imm_out),
	.c (4),
	.sel (ALU_mux_2_control),
	.out (ALU_mux_2_out));

ALU ALU (
	.a (ALU_mux_1_out),
	.b (ALU_mux_2_out),
	.ALU_control (ALU_control),
	.branch (branch),
	.y (ALU_out));


endmodule