module Random_Access_Memory(
	input [7:0] RAM_IN,
	input [7:0] RAM_PROG_DATA,
	input [3:0] ADDR_IN,
	input 		_RAM_PROG,
	input			WR_PROG,
	input			EN_RAM_IN,	
	input			EN_RAM_OUT,
	input			CLOCK,
	
	output reg [7:0]	RAM_OUT
);

	reg [7:0] Memory [0:15];
	
	wire CLOCK_WR;
	
	assign CLOCK_WR = (CLOCK || WR_PROG);
	
	always @(posedge CLOCK_WR) begin
		if (_RAM_PROG & EN_RAM_IN)
			Memory[ADDR_IN] <= RAM_IN;
		else if(~_RAM_PROG & WR_PROG)
			Memory[ADDR_IN] <= RAM_PROG_DATA;
	end
	
	always @(*) begin
		if (EN_RAM_OUT) 
			RAM_OUT = Memory[ADDR_IN];
		else
			RAM_OUT = 8'hZZ;
	end
	
endmodule