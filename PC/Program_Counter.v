module Program_Counter(
	input [3:0] PC_IN,
	input 		PC_INC,
	input			CLOCK,
	input			_JMP,
	input			_RESET,
	input			_EN_PC_OUT,
	
	output reg [3:0] 	PC_OUT
);
//
	reg [3:0] Count;

	always @(posedge CLOCK) begin
		if (~_JMP)
			Count = PC_IN;
		else if (~_RESET )
			Count = 0;
		else if (PC_INC)
			Count = Count + 4'b0001;
	end
	

	always @(*) begin
		if (~_EN_PC_OUT) 
			PC_OUT = Count;
		else
			PC_OUT = 4'hZ;
	end
	
endmodule
