`timescale 1ns / 1ps

module grf(
	ReadReg1,ReadReg2,
	RegWrite,WriteEn,
	WData,RData1,
	RData2,clk,reset
    );
    //definition of ports
	input [4:0] ReadReg1;
	input [4:0] ReadReg2;
	input [4:0] RegWrite;
	input WriteEn;
	input clk;
	input reset;
	input [31:0] WData;
	output [31:0] RData1;
	output [31:0] RData2;

	//the GRF malloc
	reg [31:0] GRF [31:0];
	integer i;

	//initial GRF
	initial begin
		for(i=0;i<32;i=i+1)
			GRF[i] = 0;
	end

	//wire definition
	assign RData1 = (ReadReg1==RegWrite & RegWrite!=0 & WriteEn)?WData:GRF[ReadReg1]; 
	assign RData2 = (ReadReg2==RegWrite & RegWrite!=0 & WriteEn)?WData:GRF[ReadReg2];

	always@(posedge clk)begin
		if(reset)begin
			for(i=0;i<32;i=i+1)
				GRF[i] = 0;
		end
		else if(WriteEn)begin
			if(RegWrite!=0)
				GRF[RegWrite] <= WData;
			$display("$%d <= %h",RegWrite,WData);
		end
	end 	
endmodule