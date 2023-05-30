`include "parameters.vh"

module imm_extention (
input wire [`word_width - 1 : `opcode_width] instruction,
input wire [`imm_control_width - 1 : 0] imm_control,

output reg [`word_width - 1 : 0] imm_out
);

always @* begin 
case (imm_control)
	`i_type_imm : begin // I-type
			imm_out <= {{20{instruction [31]}}, instruction [31 : 20]};
			end
	
	`s_type_imm : begin // S-type
			imm_out <= {{20{instruction [31]}}, instruction [31 : 25], instruction[11 : 7]};
			end
		
	`b_type_imm : begin // B-type
			imm_out <= {{20{instruction [31]}}, instruction [7], instruction [30 : 25], instruction [11 : 8], 1'b0}; //imm_in [0] ???
			end	
	
	`u_type_imm : begin // U-type
			imm_out <= {instruction [31 : 12], {12{1'b0}}}; //imm_in [0] ???
			end	
		
	`j_type_imm : begin // J-type
			imm_out <= {{12{instruction [31]}}, instruction [19 : 12], instruction [20], instruction [30 : 21], 1'b0}; //imm_in [0] ???
			end	
	default : imm_out <= {{20{instruction [31]}}, instruction [31 : 20]};	
endcase 
end 

endmodule 	
