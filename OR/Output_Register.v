module Output_Register(
	input [7:0] OR_IN,
	input			_EN_OR_IN,	
	input			CLOCK,
	input			RESET,
	
	output reg [7:0]	OR_OUT
);



	always @(posedge CLOCK) begin
		if (RESET)
			OR_OUT = 8'h00;
		else if (~_EN_OR_IN)
			OR_OUT = OR_IN;
	end
	
endmodule