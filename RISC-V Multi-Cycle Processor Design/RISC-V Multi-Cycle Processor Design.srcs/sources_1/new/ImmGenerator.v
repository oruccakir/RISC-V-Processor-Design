`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2023 15:42:26
// Design Name: 
// Module Name: ImmGenerator
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

module ImmGenerator(
    input [31:0] instruction, 
    output [31:0] extendedImm
);

reg signed [31:0] result = 32'b0;
reg [3:0] instructionType;

InstructionControl circuit1(.instruction(instruction),
                 .whichInstruction(instructionType)
                 );

always @* begin

    case(instructionType)
    
        4'b0010: // JAL
            begin
                result[20] = instruction[31];
                result[19:12] = instruction[19:12];
                result[11] = instruction[20];
                result[10:1] = instruction[30:21];
                if(result[20] == 0)
                    result[31:21] = 11'b00000000000;
                else
                    result[31:21] = 11'b11111111111;
            end
            
        4'b0011: // JALR
            begin
                result[11:0] = instruction[31:20];
                if(result[11] == 0)
                    result[31:12] = 20'b0000000000000000000;
                else
                    result[31:12] = 20'b11111111111111111111;
            end
        
        4'b0011: // BEQ
            begin
                result[12] = instruction[31];
                result[11] = instruction[7];
                result[10:5] = instruction[30:25];
                result[4:1] = instruction[11:8];
                if(result[12] == 0)
                    result[31:13] = 19'b0000000000000000000;
                else
                    result[31:13] = 19'b1111111111111111111;
            end
        
        4'b0100: // BNE
            begin
                result[12] = instruction[31];
                result[11] = instruction[7];
                result[10:5] = instruction[30:25];
                result[4:1] = instruction[11:8];
                if(result[12] == 0)
                    result[31:13] = 19'b0000000000000000000;
                else
                    result[31:13] = 19'b1111111111111111111;
            end
         
         4'b0110: // BLT
            begin
                result[12] = instruction[31];
                result[11] = instruction[7];
                result[10:5] = instruction[30:25];
                result[4:1] = instruction[11:8];
                if(result[12] == 0)
                    result[31:13] = 19'b0000000000000000000;
                else
                    result[31:13] = 19'b1111111111111111111;    
            end
            
         4'b0111: // LW
            begin
                result[11:0] = instruction[31:20];
                if(result[11] == 0)
                    result[31:12] = 20'b0000000000000000000;
                else
                    result[31:12] = 20'b11111111111111111111;
            end
         
         4'b1000: // SW
            begin
                result[11:5] = instruction[31:25];
                result[4:0] = instruction[11:7];
                if(result[11] == 0)
                    result[31:12] = 20'b0000000000000000000;
                else
                    result[31:12] = 20'b11111111111111111111; 
 
            end
         
         4'b1001: // ADDI
            begin
                result[11:0] = instruction[31:20];
                if(result[11] == 0)
                    result[31:12] = 20'b0000000000000000000;
                else
                    result[31:12] = 20'b11111111111111111111;
            end
        
        
    endcase
            
end

assign extendedImm = result;

endmodule