`include "parameters.vh"

module control_unit(
input clk, 
input rst,

input [`opcode_width - 1 : 0] opcode,
input [`rs1_dec_width - 1 : 0] rs1,
input [`rs2_dec_width - 1 : 0] rs2,
input [`rd_dec_width - 1 : 0] rd,

input branch,

input [`ALU_control_width - 1 : 0] ALU_control_dec,
input [`imm_control_width - 1 : 0] imm_control_dec,
input [`store_control_width - 1 : 0] store_control_dec,

output reg [`word_width - 1 : 0] mem_A1,
output reg [`word_width - 1: 0] mem_A2,
output reg [`WE_width - 1 : 0] mem_WE1,
output reg [`WE_width - 1 : 0] mem_WE2,
output reg [`mem_A1_mux_control - 1 : 0] mem_A1_mux,
output reg mem_A2_mux,
output reg mem_W1_mux,
output reg mem_W2_mux,

output reg [`ALU_control_width - 1 : 0] ALU_control,
output reg [`ALU_mux_1_control_width - 1 : 0] ALU_mux_1,
output reg [`ALU_mux_2_control_width - 1 : 0] ALU_mux_2, 

output reg [`imm_control_width - 1 : 0] imm_control,

output reg instr_reg_WE,
output reg old_pc_reg_WE,
output reg pc_WE

);

reg [`state_width - 1 : 0] state, next_state;

