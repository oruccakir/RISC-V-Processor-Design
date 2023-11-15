`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2023 10:03:50
// Design Name: 
// Module Name: ALU
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


//////////////////////////ALU DESIGN//////////////////////////////////////////////////

module ALU(
    
    input [1:0] process,
    input [`VERI_BIT-1:0] input1,
    input [`VERI_BIT-1:0] input2,
    output [`VERI_BIT-1:0] output1,
    output isEqual
    
);

localparam ADD      = 2'b00;
localparam SUBTRACT = 2'b01;
localparam COMPARE  = 2'b10;

reg [`VERI_BIT-1:0] processResult;
reg compareResult;

always @* begin

    case(process)
    
        ADD:
            begin
                processResult = input1 + input2;
            end
            
        SUBTRACT:
            begin
                processResult = input1 - input2;
            end
        
        COMPARE:
            begin
                compareResult = (input1 == input2) ? 1 : 0;
            end
      
      endcase

end

assign output1 = processResult;
assign isEqual = compareResult;

endmodule


//////////////////////////ALU DESIGN//////////////////////////////////////////////////
