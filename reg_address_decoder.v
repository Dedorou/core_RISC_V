`include "parameters.vh"

module reg_address_decoder (
input [`rs1_width - 1 : 0] rs1,
input [`rs2_width - 1 : 0] rs2,
input [`rd_width - 1 : 0] rd,

output reg [`rs1_dec_width - 1 : 2] rs1_dec,
output reg [`rs2_dec_width - 1 : 2] rs2_dec,
output reg [`rd_dec_width - 1 : 2] rd_dec

);

always @(rs1, rs2, rd) begin 

case (rs1) 
	`rs1_width'd0  : rs1_dec <= `rs1_width'd0;
	`rs1_width'd1  : rs1_dec <= `rs1_width'd1;
	`rs1_width'd2  : rs1_dec <= `rs1_width'd2;
	`rs1_width'd3  : rs1_dec <= `rs1_width'd3;
	`rs1_width'd4  : rs1_dec <= `rs1_width'd4;
	`rs1_width'd5  : rs1_dec <= `rs1_width'd5;
	`rs1_width'd6  : rs1_dec <= `rs1_width'd6;
	`rs1_width'd7  : rs1_dec <= `rs1_width'd7;
	`rs1_width'd8  : rs1_dec <= `rs1_width'd8;
	`rs1_width'd9  : rs1_dec <= `rs1_width'd9;
	`rs1_width'd10 : rs1_dec <= `rs1_width'd10;
	`rs1_width'd11 : rs1_dec <= `rs1_width'd11;
	`rs1_width'd12 : rs1_dec <= `rs1_width'd12;
	`rs1_width'd13 : rs1_dec <= `rs1_width'd13;
	`rs1_width'd14 : rs1_dec <= `rs1_width'd14;
	`rs1_width'd15 : rs1_dec <= `rs1_width'd15;
	`rs1_width'd16 : rs1_dec <= `rs1_width'd16;
	`rs1_width'd17 : rs1_dec <= `rs1_width'd17;
	`rs1_width'd18 : rs1_dec <= `rs1_width'd18;
	`rs1_width'd19 : rs1_dec <= `rs1_width'd19;
	`rs1_width'd20 : rs1_dec <= `rs1_width'd20;
	`rs1_width'd21 : rs1_dec <= `rs1_width'd21;
	`rs1_width'd22 : rs1_dec <= `rs1_width'd22;
	`rs1_width'd23 : rs1_dec <= `rs1_width'd23;
	`rs1_width'd24 : rs1_dec <= `rs1_width'd24;
	`rs1_width'd25 : rs1_dec <= `rs1_width'd25;
	`rs1_width'd26 : rs1_dec <= `rs1_width'd26;
	`rs1_width'd27 : rs1_dec <= `rs1_width'd27;
	`rs1_width'd28 : rs1_dec <= `rs1_width'd28;
	`rs1_width'd29 : rs1_dec <= `rs1_width'd29;
	`rs1_width'd30 : rs1_dec <= `rs1_width'd30;
	`rs1_width'd31 : rs1_dec <= `rs1_width'd31;
	default : rs1_dec <= 0;
endcase 

case (rs2) 
	`rs2_width'd0  : rs2_dec <= `rs2_width'd0;
	`rs2_width'd1  : rs2_dec <= `rs2_width'd1;
	`rs2_width'd2  : rs2_dec <= `rs2_width'd2;
	`rs2_width'd3  : rs2_dec <= `rs2_width'd3;
	`rs2_width'd4  : rs2_dec <= `rs2_width'd4;
	`rs2_width'd5  : rs2_dec <= `rs2_width'd5;
	`rs2_width'd6  : rs2_dec <= `rs2_width'd6;
	`rs2_width'd7  : rs2_dec <= `rs2_width'd7;
	`rs2_width'd8  : rs2_dec <= `rs2_width'd8;
	`rs2_width'd9  : rs2_dec <= `rs2_width'd9;
	`rs2_width'd10 : rs2_dec <= `rs2_width'd10;
	`rs2_width'd11 : rs2_dec <= `rs2_width'd11;
	`rs2_width'd12 : rs2_dec <= `rs2_width'd12;
	`rs2_width'd13 : rs2_dec <= `rs2_width'd13;
	`rs2_width'd14 : rs2_dec <= `rs2_width'd14;
	`rs2_width'd15 : rs2_dec <= `rs2_width'd15;
	`rs2_width'd16 : rs2_dec <= `rs2_width'd16;
	`rs2_width'd17 : rs2_dec <= `rs2_width'd17;
	`rs2_width'd18 : rs2_dec <= `rs2_width'd18;
	`rs2_width'd19 : rs2_dec <= `rs2_width'd19;
	`rs2_width'd20 : rs2_dec <= `rs2_width'd20;
	`rs2_width'd21 : rs2_dec <= `rs2_width'd21;
	`rs2_width'd22 : rs2_dec <= `rs2_width'd22;
	`rs2_width'd23 : rs2_dec <= `rs2_width'd23;
	`rs2_width'd24 : rs2_dec <= `rs2_width'd24;
	`rs2_width'd25 : rs2_dec <= `rs2_width'd25;
	`rs2_width'd26 : rs2_dec <= `rs2_width'd26;
	`rs2_width'd27 : rs2_dec <= `rs2_width'd27;
	`rs2_width'd28 : rs2_dec <= `rs2_width'd28;
	`rs2_width'd29 : rs2_dec <= `rs2_width'd29;
	`rs2_width'd30 : rs2_dec <= `rs2_width'd30;
	`rs2_width'd31 : rs2_dec <= `rs2_width'd31;
	default : rs2_dec <= 0;
endcase 

case (rd) 
	`rd_width'd0  : rd_dec <= `rd_width'd0;
	`rd_width'd1  : rd_dec <= `rd_width'd1;
	`rd_width'd2  : rd_dec <= `rd_width'd2;
	`rd_width'd3  : rd_dec <= `rd_width'd3;
	`rd_width'd4  : rd_dec <= `rd_width'd4;
	`rd_width'd5  : rd_dec <= `rd_width'd5;
	`rd_width'd6  : rd_dec <= `rd_width'd6;
	`rd_width'd7  : rd_dec <= `rd_width'd7;
	`rd_width'd8  : rd_dec <= `rd_width'd8;
	`rd_width'd9  : rd_dec <= `rd_width'd9;
	`rd_width'd10 : rd_dec <= `rd_width'd10;
	`rd_width'd11 : rd_dec <= `rd_width'd11;
	`rd_width'd12 : rd_dec <= `rd_width'd12;
	`rd_width'd13 : rd_dec <= `rd_width'd13;
	`rd_width'd14 : rd_dec <= `rd_width'd14;
	`rd_width'd15 : rd_dec <= `rd_width'd15;
	`rd_width'd16 : rd_dec <= `rd_width'd16;
	`rd_width'd17 : rd_dec <= `rd_width'd17;
	`rd_width'd18 : rd_dec <= `rd_width'd18;
	`rd_width'd19 : rd_dec <= `rd_width'd19;
	`rd_width'd20 : rd_dec <= `rd_width'd20;
	`rd_width'd21 : rd_dec <= `rd_width'd21;
	`rd_width'd22 : rd_dec <= `rd_width'd22;
	`rd_width'd23 : rd_dec <= `rd_width'd23;
	`rd_width'd24 : rd_dec <= `rd_width'd24;
	`rd_width'd25 : rd_dec <= `rd_width'd25;
	`rd_width'd26 : rd_dec <= `rd_width'd26;
	`rd_width'd27 : rd_dec <= `rd_width'd27;
	`rd_width'd28 : rd_dec <= `rd_width'd28;
	`rd_width'd29 : rd_dec <= `rd_width'd29;
	`rd_width'd30 : rd_dec <= `rd_width'd30;
	`rd_width'd31 : rd_dec <= `rd_width'd31;
	default : rd_dec <= 0;
endcase 

end

endmodule