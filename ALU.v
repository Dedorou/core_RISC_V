`include "parameters.vh"

module ALU(

input wire [`word_width - 1 : 0] a,
input wire [`word_width - 1 : 0] b,
input wire [`ALU_control_width - 1 : 0] ALU_control,

output reg branch,
output reg [`word_width - 1 : 0] y

);


always @* begin
case (ALU_control)		
	`add_ALU : begin
			y <= a + b; // add, addi 
			branch <= 0;
		end
	`sub_ALU : begin
			y <= a - b; // sub
			branch <= 0;
		end
	`xor_ALU : begin
			y <= a ^ b; // xor, xori
			branch <= 0;
		end
	`or_ALU : begin
			y <= a | b; // or, ori
			branch <= 0;
		end
	`and_ALU : begin 
			y <= a & b; // and, andi
			branch <= 0;
		end
	`sll_ALU : begin 
			y <= a << b[4 : 0]; // sll
			branch <= 0;
		end
	`srl_ALU : begin 
			y <= a >> b[4 : 0]; // srl
			branch <= 0;
		end
	`sra_ALU : begin
			y <= $signed(a) >>> b[4 : 0]; //sra
			branch <= 0;
		end
	`slli_ALU : begin
			y <= a << b[4 : 0]; //slli
			branch <= 0;
		end
	`srli_ALU : begin 
			y <= a >> b[4 : 0]; //srli
			branch <= 0;
		end
	`srai_ALU : begin 
			y <= $signed(a) >>> b[4 : 0]; //srai
			branch <= 0;
		end
	`slt_ALU : begin 
			y <= ($signed(a) < $signed(b))? 1 : 0; //slt, slti, blt
			branch <= ($signed(a) < $signed(b))? 1 : 0;
		end
	
	`sltu_ALU : begin 
			y <= (a < b)? 1 : 0; //sltu, sltiu, bltu
			branch <= (a < b)? 1 : 0;
		end
	
	`lb_ALU : begin 
			y <= {{(`byte_width + `half_width + 1){b[`byte_width - 1]}}, b[(`byte_width - 2) : 0]}; //lb
			branch <= 0;
		end
	`lh_ALU : begin 
			y <= {{(`half_width + 1){b[(`half_width - 1)]}}, b[(`half_width - 2) : 0]}; //lh
			branch <= 0;
		end
	`lw_ALU : begin
			y <= b; //lw
			branch <= 0;
		end
	`lbu_ALU : begin 
			y <= {{(`byte_width + `half_width){1'b0}}, b[(`byte_width - 1) : 0]}; //lbu
			branch <= 0;
		end
	`lhu_ALU : begin 
			y <= {{`half_width{1'b0}}, b[(`half_width - 1) : 0]}; //lhu
			branch <= 0;
		end
	`beq_ALU : begin  
			branch <= (a == b)? 1 : 0; //beq
			y <= 0;
		end
	`bne_ALU : begin 
			branch <= (a != b)? 1 : 0;
			y <= 0;
		end
	`bge_ALU : begin
			branch <= ($signed(a) >= $signed(b))? 1 : 0;
			y <= 0;
		end
	`bgeu_ALU : begin 
			branch <= ((a) >= (b))? 1 : 0;
			y <= 0;
		end
	default : begin 
			y <= 0;
			branch <= 0;
		end
endcase 
end

endmodule