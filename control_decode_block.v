`include "parameters.vh"

module control_decode_block(

input clk,
input rst,

input [`word_width - 1 : 0] instruction,

//ALU
input branch,
output [`ALU_control_width - 1 : 0] ALU_control,
output [`ALU_mux_1_control_width - 1 : 0] ALU_mux_1,
output [`ALU_mux_2_control_width - 1 : 0] ALU_mux_2,

//imm extention 
output [`imm_control_width - 1 : 0] imm_control,
output [`word_width - 1 : `opcode_width] imm,

//memory
output [`address_width - 1 : 2] mem_A1,	//[`address_width - 1 : 0]
output [`address_width - 1 : 2] mem_A2,	//[`address_width - 1 : 0]
output [`WE_width - 1 : 0] mem_WE1,
output [`WE_width - 1 : 0] mem_WE2,
output [`mem_A1_mux_control - 1 : 0] mem_A1_mux,
output mem_A2_mux,
output mem_W1_mux,
output mem_W2_mux,

output old_pc_reg_WE,
output pc_WE

);

wire [`ALU_control_width - 1 : 0] ALU_control_dec;
wire [`imm_control_width - 1 : 0] imm_control_dec;
wire [`store_control_width - 1 : 0] store_control_dec;

wire instr_reg_WE;
wire [`word_width - 1 : `opcode_width] instruction_reg;
wire [`ALU_control_width - 1 : 0] ALU_control_reg;
wire [`imm_control_width - 1 : 0] imm_control_reg;
wire [`store_control_width - 1 : 0] store_control_reg;


wire [`opcode_width - 1 : 0] opcode;
wire [`funct3_width - 1 : 0] funct3;
wire [`funct7_width - 1: 0] funct7; 

wire [`rs1_width - 1 : 0] rs1;
wire [`rs2_width - 1 : 0] rs2;
wire [`rd_width - 1 : 0] rd;

wire [`rs1_dec_width - 1 : 2] rs1_dec;	//[`address_width - 1 : 0]
wire [`rs2_dec_width - 1 : 2] rs2_dec;	//[`address_width - 1 : 0]
wire [`rd_dec_width - 1 : 2] rd_dec;	//[`address_width - 1 : 0]

//wire [`rs1_dec_width - 1 : 0] rs1;
//wire [`rs2_dec_width - 1 : 0] rs2;
//wire [`rd_dec_width - 1 : 0] rd;

assign opcode = instruction [`opcode_width - 1 : 0];
assign funct3 = instruction [`opcode_width + `rd_width + `funct3_width - 1 : `opcode_width + `rd_width];
assign funct7 = instruction [`word_width - 1 : `word_width - `funct7_width];
assign imm = instruction_reg [`word_width - 1 : `opcode_width];
//assign imm = instruction_reg;

assign rs1 = instruction_reg [`rs1_width + `funct3_width + `rd_width + `opcode_width - 1 : `funct3_width + `rd_width + `opcode_width];
assign rs2 = instruction_reg [`rs2_width + `rs1_width + `funct3_width + `rd_width + `opcode_width - 1 : `rs1_width + `funct3_width + `rd_width + `opcode_width];
assign rd = instruction_reg [`rd_width + `opcode_width - 1 : `opcode_width];

decoder decoder (
	.opcode (opcode),
	.funct3 (funct3),
	.funct7 (funct7),
	.imm_control (imm_control_dec),
	.ALU_control (ALU_control_dec),
	.store_control (store_control_dec));

reg_address_decoder reg_address_decoder (
	.rs1 (rs1),
	.rs2 (rs2),
	.rd (rd),
	.rs1_dec (rs1_dec),
	.rs2_dec (rs2_dec),
	.rd_dec (rd_dec));
//	.instruction (instruction_reg),
//	.rs1 (rs1),
//	.rs2 (rs2),
//	.rd (rd));

param_reg #(.N (`word_width - `opcode_width)) inst_reg (
	.clk (clk),
	.rst (rst),
	.WE (instr_reg_WE),
	.D (instruction [`word_width - 1 : `opcode_width]),
	.Q (instruction_reg));
	
param_reg #(.N (`imm_control_width + `ALU_control_width + `store_control_width)) control_reg (
	.clk (clk),
	.rst (rst),
	.WE (instr_reg_WE),
	.D ({imm_control_dec, ALU_control_dec, store_control_dec}),
	.Q ({imm_control_reg, ALU_control_reg, store_control_reg}));

control_unit control_unit (
	.clk (clk),
	.rst (rst),
	
	.opcode (opcode),
	.rs1 (rs1_dec),
	.rs2 (rs2_dec),
	.rd (rd_dec),
	
	.branch (branch),
	
	.ALU_control_dec (ALU_control_reg),
	.imm_control_dec (imm_control_reg),
	.store_control_dec (store_control_reg),
	
	.mem_A1 (mem_A1),
	.mem_A2 (mem_A2),
	.mem_WE1 (mem_WE1),
	.mem_WE2 (mem_WE2),
	.mem_A1_mux (mem_A1_mux),
	.mem_A2_mux (mem_A2_mux),
	.mem_W1_mux (mem_W1_mux),
	.mem_W2_mux (mem_W2_mux),
	
	.ALU_control (ALU_control),
	.ALU_mux_1 (ALU_mux_1),
	.ALU_mux_2 (ALU_mux_2),
	
	.imm_control (imm_control),
	
	.instr_reg_WE (instr_reg_WE),
	.old_pc_reg_WE (old_pc_reg_WE),
	.pc_WE (pc_WE));
 
endmodule