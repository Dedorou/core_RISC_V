`include "parameters.vh"

module reg_address_decoder (
input [`word_width - 1 : 0] instruction,

output reg [`rs1_dec_width - 1 : 0] rs1,
output reg [`rs2_dec_width - 1 : 0] rs2,
output reg [`rd_dec_width - 1 : 0] rd

);

always @(instruction) begin 

case (instruction [`rs1_width + `funct3_width + `rd_width + `opcode_width - 1 : `funct3_width + `rd_width + `opcode_width]) 
	`rs1_width'd0  : rs1 <= `rs1_dec_width'h0;
	`rs1_width'd1  : rs1 <= `rs1_dec_width'h4;
	`rs1_width'd2  : rs1 <= `rs1_dec_width'h8;
	`rs1_width'd3  : rs1 <= `rs1_dec_width'hC;
	`rs1_width'd4  : rs1 <= `rs1_dec_width'h10;
	`rs1_width'd5  : rs1 <= `rs1_dec_width'h14;
	`rs1_width'd6  : rs1 <= `rs1_dec_width'h18;
	`rs1_width'd7  : rs1 <= `rs1_dec_width'h1C;
	`rs1_width'd8  : rs1 <= `rs1_dec_width'h20;
	`rs1_width'd9  : rs1 <= `rs1_dec_width'h24;
	`rs1_width'd10 : rs1 <= `rs1_dec_width'h28;
	`rs1_width'd11 : rs1 <= `rs1_dec_width'h2C;
	`rs1_width'd12 : rs1 <= `rs1_dec_width'h30;
	`rs1_width'd13 : rs1 <= `rs1_dec_width'h34;
	`rs1_width'd14 : rs1 <= `rs1_dec_width'h38;
	`rs1_width'd15 : rs1 <= `rs1_dec_width'h3C;
	`rs1_width'd16 : rs1 <= `rs1_dec_width'h40;
	`rs1_width'd17 : rs1 <= `rs1_dec_width'h44;
	`rs1_width'd18 : rs1 <= `rs1_dec_width'h48;
	`rs1_width'd19 : rs1 <= `rs1_dec_width'h4C;
	`rs1_width'd20 : rs1 <= `rs1_dec_width'h50;
	`rs1_width'd21 : rs1 <= `rs1_dec_width'h54;
	`rs1_width'd22 : rs1 <= `rs1_dec_width'h58;
	`rs1_width'd23 : rs1 <= `rs1_dec_width'h5C;
	`rs1_width'd24 : rs1 <= `rs1_dec_width'h60;
	`rs1_width'd25 : rs1 <= `rs1_dec_width'h64;
	`rs1_width'd26 : rs1 <= `rs1_dec_width'h68;
	`rs1_width'd27 : rs1 <= `rs1_dec_width'h6C;
	`rs1_width'd28 : rs1 <= `rs1_dec_width'h70;
	`rs1_width'd29 : rs1 <= `rs1_dec_width'h74;
	`rs1_width'd30 : rs1 <= `rs1_dec_width'h78;
	`rs1_width'd31 : rs1 <= `rs1_dec_width'h7C;
	default : rs1 <= 0;
endcase 

