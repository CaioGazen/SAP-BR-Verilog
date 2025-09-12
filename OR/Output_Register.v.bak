module B_Register(
	input [7:0] BR_IN,
	input			_EN_BR_IN,	
	input			CLOCK,
	input			RESET,
	
	output reg [7:0]	BR_OUT
);



	always @(posedge CLOCK) begin
		if (RESET)
			BR_OUT = 8'h00;
		else if (~_EN_BR_IN)
			BR_OUT = BR_IN;
	end
	
endmodule