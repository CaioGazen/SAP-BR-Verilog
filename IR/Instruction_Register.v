module Instruction_Register(
	input [7:0] IR_IN,
	input			_EN_IR_IN,	
	input			_EN_IR_OUT,	
	input			CLOCK,
	input			RESET,
	
	output reg [7:0]	IR_OUT
);

	reg [7:0] Mem;



	always @(posedge CLOCK) begin
		if (RESET)
			Mem = 8'h00;
		else if (~_EN_IR_IN)
			Mem = IR_IN;
	end

	always @(*) begin
		if (_EN_IR_OUT)
			IR_OUT[7:4] = 4'hZ;
		else
			IR_OUT[7:4] = Mem[7:4];
			
		IR_OUT[3:0] = Mem[3:0];
	end 


endmodule