case (instruction [`rs2_width + `rs1_width + `funct3_width + `rd_width + `opcode_width - 1 : `rs1_width + `funct3_width + `rd_width + `opcode_width]) 
	`rs2_width'd0  : rs2 <= `rs2_dec_width'h0;
	`rs2_width'd1  : rs2 <= `rs2_dec_width'h4;
	`rs2_width'd2  : rs2 <= `rs2_dec_width'h8;
	`rs2_width'd3  : rs2 <= `rs2_dec_width'hC;
	`rs2_width'd4  : rs2 <= `rs2_dec_width'h10;
	`rs2_width'd5  : rs2 <= `rs2_dec_width'h14;
	`rs2_width'd6  : rs2 <= `rs2_dec_width'h18;
	`rs2_width'd7  : rs2 <= `rs2_dec_width'h1C;
	`rs2_width'd8  : rs2 <= `rs2_dec_width'h20;
	`rs2_width'd9  : rs2 <= `rs2_dec_width'h24;
	`rs2_width'd10 : rs2 <= `rs2_dec_width'h28;
	`rs2_width'd11 : rs2 <= `rs2_dec_width'h2C;
	`rs2_width'd12 : rs2 <= `rs2_dec_width'h30;
	`rs2_width'd13 : rs2 <= `rs2_dec_width'h34;
	`rs2_width'd14 : rs2 <= `rs2_dec_width'h38;
	`rs2_width'd15 : rs2 <= `rs2_dec_width'h3C;
	`rs2_width'd16 : rs2 <= `rs2_dec_width'h40;
	`rs2_width'd17 : rs2 <= `rs2_dec_width'h44;
	`rs2_width'd18 : rs2 <= `rs2_dec_width'h48;
	`rs2_width'd19 : rs2 <= `rs2_dec_width'h4C;
	`rs2_width'd20 : rs2 <= `rs2_dec_width'h50;
	`rs2_width'd21 : rs2 <= `rs2_dec_width'h54;
	`rs2_width'd22 : rs2 <= `rs2_dec_width'h58;
	`rs2_width'd23 : rs2 <= `rs2_dec_width'h5C;
	`rs2_width'd24 : rs2 <= `rs2_dec_width'h60;
	`rs2_width'd25 : rs2 <= `rs2_dec_width'h64;
	`rs2_width'd26 : rs2 <= `rs2_dec_width'h68;
	`rs2_width'd27 : rs2 <= `rs2_dec_width'h6C;
	`rs2_width'd28 : rs2 <= `rs2_dec_width'h70;
	`rs2_width'd29 : rs2 <= `rs2_dec_width'h74;
	`rs2_width'd30 : rs2 <= `rs2_dec_width'h78;
	`rs2_width'd31 : rs2 <= `rs2_dec_width'h7C;
	default : rs2 <= 0;
endcase 

case (instruction [`rd_width + `opcode_width - 1 : `opcode_width]) 
	`rd_width'd0  : rd <= `rd_dec_width'h0;
	`rd_width'd1  : rd <= `rd_dec_width'h4;
	`rd_width'd2  : rd <= `rd_dec_width'h8;
	`rd_width'd3  : rd <= `rd_dec_width'hC;
	`rd_width'd4  : rd <= `rd_dec_width'h10;
	`rd_width'd5  : rd <= `rd_dec_width'h14;
	`rd_width'd6  : rd <= `rd_dec_width'h18;
	`rd_width'd7  : rd <= `rd_dec_width'h1C;
	`rd_width'd8  : rd <= `rd_dec_width'h20;
	`rd_width'd9  : rd <= `rd_dec_width'h24;
	`rd_width'd10 : rd <= `rd_dec_width'h28;
	`rd_width'd11 : rd <= `rd_dec_width'h2C;
	`rd_width'd12 : rd <= `rd_dec_width'h30;
	`rd_width'd13 : rd <= `rd_dec_width'h34;
	`rd_width'd14 : rd <= `rd_dec_width'h38;
	`rd_width'd15 : rd <= `rd_dec_width'h3C;
	`rd_width'd16 : rd <= `rd_dec_width'h40;
	`rd_width'd17 : rd <= `rd_dec_width'h44;
	`rd_width'd18 : rd <= `rd_dec_width'h48;
	`rd_width'd19 : rd <= `rd_dec_width'h4C;
	`rd_width'd20 : rd <= `rd_dec_width'h50;
	`rd_width'd21 : rd <= `rd_dec_width'h54;
	`rd_width'd22 : rd <= `rd_dec_width'h58;
	`rd_width'd23 : rd <= `rd_dec_width'h5C;
	`rd_width'd24 : rd <= `rd_dec_width'h60;
	`rd_width'd25 : rd <= `rd_dec_width'h64;
	`rd_width'd26 : rd <= `rd_dec_width'h68;
	`rd_width'd27 : rd <= `rd_dec_width'h6C;
	`rd_width'd28 : rd <= `rd_dec_width'h70;
	`rd_width'd29 : rd <= `rd_dec_width'h74;
	`rd_width'd30 : rd <= `rd_dec_width'h78;
	`rd_width'd31 : rd <= `rd_dec_width'h7C;
	default : rd <= 0;
endcase 

end

endmodule