`include "parameters.vh"

module new_ALU (

input [`word_width - 1 : 0] a,
input [`word_width - 1 : 0] b,

input [`ALU_control_width - 1 : 0] ALU_control,

output branch,
output reg [`word_width - 1 : 0] y);

always @* begin 
case (ALU_control)
	
	`add_ALU : y <= a + b;
	`sub_ALU : y <= a - b;
	
	
	
endcase
end



endmodule