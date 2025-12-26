`timescale 1ns/1ps

module processor16X4_TB();

    reg clk, rst;
    reg [11:0] instructionReg;
    wire [3:0] resultReg;

    processor16X4 uut(.clk(clk), .rst(rst), .instructionReg(instructionReg), .resultReg(resultReg) );

    // Clock: 10ns period
    always #5 clk = ~clk;

    initial
    begin       
        clk = 0;
        rst = 1;
        instructionReg = 12'b0_000_0000_0000;

        #20 rst = 0;

        instructionReg = 12'b1_000_0000_0011; //MOV R0, #0x03
        #60 instructionReg = 12'b1_000_0001_0101; //MOV R1, #0x05
		#60 instructionReg = 12'b1_000_0010_0111; //MOV R2, #0x07
		#60 instructionReg = 12'b1_000_1110_1111; //MOV R14, #0x0F
		#60 instructionReg = 12'b1_000_1111_1010; //MOV R15, #0x0A
		
        #60 instructionReg = 12'b0_000_0001_0000; //ADD R1, R0 
        #80 instructionReg = 12'b0_001_0001_0010; //SUB R1, R2
		#80 instructionReg = 12'b0_100_0001_1111; //AND R1, R15
		#80 instructionReg = 12'b0_110_1110_0010; //XOR R14, R2
        #80 $stop;
		
    end

endmodule
