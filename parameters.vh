`define	instr_block_size	50
`define data_block_size		50

`define register_quantity		32

`define word_width		32
`define half_width		16
`define byte_width		8

`define pc_start		32'h80

`define WE_width		4

`define opcode_width	7
`define rs1_width		5
`define rs2_width		5
`define rd_width		5

`define funct3_width 	3
`define funct7_width 	7

`define rs1_dec_width	7
`define rs2_dec_width	7
`define rd_dec_width	7

//instructions opcodes
`define arithmetic_opcode     	7'b0110011
`define imm_arithmetic_opcode 	7'b0010011
`define load_opcode           	7'b0000011
`define store_opcode          	7'b0100011
`define branch_opcode         	7'b1100011
`define jal_opcode				7'b1101111
`define jalr_opcode				7'b1100111
`define lui_opcode				7'b0110111
`define auipc_opcode			7'b0010111

//control unit states
`define state_width 	5

`define fetch 			5'b00000
`define decode_1 		5'b00001
`define decode_2 		5'b00010		
`define arithm 			5'b00011
`define imm_arithm 		5'b00100		
`define arithm_store 	5'b00101			
`define load_1 			5'b00110
`define load_2 			5'b00111
`define load_3 			5'b01000			
`define store_1 		5'b01001
`define store_2 		5'b01010
`define branch_1		5'b01011
`define branch_2 		5'b01100
`define branch_exec 	5'b01101			
`define jal 			5'b01110
`define jalr_1 			5'b01111
`define jalr_2 			5'b10000
`define lui 			5'b10001
`define auipc 			5'b10010
                           
//mem A1 mux
`define mem_A1_mux_control		2

`define reg_A1_mux				2'b00
`define pc_A1_mux				2'b01
`define ALU_out_A1_mux			2'b10

//mem A2 mux
`define reg_A2_mux 				1'b0
`define ALU_out_A2_mux			1'b1

//mem W1 mux
`define ALU_out_W1_mux			1'b0
`define mem_R2_W1_mux			1'b1

//mem W2 mux
`define ALU_out_W2_mux			1'b0
`define pc_W2_mux				1'b1

//ALU mux 1
`define ALU_mux_1_control_width	2

`define mem_R1_ALU_mux_1		2'b00
`define pc_ALU_mux_1			2'b01
`define old_pc_ALU_mux_1		2'b10

//ALU mux 2
`define ALU_mux_2_control_width	2

`define mem_R2_ALU_mux_2		2'b00
`define imm_ALU_mux_2			2'b01
`define add_4_ALU_mux_2			2'b10

//ALU
`define ALU_control_width		5
`define imm_arithm_width		5

`define add_ALU 				5'b00000
`define sub_ALU				    5'b00001
`define xor_ALU				    5'b00010
`define or_ALU				    5'b00011
`define and_ALU				    5'b00100
`define sll_ALU				    5'b00101
`define srl_ALU				    5'b00110
`define sra_ALU				    5'b00111
`define slli_ALU				5'b01000
`define srli_ALU				5'b01001
`define srai_ALU				5'b01010
`define slt_ALU				    5'b01011
`define sltu_ALU				5'b01100
`define lb_ALU				    5'b01101
`define lh_ALU				    5'b01110
`define lw_ALU				    5'b01111
`define lbu_ALU				    5'b10000
`define lhu_ALU				    5'b10001
`define beq_ALU				    5'b10010
`define bne_ALU				    5'b10011
`define bge_ALU				    5'b10100
`define bgeu_ALU				5'b10101

//store intruction types
`define store_control_width		4

`define sb						4'b0001
`define sh						4'b0011
`define sw						4'b1111

//imm extention
`define imm_control_width		3

`define	i_type_imm				3'b000
`define	s_type_imm				3'b001
`define b_type_imm				3'b010
`define u_type_imm              3'b011
`define j_type_imm              3'b100

//arithmetic instructions
`define add_funct3_funct7 		10'b000_0000000
`define sub_funct3_funct7 		10'b000_0100000
`define xor_funct3_funct7 		10'b100_0000000
`define or_funct3_funct7 		10'b110_0000000
`define and_funct3_funct7 		10'b111_0000000
`define sll_funct3_funct7 		10'b001_0000000
`define srl_funct3_funct7 		10'b101_0000000
`define sra_funct3_funct7 		10'b101_0100000
`define slt_funct3_funct7 		10'b010_0000000
`define sltu_funct3_funct7 		10'b011_0000000

//imm arithmetic instructions
`define addi_funct3_funct7		10'b000_xxxxxxx
`define xori_funct3_funct7		10'b100_xxxxxxx
`define ori_funct3_funct7		10'b110_xxxxxxx
`define andi_funct3_funct7		10'b111_xxxxxxx
`define slli_funct3_funct7		10'b001_0000000		
`define srli_funct3_funct7		10'b101_0000000		
`define srai_funct3_funct7		10'b101_0100000
`define slti_funct3_funct7		10'b010_xxxxxxx
`define sltiu_funct3_funct7		10'b011_xxxxxxx

//load instructions
`define lb_funct3 		3'b000
`define lh_funct3 		3'b001
`define lw_funct3 		3'b010
`define lbu_funct3 		3'b100
`define lhu_funct3 		3'b101

//store instructions
`define sb_funct3 		3'b000
`define sh_funct3 		3'b001
`define sw_funct3 		3'b010

//branch instructions
`define beq_funct3 		3'b000
`define bne_funct3 		3'b001
`define blt_funct3 		3'b100
`define bge_funct3 		3'b101
`define bltu_funct3 	3'b110
`define bgeu_funct3 	3'b111

//jalr
`define jalr_funct3		3'b000 