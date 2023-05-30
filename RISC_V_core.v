`include "parameters.vh"

module RISC_V_core (
input clk, 
input rst,

output [`word_width - 1 : 0] ALU_out);

wire [`word_width - 1 : 0] mem_A1;
wire [`word_width - 1 : 0] mem_A2;
wire [`word_width - 1 : 0] mem_R1;
wire [`word_width - 1 : 0] mem_R2;
wire [`WE_width - 1 : 0] mem_WE1;
wire [`WE_width - 1 : 0] mem_WE2;
wire [`mem_A1_mux_control - 1 : 0] mem_A1_mux_control;
wire mem_A2_mux_control;
wire mem_W1_mux_control;
wire mem_W2_mux_control;

wire old_pc_reg_WE;
wire pc_WE;
wire [`word_width - 1 : 0] old_pc_reg_out;
wire [`word_width - 1 : 0] pc_out;

wire branch;
wire [`ALU_control_width - 1 : 0] ALU_control;
wire [`ALU_mux_1_control_width - 1 : 0] ALU_mux_1_control;
wire [`ALU_mux_2_control_width - 1 : 0] ALU_mux_2_control;

wire [`imm_control_width - 1 : 0] imm_control;
wire [`word_width - 1 : `opcode_width] imm;

control_decode_block control_decode_block(
	.clk (clk),
	.rst (rst),
	.instruction (mem_R1),
	//ALU
	.branch (branch),
	.ALU_control (ALU_control),
	.ALU_mux_1 (ALU_mux_1_control),
	.ALU_mux_2 (ALU_mux_2_control),
	//imm extention
	.imm_control (imm_control),
	.imm (imm),
	//memory
	.mem_A1 (mem_A1),
	.mem_A2 (mem_A2),
	.mem_WE1 (mem_WE1),
	.mem_WE2 (mem_WE2),
	.mem_A1_mux (mem_A1_mux_control),
	.mem_A2_mux (mem_A2_mux_control),
	.mem_W1_mux (mem_W1_mux_control),
	.mem_W2_mux (mem_W2_mux_control),
	//pc
	.old_pc_reg_WE (old_pc_reg_WE),
	.pc_WE (pc_WE));
	
memory_block memory_block (
	.clk (clk),
	.rst (rst),
	
	.CU_A1_out (mem_A1),
	.CU_A2_out (mem_A2),
	.ALU_out (ALU_out),
	.A1_mux_control (mem_A1_mux_control),
	.A2_mux_control (mem_A2_mux_control),
	
	.W1_mux_control (mem_W1_mux_control),
	.W2_mux_control (mem_W2_mux_control),
	
	.WE1 (mem_WE1),
	.WE2 (mem_WE2),
	
	.pc_WE (pc_WE),
	.old_pc_WE (old_pc_reg_WE),
	
	.R1 (mem_R1),
	.R2 (mem_R2),
	
	.pc_out (pc_out),
	.old_pc_out (old_pc_reg_out));

ALU_block ALU_block (
	.ALU_control (ALU_control),
	.imm_control (imm_control),
	.imm_in (imm),
	.ALU_mux_1_control (ALU_mux_1_control),
	.ALU_mux_2_control (ALU_mux_2_control),
	.mem_R1_ALU_in (mem_R1),
	.pc_ALU_in (pc_out),
	.old_pc_ALU_in (old_pc_reg_out),
	.mem_R2_ALU_in (mem_R2),
	.branch (branch),
	.ALU_out (ALU_out));

endmodule