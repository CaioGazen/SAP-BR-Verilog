module Control(
	input CLOCK_AUTO,
	input HLT_IN,
	input BTN_RESET,
	input [3:0] CTRL_IN,
	
	output CLOCK,
	output RESET,
	output _RESET,
	//output [17:0]	EEPROM_OUT
	//output reg [2:0] counter
	
	output HLT,
	output PC_INC,
	output JMP,
	output PC_OUT,
	output MAR_IN,
	output RAM_IN,
	output RAM_OUT,
	output IR_IN,
	output IR_OUT,
	output ACC_OUT,
	output ACC_IN,
	output SUB,
	output AL_1,
	output AL_0,
	output ALU_OUT,
	output NOT,
	output BR_IN,
	output OPR_IN
);
	
	assign CLOCK = (CLOCK_AUTO & ~HLT_IN);
	
	assign RESET = BTN_RESET;
	assign _RESET = ~BTN_RESET;
	
	wire _CYCLE_RST;
	assign _CYCLE_RST = ~BTN_RESET;
	
	reg [2:0] 	counter; 
	wire [17:0]	EEPROM_OUT;

	
	always @(negedge CLOCK) begin
		if (~_CYCLE_RST || counter == 4)
			counter = 0;
		else
			counter = counter + 1;
	end
	
	wire [6:0] Address;
	
	assign Address[6:3] = CTRL_IN;
	assign Address[2:0] = counter;
	
	
	EEPROM inst (Address, EEPROM_OUT);
	
	// Desmembrando o sinal EEPROM_OUT nas 18 saídas individuais
	assign HLT = EEPROM_OUT[17];
	assign PC_INC = EEPROM_OUT[16];
	assign JMP = EEPROM_OUT[15];
	assign PC_OUT = EEPROM_OUT[14];
	assign MAR_IN = EEPROM_OUT[13];
	assign RAM_IN = EEPROM_OUT[12];
	assign RAM_OUT = EEPROM_OUT[11];
	assign IR_IN = EEPROM_OUT[10];
	assign IR_OUT = EEPROM_OUT[9];
	assign ACC_OUT = EEPROM_OUT[8];
	assign ACC_IN = EEPROM_OUT[7];
	assign SUB = EEPROM_OUT[6];
	assign AL_1 = EEPROM_OUT[5];
	assign AL_0 = EEPROM_OUT[4];
	assign ALU_OUT = EEPROM_OUT[3];
	assign NOT = EEPROM_OUT[2];
	assign BR_IN = EEPROM_OUT[1];
	assign OPR_IN = EEPROM_OUT[0];
	

endmodule
