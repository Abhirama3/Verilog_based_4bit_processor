module instructionMem( input wire [3:0] instructionAddr, output reg [11:0] instruction);

	reg [11:0]ROM[0:15];
	
	initial
	begin
		$readmemb("program.mem", ROM);
	end
	
	always@(*)
	begin
		instruction = ROM[instructionAddr];
	end
	
endmodule
		
