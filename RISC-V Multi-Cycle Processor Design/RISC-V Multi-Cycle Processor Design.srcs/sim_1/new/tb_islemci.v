`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2023 21:17:42
// Design Name: 
// Module Name: tb_islemci
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

module tb_islemci(

    );

reg clk;
reg [31:0] instruction;
reg rst;
wire [`ADRES_BIT-1:0] bellek_adres;
wire [`VERI_BIT-1:0] bellek_oku_veri;
wire [`VERI_BIT-1:0] bellek_yaz_veri;
wire bellek_yaz;
reg [31:0] index;

// Instantiate the module
islemci uut (
    .instruction(instruction),
    .clk(clk),
    .rst(rst),
    .bellek_adres(bellek_adres),
    .bellek_oku_veri(bellek_oku_veri),
    .bellek_yaz_veri(bellek_yaz_veri),
    .bellek_yaz(bellek_yaz)
);

localparam insADD = 32'b0000000_00000_00001_000_00010_0110011;
localparam insADD1 = 32'b00000001110011101000110110110011;
localparam insSUB = 32'b0100000_00000_00010_000_00011_0110011;
localparam insSUB1 = 32'b01000001110011101000110110110011;
localparam insADDI = 32'b00000010000_00011_000_00100_0010011;
localparam insOR = 32'b0000000_00000_00001_110_00101_0110011;
localparam insAND = 32'b0000000_00000_00001_111_00110_0110011;
localparam insXOR = 32'b0000000_00000_00001_100_00111_0110011;
localparam insLUI = 32'b00000000000000000001_01000_0110111;
localparam insLUI1 = 32'b10000000000000000001_11111_0110111;
localparam insLUI2 = 32'b11000000000000000000_11110_0110111;
localparam insLUI3 = 32'b00000000000000000000111010110111;
localparam insLUI4 = 32'b00000000000000000001111000110111;
localparam insAUIPC = 32'b00000000000000000001_01001_0010111;
localparam insBEQ = 32'b0000000_11111_11110_000_01000_1100011;

reg signed [31:0] memory [0:31];

always begin
    clk=~clk;
    #5;
end


// Test scenario
initial begin

    memory[0] = insLUI1;  //x31
    memory[1] = insLUI2;  //x30
    memory[2] = insLUI3;  //x29
    memory[3] = insLUI4;  //x28
    memory[4] = insBEQ;   //x30 x31
    memory[5] = insADD1;  //x27,x29,x28
    memory[6] = insSUB1;  //X27,X29,X28
    
    
    clk = 0;
    #5;
      
    
    rst=1;
    #10;
    
   
    
    rst=0; 
    index = (uut.ps_r - 2147483648) / 4;
    $display(index);
    instruction=memory[index];
    #20;
    
    
    index = (uut.ps_r - 2147483648) / 4;
    $display(index);
    instruction=memory[index];
    #30;
    
    index = (uut.ps_r - 2147483648) / 4;
    $display(index);
    instruction=memory[index];
    #30;
    
    index = (uut.ps_r - 2147483648) / 4;
    $display(index);
    instruction=memory[index];
    #30;
    
    
    index = (uut.ps_r - 2147483648) / 4;
    $display(index);
    instruction=memory[index];
    #30;
    
    
    index = (uut.ps_r - 2147483648) / 4;
    $display(index);
    instruction=memory[index];
    #30;
    
     
    
    /*
    
    $display(uut.ps_r);
    $display(index);
    instruction=insLUI1;
    #20;
    
    $display(uut.ps_r);
    #10;
    instruction=insLUI2;
    #20;
    
    $display(uut.ps_r);
    #10;
    instruction=insBEQ;
    #20;
    */
    
    
    /*
    // Provide an instruction
    instruction = insADD;
    #10;
    #10;


    // Provide an instruction
    #10;
    instruction =  insSUB;
    #10;
    #10;
    
    #10;
    instruction=insADDI;
    #10;
    #10;
    
    #10;
    instruction=insOR;
    #10;
    #10;
    
    #10;
    instruction=insAND;
    #10;
    #10;
    
    #10;
    instruction=insXOR;
    #10;
    #10;
    
    #10;
    instruction=insLUI;
    #10;
    #10;
    
    #10;
    instruction=insAUIPC;
    #10;
    #10;
    */
    
end

endmodule
