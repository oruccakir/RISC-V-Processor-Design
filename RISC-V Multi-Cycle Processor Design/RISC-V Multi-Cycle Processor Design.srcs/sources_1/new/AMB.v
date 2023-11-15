`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2023 10:50:22
// Design Name: 
// Module Name: AMB
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
`define BELLEK_ADRES    32'h8000_0000
`define VERI_BIT        32
`define ADRES_BIT       32
`define YAZMAC_SAYISI   32

module AMB(

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
