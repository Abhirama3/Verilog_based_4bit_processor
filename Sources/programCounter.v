module programCounter( input wire clk, rst, pcEn, output reg [3:0] instructionAddr);
	
	always@(posedge clk)
	begin
		
		if(rst)
			instructionAddr <= 4'b0000;
			
		else if(pcEn)
			instructionAddr <= instructionAddr + 1'b1;
	end
  
endmodule
