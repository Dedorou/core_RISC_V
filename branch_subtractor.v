`include "parameters.vh"

module branc_subtractor (

input [`word_width - 1 : 0] a,
input [`word_width - 1 : 0] b,

input [`ALU_control_width - 1 : 0] ALU_control,

output reg branch,
output reg [`word_width - 1 : 0] y);

reg eq;

wire beq_branch;
wire bne_branch;
wire blt_branch;
wire bge_branch;
wire bltu_branch;
wire bgeu_branch;

branc_decoder branc_decoder (
.a (a[`word_width - 1]), 
.b (b[`word_width - 1]), 
.eq (eq), 
.y (y[`word_width - 1]), 
.beq_branch (beq_branch), 
.bne_branch (bne_branch), 
.blt_branch (blt_branch), 
.bge_branch (bge_branch), 
.bltu_branch (bltu_branch), 
.bgeu_branch (bgeu_branch));

always @* begin 
	y <= a - b;
	
	if (a == b) begin
		eq <= 1;
	end else begin
		eq <= 0;
	end
end

always @* begin 
	case (ALU_control)
		`beq_ALU : branch <= beq_branch;	
		`bne_ALU : branch <= bne_branch;	
		`bge_ALU : branch <= bge_branch;
		`slt_ALU : branch <= blt_branch;
		`bgeu_ALU : branch <= bgeu_branch;
		`sltu_ALU : branch <= bltu_branch;
		default : branch <= 0;
	endcase
end

endmodule


module branc_decoder (

input a,
input b,
input eq,
input y,

output reg beq_branch,
output reg bne_branch,
output reg blt_branch,
output reg bge_branch,
output reg bltu_branch,
output reg bgeu_branch);

always @* begin 
	casex ({a, b, eq, y})
		4'b0000 : begin 
			bne_branch <= 1;
			
			bge_branch <= 1;
			
			bgeu_branch <= 1;
			
			beq_branch <= 0;
			blt_branch <= 0;
			bltu_branch <= 0;
			end
		4'b0001 : begin 
			bne_branch <= 1;
			
			blt_branch <= 1;
			
			bltu_branch <= 1;
			
			beq_branch <= 0;
			bge_branch <= 0;
			bgeu_branch <= 0;
			end
		4'b0010 : begin 
			beq_branch <= 1;
			bge_branch <= 1;
			bgeu_branch <= 1;
			
			bne_branch <= 0;
			blt_branch <= 0;
			bltu_branch <= 0;
			end
		4'b0011 : begin 
			beq_branch <= 1;
			bge_branch <= 1;
			bgeu_branch <= 1;
			
			bltu_branch <= 1;
			
			bne_branch <= 0;
			blt_branch <= 0;
			end
		4'b0100 : begin 
			bne_branch <= 1;
			
			bge_branch <= 1;
			
			bgeu_branch <= 1;
			
			beq_branch <= 0;
			blt_branch <= 0;
			bltu_branch <= 0;
			end 
		4'b0101 : begin 
			bne_branch <= 1;
			
			bge_branch <= 1;
			
			bltu_branch <= 1;
			
			beq_branch <= 0;
			bgeu_branch <= 0;
			blt_branch <= 0;
			end
		4'b0110 : begin 
			beq_branch <= 1;
			bge_branch <= 1;
			bgeu_branch <= 1;
			
			bne_branch <= 0;
			blt_branch <= 0;
			bltu_branch <= 0;
			end
		4'b0111 : begin 
			beq_branch <= 1;
			bge_branch <= 1;
			bgeu_branch <= 1;
			
			bltu_branch <= 1;
			
			bne_branch <= 0;
			blt_branch <= 0;
			end
		4'b1000 : begin 
			bne_branch <= 1;
			
			blt_branch <= 1;
			
			bgeu_branch <= 1;
			
			beq_branch <= 0;
			bge_branch <= 0;
			bltu_branch <= 0;
			end 
		4'b1001 : begin 
			bne_branch <= 1;
			
			blt_branch <= 1;
			
			bltu_branch <= 1;
			
			bgeu_branch <= 1;
			
			beq_branch <= 0;
			bge_branch <= 0;
			end
		4'b1010 : begin 
			beq_branch <= 1;
			bge_branch <= 1;
			bgeu_branch <= 1;
			
			bne_branch <= 0;
			blt_branch <= 0;
			bltu_branch <= 0;
			end
		4'b1011 : begin 
			beq_branch <= 1;
			bge_branch <= 1;
			bgeu_branch <= 1;
			
			bltu_branch <= 1;
			
			bne_branch <= 0;
			blt_branch <= 0;
			end
		4'b1100 : begin 
			bne_branch <= 1;
			
			bge_branch <= 1;
			
			bgeu_branch <= 1;
			
			beq_branch <= 0;
			blt_branch <= 0;
			bltu_branch <= 0;
			end 
		4'b1101 : begin 
			bne_branch <= 1;
			
			blt_branch <= 1;
			
			bltu_branch <= 1;
			
			beq_branch <= 0;
			bge_branch <= 0;
			bgeu_branch <= 0;
			end
		4'b1110 : begin 
			beq_branch <= 1;
			bge_branch <= 1;
			bgeu_branch <= 1;
			
			bne_branch <= 0;
			blt_branch <= 0;
			bltu_branch <= 0;
			end
		4'b1111 : begin 
			beq_branch <= 1;
			bge_branch <= 1;
			bgeu_branch <= 1;
			
			bltu_branch <= 1;
			
			bne_branch <= 0;
			blt_branch <= 0;
			end
		
	endcase
//	casex ({a, b, eq, y})
//		
//		4'bxx1x : begin 
//			beq_branch <= 1;
//			bge_branch <= 1;
//			bgeu_branch <= 1;
//			end
//		4'bxx0x : begin 
//			bne_branch <= 1;
//			end
//			
//		//blt_branch
//		4'b100x : begin 
//			blt_branch <= 1;
//			end
//		4'b0001 : begin
//			blt_branch <= 1;
//			end
//		4'b1101 : begin 
//			blt_branch <= 1;
//			end
//		
//		//bge_branch
//		4'b010x : begin 
//			bge_branch <= 1;
//			end	
//		4'b1100 : begin 
//			bge_branch <= 1;
//			end
//		4'b0000 : begin 
//			bge_branch <= 1;
//			end
//		
//		//bltu_branch
//		4'bxxx1 : begin 
//			bltu_branch <= 1;
//			end
//			
//		//bgeu_branch 
//		4'bxxx0 : begin 
//			bgeu_branch <= 1;
//			end
//	endcase 
end

endmodule