`include "parameters.vh"

module decoder(
input wire [`word_width - 1 : 0] instruction,

output reg [`imm_control_width - 1 : 0] imm_control,	
output reg [`ALU_control_width - 1 : 0] ALU_control,	
output reg [`store_control_width - 1 : 0] store_control
);

wire [`opcode_width - 1	: 0] opcode = instruction [`opcode_width - 1 : 0];
wire [`funct3_width - 1 : 0] funct3 = instruction [`opcode_width + `rd_width + `funct3_width - 1 : `opcode_width + `rd_width];
wire [`funct7_width - 1: 0] funct7 = instruction [`word_width - 1 : `word_width - `funct7_width];

always @* begin

case (opcode)
	
	`arithmetic_opcode : // R-type instruction
	begin	
		imm_control <= `i_type_imm; //???
		store_control <= `sw;
		
		case ({funct3, funct7})		
			`add_funct3_funct7  : ALU_control <= `add_ALU; 		// add, funct3 = 0x0, funct7 = 0x00
			`sub_funct3_funct7  : ALU_control <= `sub_ALU; 		// sub, funct3 = 0x0, funct7 = 0x20
			`xor_funct3_funct7  : ALU_control <= `xor_ALU; 		// xor, funct3 = 0x4, funct7 = 0x00
			`or_funct3_funct7   : ALU_control <= `or_ALU; 		// or, funct3 = 0x6, funct7 = 0x00
			`and_funct3_funct7  : ALU_control <= `and_ALU; 		// and, funct3 = 0x7, funct7 = 0x00
			`sll_funct3_funct7  : ALU_control <= `sll_ALU; 		// sll, funct3 = 0x1, funct7 = 0x00
			`srl_funct3_funct7  : ALU_control <= `srl_ALU; 		// srl, funct3 = 0x5, funct7 = 0x00
			`sra_funct3_funct7  : ALU_control <= `sra_ALU; 		// sra, funct3 = 0x5, funct7 = 0x20
			`slt_funct3_funct7  : ALU_control <= `slt_ALU; 		// slt, funct3 = 0x2, funct7 = 0x00
			`sltu_funct3_funct7 : ALU_control <= `sltu_ALU; 	// sltu, funct3 = 0x3, funct7 = 0x00
			default : ALU_control <= `add_ALU;	
		endcase
	end
	
	`imm_arithmetic_opcode : // I-type instruction
	begin	
		imm_control <= `i_type_imm;
		store_control <= `sw;
		
		casex ({funct3, funct7})    	
			`addi_funct3_funct7 	: ALU_control <= `add_ALU; 		// addi, funct3 = 0x0
			`xori_funct3_funct7 	: ALU_control <= `xor_ALU; 		// xori, funct3 = 0x4
			`ori_funct3_funct7 		: ALU_control <= `or_ALU; 		// ori, funct3 = 0x6
			`andi_funct3_funct7 	: ALU_control <= `and_ALU; 		// andi, funct3 = 0x7
			`slli_funct3_funct7 	: ALU_control <= `slli_ALU; 	// slli, funct3 = 0x1, imm [5 : 11] = 0x00
			`srli_funct3_funct7 	: ALU_control <= `srli_ALU; 	// srli, funct3 = 0x5, imm [5 : 11] = 0x00
			`srai_funct3_funct7 	: ALU_control <= `srai_ALU; 	// srai, funct3 = 0x5, imm [5 : 11] = 0x20
			`slti_funct3_funct7 	: ALU_control <= `slt_ALU; 		// slti, funct3 = 0x2
			`sltiu_funct3_funct7 	: ALU_control <= `sltu_ALU; 	// sltiu, funct3 = 0x3
			default : ALU_control <= `add_ALU;
		endcase	
	end

	`load_opcode :  // I-type instruction
	begin		
		imm_control <= `i_type_imm;
		store_control <= `sw;
		
		case (funct3)
			`lb_funct3 : ALU_control <= `lb_ALU;	// lb, funct3 = 0x0
			`lh_funct3 : ALU_control <= `lh_ALU; 	// lh, funct3 = 0x1
			`lw_funct3 : ALU_control <= `lw_ALU; 	// lw, funct3 = 0x2
			`lbu_funct3 : ALU_control <= `lbu_ALU; 	// lbu, funct3 = 0x4
			`lhu_funct3 : ALU_control <= `lhu_ALU; 	// lhu, funct3 = 0x5
			default : ALU_control <= `add_ALU;
		endcase		
	end
	
	`store_opcode : // S-type instruction
	begin	
		ALU_control <= `add_ALU;
		imm_control <= `s_type_imm;
	
		case (funct3)
			`sb_funct3 : store_control <= `sb; // sb, funct3 = 0x0
			`sh_funct3 : store_control <= `sh; // sh, funct3 = 0x1
			`sw_funct3 : store_control <= `sw; // sw, funct3 = 0x2
			default : store_control <= `sw;
		endcase 
		
	end
	`branch_opcode : // S-type instruction
	begin		
		imm_control <= `b_type_imm;	
		store_control <= `sw;//???
		
		case (funct3)
			`beq_funct3 : ALU_control <= `beq_ALU; 		//beq, funct3 = 0x0
			`bne_funct3 : ALU_control <= `bne_ALU;		//bne, funct3 = 0x1
			`blt_funct3 : ALU_control <= `slt_ALU;      //blt, funct3 = 0x4
			`bge_funct3 : ALU_control <= `bge_ALU;      //bge, funct3 = 0x5
			`bltu_funct3 : ALU_control <= `sltu_ALU;    //bltu, funct3 = 0x6
			`bgeu_funct3 :  ALU_control <= `bgeu_ALU;   //bgeu, funct3 = 0x7
			default : ALU_control <= `add_ALU;
		endcase 
	end
	
	`jal_opcode : // J-type instruction
	begin 
		imm_control <= `j_type_imm;
		ALU_control <= `add_ALU;
		store_control <= `sw;//???
	end
	
	`jalr_opcode : // I-type instruction
	begin 
		//можно ли убрать if ???
		if (funct3 == `jalr_funct3) begin
			imm_control <= `i_type_imm;
			ALU_control <= `add_ALU;
		end
		store_control <= `sw;//???
	end
	
	`lui_opcode : // U-type instruction
	begin 
		imm_control <= `u_type_imm;
		ALU_control <= `lw_ALU;
		store_control <= `sw;//???
	end
	
	`auipc_opcode : // U-type instruction
	begin 
		imm_control <= `u_type_imm;
		ALU_control <= `add_ALU;
		store_control <= `sw; //???
	end
	
	default :
	begin 
		imm_control <= `i_type_imm;
		ALU_control <= `add_ALU;
		store_control <= `sw;
	end

endcase 

end

endmodule