always @(posedge clk) begin 

	if (rst) begin
		state <= `fetch;
	end else begin 
		state <= next_state;
	end

end

always @* begin

	case (state)
		`fetch : begin
				
				//считываем команду из памяти по адресу из pc
				mem_A1_mux <= `pc_A1_mux; // pc input
				
				//складываем значение рс и 4
				ALU_mux_1 <= `pc_ALU_mux_1;
				ALU_mux_2 <= `add_4_ALU_mux_2;
				ALU_control <= `add_ALU;
				
				//сохраняем новое значение рс
				pc_WE <= 1;
				
				//сохраняем прошлое значение рс
				old_pc_reg_WE <= 1;
				
				//from previous instr
				mem_WE1 <= 0;
				mem_WE2 <= 0;
				
				
				next_state = `decode_1;
			end
		
		`decode_1 : begin 
		
				//перестаем записывать новое и прошлое значение pc
				pc_WE <= 0;
				old_pc_reg_WE <= 0;
				
				//сохраняем команду в регистре
				instr_reg_WE <= 1;
				
				next_state <= `decode_2;
				
			end
		
		`decode_2 : begin 
				
				//перестаем записывать команду
				instr_reg_WE <= 0;
		
				//декодирование команды 
				case (opcode)
					`arithmetic_opcode : next_state <= `arithm;				
					`imm_arithmetic_opcode : next_state <= `imm_arithm;				
					`load_opcode : next_state <= `load_1;			
					`store_opcode : next_state <= `store_1;			
					`branch_opcode : next_state <= `branch_1;			
					`jal_opcode : next_state <= `jal;			
					`jalr_opcode : next_state <= `jalr_1;				
					`lui_opcode : next_state <= `lui;
					`auipc_opcode : next_state <= `auipc;
					default : next_state <= `fetch;
				endcase 
		
			end
		
		
		// arithm instr
		`arithm : begin
				
				//подаем на первый адресный вход памяти адрес первого регистра источника
				mem_A1_mux <= `reg_A1_mux; 
				mem_A1 <= {0, rs1};
				
				//подаем на второй адресный вход памяти адрес первого регистра источника
				mem_A2_mux <= `reg_A2_mux; 
				mem_A2 <= {0, rs2};
				
				//подаем на входы АЛУ 1-ый и 2-ой выходы памяти
				ALU_mux_1 <= `mem_R1_ALU_mux_1; 
				ALU_mux_2 <= `mem_R2_ALU_mux_2;
				
				//операция АЛУ из дешифратора команд (можно поместить в след. состояние???)
				ALU_control <= ALU_control_dec;
			
				next_state <= `arithm_store;
			end
		
		`arithm_store : begin 
					
				//подаем на второй вход записи в память значение АЛУ
				mem_W2_mux <= `ALU_out_W2_mux;//мультиплексор возможно придется убрать 
				
				//подаем на второй адресный вход памяти адрес регистра направления
				mem_A2 <= {0, rd};
				
				//разрешаем запись в память всего слова 
				mem_WE2 <= `sw;
				
				next_state <= `fetch;
			end
		
		// imm arithm instr 
		`imm_arithm : begin 
		
				//подаем на первый адресный вход памяти адрес регистра источника 
				mem_A1_mux <= `reg_A1_mux;
				mem_A1 <= {0, rs1};
				
				//подаем на первый вход АЛУ первый выход памяти
				ALU_mux_1 <= `mem_R1_ALU_mux_1; 
				
				//подаем на второй вход АЛУ значение консанты 
				ALU_mux_2 <= `imm_ALU_mux_2;
				
				//операция АЛУ и тип константы из дешифратора 
				ALU_control <= ALU_control_dec;
				imm_control <= imm_control_dec;
				
				next_state <= `arithm_store;
			end
		
		
		`load_1 : begin 
		
				//подаем на первый адресный вход памяти адрес регистра источника
				mem_A1_mux <= `reg_A1_mux; 
				mem_A1 <= {0, rs1};
				
				//подаем на первый вход АЛУ первый выход памяти
				ALU_mux_1 <= `mem_R1_ALU_mux_1; 
				
				//подаем на второй вход АЛУ значение консанты 
				ALU_mux_2 <= `imm_ALU_mux_2;
				
				//операция сложения для вычисления адреса [rs1 + imm]
				ALU_control <= `add_ALU;
				
				//тип константы 
				imm_control <= imm_control_dec;
				
				next_state <= `load_2;
			end
		
		`load_2 : begin 
				
				//подаем на второй адресный вход памяти выход АЛУ (сумму первого региста и константы)
				mem_A2_mux <= `ALU_out_A2_mux;
				
				next_state <= `load_3;
			end
			
		`load_3 : begin
				
				//подаем на второй вход АЛУ второй выход памяти (ячейку памяти по адресу [rs1 + imm])
				ALU_mux_2 <= `mem_R2_ALU_mux_2;
				
				//операция АЛУ из деширатора (тип загрузки)
				ALU_control <= ALU_control_dec;
				
				//подаем на первый адресный вход памяти адрес регистра направления 
				mem_A1_mux <= `reg_A1_mux;
				mem_A1 <= {0, rd};
				
				//подаем на первый вход записи выход АЛУ
				mem_W1_mux <= `ALU_out_W1_mux;
				
				//разрешаем запись в память всего слова 
				mem_WE1 <= `sw;
				
				next_state <= `fetch;
			
			end
			
		`store_1 : begin 
				
				//подаем на первый адресный вход памяти адрес первого регистра источника
				mem_A1_mux <= `reg_A1_mux;
				mem_A1 <= {0, rs1};	
				
				//подаем на второй адресный вход памяти адрес региста второго регистра источника 
				mem_A2_mux <= `reg_A2_mux; 
				mem_A2 <= {0, rs2};
				
				//подаем на первый вход АЛУ первый выход памяти
				ALU_mux_1 <= `mem_R1_ALU_mux_1; 
				
				//подаем на второй вход АЛУ константу
				ALU_mux_2 <= `imm_ALU_mux_2;
				
				//операция сложения для вычисления адреса [rs1 + imm]
				ALU_control <= `add_ALU;
				
				//тип константы
				imm_control <= imm_control_dec;
					
				next_state <= `store_2;
				
			end
			
		`store_2 : begin 
				
				//подаем на первый адресный вход памяти выход АЛУ (адрес ячейки памяти [rs1 + imm] из прошлого состояния)
				mem_A1_mux <= `ALU_out_A1_mux; 
				
				//подаем на первый вход записи памяти втророй выход памяти (значение втрого регистра источника)
				mem_W1_mux <= `mem_R2_W1_mux; 
				
				//сохраняем значение втрого регистра источника (кол-во байт зависит от команды)
				mem_WE1 <= store_control_dec;
				
				next_state <= `fetch;
				
			end
						
		`branch_1 : begin 
				
				//подаем на первый адресный вход памяти адрес первого регистра источника
				mem_A1_mux <= `reg_A1_mux;
				mem_A1 <= {0, rs1};
				
				//подаем на первый адресный вход памяти адрес второго регистра источника
				mem_A2_mux <= `reg_A2_mux;
				mem_A2 <= {0, rs2};	
				
				//подаем на входы АЛУ первый и второй выходы памяти
				ALU_mux_1 <= `mem_R1_ALU_mux_1; 
				ALU_mux_2 <= `mem_R2_ALU_mux_2;
				
				//операция АЛУ (завистит от команды)
				ALU_control <= ALU_control_dec;
				
				next_state <= `branch_2;
				
			end
			
		`branch_2 : begin 
				
				//если условие выполняется складываем значение рс с константой
				//если нет то переходим в первое состояние
				if (branch == 1) begin 
					next_state <= `branch_exec;
				end else begin 
					next_state <= `fetch;
				end
				
			end
		
		`branch_exec : begin 
				
				//подаем на входы АЛУ прошлое значение рс и константу 
				ALU_mux_1 <= `old_pc_ALU_mux_1; 
				ALU_mux_2 <= `imm_ALU_mux_2;
				
				//операция сложения (складываем прошлое значение рс и константу)
				ALU_control <= `add_ALU;
				
				//тип константы 
				imm_control <= imm_control_dec;
				
				//записываем новое значение рс
				pc_WE <= 1;
				
				next_state <= `fetch;
				
			end
		
		`jal : begin 
		
				//подаем на второй адресный вход памяти адрес регистра направления
				mem_A2_mux <= `reg_A2_mux;
				mem_A2 <= {0, rd};

				//подаем на первый вход записи памяти значение рс
				mem_W2_mux <= `pc_W2_mux;
		
				//записываем рс + 4 в регистр 
				mem_WE2 <= `sw;
		
				//подаем на входы АЛУ прошлое значение рс и константу
				ALU_mux_1 <= `old_pc_ALU_mux_1; 
				ALU_mux_2 <= `imm_ALU_mux_2;
				
				//складываем рс и константу 
				ALU_control <= ALU_control_dec;
				imm_control <= imm_control_dec;
				
				//записываем сумму в рс
				pc_WE <= 1;
		
				next_state <= `fetch;
				
			end
			
		`jalr_1 : begin 
		
				//подаем на второй адресный вход памяти адрес регистра направления
				mem_A2_mux <= `reg_A2_mux;
				mem_A2 <= {0, rd};

				//подаем на первый вход записи памяти значение рс
				mem_W2_mux <= `pc_W2_mux;
		
				//записываем рс + 4 в регистр 
				mem_WE2 <= `sw;
				
				//подаем на второй адресный вход памяти адрес первого регистра источника
				mem_A1_mux <= `reg_A1_mux;
				mem_A1 <= {0, rs1};
		
				next_state <= `jalr_2;
				
			end
			
		`jalr_2 : begin 
				
				//подаем на входы АЛУ значение региста и константу
				ALU_mux_1 <= `mem_R1_ALU_mux_1; 
				ALU_mux_2 <= `imm_ALU_mux_2;
				
				//складываем регистр и константу 
				ALU_control <= ALU_control_dec;
				imm_control <= imm_control_dec; 
				
				//записываем сумму в рс
				pc_WE <= 1;
				
				next_state <= `fetch;
				
			end
			
		`lui : begin 
				
				//подаем на второй адресный вход памяти адрес регистра направления
				mem_A1_mux <= `reg_A1_mux;
				mem_A1 <= {0, rd};
				
				//подаем константу на вход АЛУ
				ALU_mux_2 <= `imm_ALU_mux_2;
				
				imm_control <= imm_control_dec;				
				//константа проходит напрямую через АЛУ
				ALU_control <= ALU_control_dec;
				
				//подаем на первый вход записи памяти константу
				mem_W1_mux <= `ALU_out_W1_mux;
							
				//записываем константу в регистр 
				mem_WE1 <= `sw;
				
				next_state <= `fetch;
				
			end
			
		`auipc : begin 
			
				//подаем на второй адресный вход памяти адрес регистра направления
				mem_A1_mux <= `reg_A1_mux;
				mem_A1 <= {0, rd};
			
				//подаем на входы АЛУ прошлое значение рс и константу
				ALU_mux_1 <= `old_pc_ALU_mux_1; 
				ALU_mux_2 <= `imm_ALU_mux_2;
			
				//складываем рс и константу 
				imm_control <= imm_control_dec;
				ALU_control <= ALU_control_dec;
				
				//подаем на первый вход записи выход АЛУ
				mem_W1_mux <= `ALU_out_W1_mux;
							
				//записываем константу в регистр 
				mem_WE1 <= `sw;
				
				next_state <= `fetch;
				
			end
			
		default : next_state <= `fetch;
		
	endcase 

end


endmodule