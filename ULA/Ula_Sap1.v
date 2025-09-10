/******************************************************************************
 * Module: sap1_alu
 * Description: Unidade Lógica e Aritmética (ULA) para o computador SAP-1.
 * * Entradas:
 * A   		[7:0] - Operando vindo do Acumulador.
 * B   		[7:0] - Operando vindo do Registrador B.
 * SuB				- Sinal de controle de Subtração (0=Add, 1=Sub)
 * Not				- Sinal de controle de NOT/XOR   (0= NOT,1=XOR)
 * Alu_out  		- Sinal de habilitação da saída (1=Habilitado, 0=Alta Impedância).
 *	AL0 e AL1		- Sinais de Controle de operacoes da ULA
 *
 * * Saídas:
 * ALU_out [7:0] - Resultado de 8 bits da operação.
 ******************************************************************************/
module Ula_Sap1 (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire       Sub, 
	 input  wire       Not,	
    input  wire       ALU_out,
	 input  wire       AL0,
    input  wire       AL1, 
    output reg  [7:0] S
);
	// Fio interno para armazenar as opcoes de AL1 E AL0 de operacoes da ULA	
	wire [1:0] sel = {AL1, AL0};


	// Fio interno para armazenar o resultado da operação antes de ir para o buffer.
	wire [7:0] result;

	// Fio interno para o operando B modificado (para a subtração).
	// Se Sub=0 (ADD), B_modificado = B.
	// Se Sub=1 (SUB), B_modificado = ~B (complemento de um).
	wire [7:0] B_modified;
	assign B_modified = S ? ~B : B;
	 
	always @(*) begin
		 result = 8'bx; // 'x' significa "don't care", ajuda na depuração

		 case (sel)
			  2'b00: begin // Se AL1=0 e AL0=0 = Soma/Subtracao
					// Para a adição (Su=0): result = A + B + 0.
					// Para a subtração (Su=1): result = A + ~B + 1 (complemento de dois).
					// O sinal 'Sub' atua como o carry-in (Cin) para completar o complemento de dois.
					result = A + B_modified + Su;
			  end
			  2'b01: begin // Se AL1=0 e AL0=1 = AND
					result = A & B;
			  end
			  2'b10: begin // Se AL1=1 e AL0=0 = OR
					result = A | B;
			  end
			  2'b11: begin // Se AL1=1 e AL0=1 = XOR/NOT
					if (Not) begin 		// se not = 1 -- Resultado = Not (A)
						 result = ~A;
					end else begin			// se not = 0 -- Resultado = A XOR B
						 result = A ^ B;
					end
			  end
			  default: begin // Cobre todas as outras possibilidades (ex: 'x' ou 'z')
					result = 8'bx;
			  end
		 endcase
	end

	// Lógica do buffer tri-state para a saída principal.
	// A saída 'S' só é acionada quando 'ALU_out' é 1.
	// Caso contrário, fica em alta impedância (z).
	always @(*) begin
	  if (ALU_Out) begin
			S = result;
	  end else begin
			S = 8'hZZ; // Alta impedância
	  end
	end

endmodule