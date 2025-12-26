module ALU4bit(input wire [2:0]opcode, input wire [3:0]A,B, output reg Co, OF, Z, output reg [3:0]Result); 

	always@(*)
	begin
		Result=4'b0000; Co=1'b0; OF=1'b0;
		
		case(opcode)
		
		0: begin   {Co,Result} = (A+B);   OF= (A[3]==B[3])&&(Result[3]!=A[3]);   end
		1: begin   {Co,Result} = (A-B);   OF = (A[3]!=B[3]) && (Result[3] != A[3]);   end 
		2: begin   {Co,Result} = (A+4'b0001);   OF = (~A[3] & Result[3]);   end
		3: begin   {Co,Result} = (A+4'b1111);   OF = (A[3] & ~Result[3]);   end
		4: begin   Result = (A&B);   end
		5: begin   Result = (A|B);   end
		6: begin   Result = (A^B);   end
		7: begin   Result = ( ~(A^B) );   end
		default: begin   Result = 4'b0000;   end

		
		endcase
		
		Z = (Result==4'b0000);
		
	end

endmodule
