`timescale 10ns/10ns

module processor16X4_TB();

    reg clk, rst;
    wire [3:0]resultReg;
    
    processor16X4 uut(.clk(clk), .rst(rst), .resultReg(resultReg));

    initial
    begin       
        clk = 0;
        rst = 1;
        #20 rst = 0;		
    end
	
	 // Clock: 100ns period
    always #5 clk = ~clk;

endmodule
