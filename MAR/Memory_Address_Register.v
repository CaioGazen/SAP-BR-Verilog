module Memory_Address_Register(
	input [3:0] MAR_ADDR_PROG,
	input [3:0] MAR_IN,
	input 		_MAR_PROG,
	input			_EN_MAR_IN,
	input			CLOCK,
	input			RESET,
	
	output reg [3:0]	MAR_OUT
);

	reg [3:0] addr;


	always @(posedge CLOCK) begin
		if (RESET)
			addr = 4'b0000;
		else if (~_EN_MAR_IN)
			addr = MAR_IN;
	end
	
	
	always @(*) begin
		if(_MAR_PROG)
			MAR_OUT = addr;
		else if(~_MAR_PROG)
			MAR_OUT = MAR_ADDR_PROG;
	end
	
endmodule