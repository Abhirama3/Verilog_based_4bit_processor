module processor16X4(input wire clk, rst, output reg [3:0]resultReg);

    reg [3:0]dataBus;
    reg [3:0]ramreadData;
    reg [3:0]addressBus;
    reg readEn, writeEn;

	reg [3:0]A, B;
    reg [2:0]opcode;
    reg [3:0]aluResult;
    reg Co, OF, Z;
	
	reg [3:0]PC;
	reg pcEn, pcEn_next;
	reg [11:0]instructionReg;

    registerBank regBank1( .clk(clk), .rst(rst), .readEn(readEn), .writeEn(writeEn), .writeData(dataBus), .addressBus(addressBus), .readData(ramreadData) );

    ALU4bit alu1( .opcode(opcode), .A(A), .B(B), .Co(Co), .OF(OF), .Z(Z), .Result(aluResult) );
	
	programCounter pc1( .clk(clk), .rst(rst), .pcEn(pcEn), .instructionAddr(PC) );
	
	instructionMem rom1( .instructionAddr(PC), .instruction(instructionReg) );

    localparam  S_IDLE      = 4'b0000,
                S_DECODE    = 4'b0001,
                S_MOV       = 4'b0010,
                S_LATCH_OP  = 4'b0100,
                S_FETCH_A   = 4'b0101,
                S_FETCH_B   = 4'b0110,
                S_EXECUTE   = 4'b0111,
                S_WRITEBACK= 4'b1000;
				
    reg [3:0] S_present, S_next;

 
 
 
 
    always @(posedge clk or posedge rst)
	begin
	
		if (rst)
		begin
			S_present <= S_IDLE;
			pcEn <= 1'b0;
			A <= 4'b0000;
			B <= 4'b0000;
			opcode <= 3'b000;
			resultReg <= 4'b0000;
		end
		
		else
		begin
			S_present <= S_next;
			pcEn <= pcEn_next;

			case (S_present)
				S_LATCH_OP: opcode <= instructionReg[10:8];
				S_FETCH_A:  A <= ramreadData;
				S_FETCH_B:  B <= ramreadData;
				S_EXECUTE:  resultReg <= aluResult;
			endcase
		end			
		
	end





    always @(*)
    begin
        writeEn = 1'b0;
        readEn = 1'b0;
        dataBus = 4'b0000;
        addressBus = 4'b0000;
        S_next = S_present;
		pcEn_next = 1'b0;

        case(S_present)
        
			S_IDLE:
			begin
				S_next = S_DECODE;
			end
			
			S_DECODE:
			begin
				S_next = (instructionReg[11]) ? S_MOV : S_LATCH_OP;
			end

			S_MOV:
			begin
				writeEn = 1;
				addressBus = instructionReg[7:4];
				dataBus = instructionReg[3:0];
				pcEn_next = 1'b1;
				S_next = S_IDLE;
			end

			S_LATCH_OP:
			begin
				addressBus = instructionReg[7:4];
				readEn = 1;
				S_next = S_FETCH_A;
			end

			S_FETCH_A:
			begin
				addressBus = instructionReg[3:0];
				readEn = 1;
				S_next = S_FETCH_B;
			end

			S_FETCH_B:
				S_next = S_EXECUTE;

			S_EXECUTE:
				S_next = S_WRITEBACK;

			S_WRITEBACK:
			begin
				writeEn = 1;
				addressBus = instructionReg[7:4];
				dataBus = resultReg;
				pcEn_next = 1'b1;
				S_next = S_IDLE;
			end

			default:
				S_next = S_IDLE;

        endcase
    end

endmodule
