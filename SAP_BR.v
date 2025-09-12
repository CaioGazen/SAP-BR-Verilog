module SAP_BR(
	input [3:0] MAR_ADDR_PROG,
	input [7:0] RAM_PROG_DATA,
	input			WR_PROG,
	input 		PROG,
	input			HALT,
	input			CLOCK_IN,
	input 		BTN_RESET,
	
	output [7:0]	OR_OUT,
	output [7:0]	A_OUT_DEBUG,
	output [7:0]	B_OUT_DEBUG,
	output [3:0]	MAR_ADDR_DEBUG,
	
	output [7:0] 	BUS_DEBUG,
	output CLOCK_DEBUG,
	output HLT, PC_INC, JMP, PC_OUT, MAR_IN, RAM_IN, RAM_OUT, IR_IN, IR_OUT, ACC_OUT, ACC_IN, SUB, AL_1, AL_0, ALU_OUT, NOT, BR_IN, OPR_IN
);

	wire HLT_IN;
	wire CLOCK, RESET, _RESET;
	assign CLOCK_DEBUG = CLOCK;
	
	
	wire [7:0] BUS;
	assign BUS_DEBUG = BUS;
	
	assign HLT_IN = (PROG || HALT || HLT);
	
	
	Control Control(CLOCK_IN, HLT_IN, BTN_RESET, CTRL_IN, CLOCK, RESET, _RESET, HLT, PC_INC, JMP, PC_OUT, MAR_IN, RAM_IN, RAM_OUT, IR_IN, IR_OUT, ACC_OUT, ACC_IN, SUB, AL_1, AL_0, ALU_OUT, NOT, BR_IN, OPR_IN);
	
	wire [7:0] IR_OUT_DATA;
	wire [3:0] CTRL_IN;
	
	assign CTRL_IN[3:0] = IR_OUT_DATA[7:4];
	assign BUS[3:0] = IR_OUT_DATA[3:0];
	
	Instruction_Register Instruction_Register(BUS, ~IR_IN, ~IR_OUT, CLOCK, RESET, IR_OUT_DATA);
	
	Program_Counter Program_Counter (BUS[3:0], PC_INC, CLOCK, ~JMP, _RESET, ~PC_OUT, BUS[3:0]);
	
	
	wire [3:0] MAR_ADDR;
	assign MAR_ADDR_DEBUG = MAR_ADDR;
	
	Memory_Address_Register Memory_Address_Register(MAR_ADDR_PROG, BUS[3:0], ~PROG, ~MAR_IN, CLOCK, RESET, MAR_ADDR);
	
	Random_Access_Memory Random_Access_Memory(BUS, RAM_PROG_DATA, MAR_ADDR, ~PROG, WR_PROG, RAM_IN, RAM_OUT, CLOCK, BUS);
	
	
	wire [7:0] ACC_OUT_ULA;
	wire [7:0] BR_OUT;
	assign A_OUT_DEBUG = ACC_OUT_ULA;
	assign B_OUT_DEBUG = BR_OUT;
	
	
	A_Register A_Register(BUS, ~ACC_IN, ~ACC_OUT, CLOCK, RESET, BUS, ACC_OUT_ULA);
	
	B_Register B_Register(BUS, ~BR_IN, CLOCK, RESET, BR_OUT);
	
	ULA ULA (ACC_OUT_ULA, BR_OUT, SUB, NOT, ALU_OUT, AL_0, AL_1, BUS);
	
	
	Output_Register Output_Register(BUS, ~OPR_IN, CLOCK, RESET, OR_OUT);


endmodule