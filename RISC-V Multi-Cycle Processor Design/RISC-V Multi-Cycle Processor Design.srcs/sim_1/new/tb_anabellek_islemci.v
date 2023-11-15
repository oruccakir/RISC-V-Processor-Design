`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.11.2023 10:56:37
// Design Name: 
// Module Name: tb_anabellek_islemci
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

module tb_anabellek_islemci(

    );
    
reg clk;   // input for iþlemci and memory
reg rst;
wire [`ADRES_BIT-1:0] bellek_adres;  // output for iþlemci input for memory
reg [`VERI_BIT-1:0] bellek_oku_veri;  // input for iþlemci output for memory
wire  [`VERI_BIT-1:0] oku_veri;
wire [`VERI_BIT-1:0] bellek_yaz_veri; // output fot iþlemci input for memory
wire bellek_yaz;
   
   
islemci processor (
    .clk(clk),
    .rst(rst),
    .bellek_adres(bellek_adres),
    .bellek_oku_veri(oku_veri),
    .bellek_yaz_veri(bellek_yaz_veri),
    .bellek_yaz(bellek_yaz)
);


anabellek memory(
    .clk(clk),
    .adres(bellek_adres),
    .oku_veri(oku_veri),
    .yaz_veri(bellek_yaz_veri),
    .yaz_gecerli(bellek_yaz)

);
  
always begin
    clk=~clk;
    #5;
end

integer i=0;
initial begin
   
    clk = 0;
    
    rst=1;
    #30;
    rst=0;    
    
    
    
    
    
    
    
        
end
    
    
endmodule
