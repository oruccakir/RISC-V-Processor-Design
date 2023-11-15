`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2023 15:47:46
// Design Name: 
// Module Name: InstructionControl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`define LUI             4'b0000;
`define AUIPC           4'b0001;
`define JAL             4'b0010;
`define JALR            4'b0011;
`define BEQ             4'b0100;
`define BNE             4'b0101;
`define BLT             4'b0110;
`define LW              4'b0111;
`define SW              4'b1000;
`define ADDI            4'b1001;
`define ADD             4'b1010;
`define SUB             4'b1011;
`define OR              4'b1100;
`define AND             4'b1101;
`define XOR             4'b1110;


module InstructionControl(
    input [31:0] instruction,
    output [3:0] whichInstruction,
    output [31:0] extendedImm
);

reg [31:0] immResult=-1;
reg [3:0] result;
reg [6:0] opcode;
reg [2:0] funct3;
reg [6:0] funct7;

always @* begin

     opcode=instruction [6:0];
     funct3=instruction [14:12];
     funct7=instruction [31:25];
     
     case(opcode)
        
        7'b0110111: result=`LUI
        
        7'b0010111: result=`AUIPC
        
        7'b1101111: 
            begin
                result=`JAL
                 $display("MxT");
                immResult[20] = instruction[31];
                immResult[19:12] = instruction[19:12];
                immResult[11] = instruction[20];
                immResult[10:1] = instruction[30:21];
                if(immResult[20] == 0)
                    immResult[31:21] = 11'b00000000000;
                else
                    immResult[31:21] = 11'b11111111111;
            end
        
        7'b1100111:
            begin
                result=`JALR
                immResult[11:0] = instruction[31:20];
                if(immResult[11] == 0)
                    immResult[31:12] = 20'b0000000000000000000;
                else
                    immResult[31:12] = 20'b11111111111111111111;
            end
        
        7'b1100011:
            begin
                if(funct3 == 3'b000)
                    result=`BEQ
                else if(funct3 == 3'b001)
                    result=`BNE
                else if(funct3 == 3'b100)
                    result=`BLT
                 
                immResult[12] = instruction[31];
                immResult[11] = instruction[7];
                immResult[10:5] = instruction[30:25];
                immResult[4:1] = instruction[11:8];
                if(immResult[12] == 0)
                    immResult[31:13] = 19'b0000000000000000000;
                else
                    immResult[31:13] = 19'b1111111111111111111; 
                 
            end
            
         7'b0000011: 
            begin
                result=`LW
                immResult[11:0] = instruction[31:20];
                if(immResult[11] == 0)
                    immResult[31:12] = 20'b0000000000000000000;
                else
                    immResult[31:12] = 20'b11111111111111111111;
            end
            
         7'b0100011:
            begin
                 result=`SW
                 immResult[11:5] = instruction[31:25];
                 immResult[4:0] = instruction[11:7];
                 if(immResult[11] == 0)
                     immResult[31:12] = 20'b0000000000000000000;
                 else
                     immResult[31:12] = 20'b11111111111111111111; 
            end 
            
         
         7'b0010011:
            begin
                result=`ADDI
                immResult[11:0] = instruction[31:20];
                if(immResult[11] == 0)
                    immResult[31:12] = 20'b0000000000000000000;
                else
                    immResult[31:12] = 20'b11111111111111111111;
            end
         
         7'b0110011:
            begin
                $display("MOST");
                if(funct3 == 3'b000)
                    begin
                        if(funct7 == 7'b0000000)
                            result=`ADD
                        else if(funct7 == 7'b0100000)
                            result=`SUB
                    end
                else if(funct3 == 3'b110)
                    result=`OR
                else if(funct3 == 3'b111)
                    result=`AND
                else if(funct3 == 3'b100)
                    result=`XOR
                    
            end
         
         endcase
         
end

assign whichInstruction = result;
assign extendedImm = immResult;

endmodule
