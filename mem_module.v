`include "parameters.vh"

module memory_block (

input clk,
input rst,

//адресные мультиплексоры
input [`word_width - 1 : 0] CU_A1_out,
input [`word_width - 1 : 0] CU_A2_out,
input [`word_width - 1 : 0] ALU_out,
input [`mem_A1_mux_control - 1 : 0] A1_mux_control,
input A2_mux_control,

//мультиплексоры записи
input W1_mux_control,
input W2_mux_control,

//управление записью
input [`WE_width - 1 : 0] WE1,
input [`WE_width - 1 : 0] WE2,

//счетчики команд
input pc_WE,
input old_pc_WE,

output [`word_width - 1 : 0] R1,
output [`word_width - 1 : 0] R2,

output [`word_width - 1 : 0] pc_out,
output [`word_width - 1 : 0] old_pc_out

);

wire [`word_width - 1 : 0] A1_mux_out;
wire [`word_width - 1 : 0] A2_mux_out;
wire [`word_width - 1 : 0] W1_mux_out;
wire [`word_width - 1 : 0] W2_mux_out;

memory #(`instr_block_size, `data_block_size) memory (
	.clk (clk),
	.A1 (A1_mux_out),
	.A2 (A2_mux_out),
	.W1 (W1_mux_out),
	.W2 (W2_mux_out),
	.WE1 (WE1),
	.WE2 (WE2),
	.R1 (R1),
	.R2 (R2));

pc pc (
	.clk (clk),
	.rst (rst),
	.pc_WE (pc_WE),
	.pc_in (ALU_out),
	.pc_out(pc_out));
	
reg_32 old_pc_reg (
	.clk (clk),
	.rst (rst),
	.WE (old_pc_WE),
	.D (pc_out),
	.Q (old_pc_out));

mux_3 A1_mux (
	.a (CU_A1_out),
	.b (pc_out),
	.c (ALU_out),
	.sel (A1_mux_control),
	.out (A1_mux_out));

mux_2 A2_mux (
	.a (CU_A2_out),
	.b (ALU_out),
	.sel (A2_mux_control),
	.out (A2_mux_out));

mux_2 W1_mux (
	.a (ALU_out),
	.b (R2),
	.sel (W1_mux_control),
	.out (W1_mux_out));

mux_2 W2_mux (
	.a (ALU_out),
	.b (pc_out),
	.sel (W2_mux_control),
	.out (W2_mux_out));

endmodule