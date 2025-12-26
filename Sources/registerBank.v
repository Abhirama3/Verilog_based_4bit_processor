module registerBank( input wire clk, rst, readEn, writeEn, input wire [3:0] writeData, input wire [3:0] addressBus, output reg [3:0] readData);
	
    reg [3:0]regBank[0:15];
	integer i;

	always@(posedge clk)
	begin
	
		if(rst)
			for(i=0; i<=15; i=i+1)
				regBank[i] <= 4'b0000;
			
		else
		begin
			if (writeEn)
				regBank[addressBus] <= writeData;

			if (readEn)
				readData <= writeEn ? writeData : regBank[addressBus];
		end

	end	
    
endmodule
