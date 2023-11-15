`timescale 1ns/1ps

`define BELLEK_ADRES    32'h8000_0000
`define VERI_BIT        32
`define ADRES_BIT       32
`define YAZMAC_SAYISI   32


module islemci (
    input                       clk,
    input                       rst,
    output reg [`ADRES_BIT-1:0]    bellek_adres,
    input      [`VERI_BIT-1:0]     bellek_oku_veri,
    output reg [`VERI_BIT-1:0]     bellek_yaz_veri,
    output reg                     bellek_yaz
);


localparam LUI      =       4'b0000;
localparam AUIPC    =       4'b0001;
localparam JAL      =       4'b0010;
localparam JALR     =       4'b0011;
localparam BEQ      =       4'b0100;
localparam BNE      =       4'b0101;
localparam BLT      =       4'b0110;
localparam LW       =       4'b0111;
localparam SW       =       4'b1000;
localparam ADDI     =       4'b1001;
localparam ADD      =       4'b1010;
localparam SUB      =       4'b1011;
localparam OR       =       4'b1100;
localparam AND      =       4'b1101;
localparam XOR      =       4'b1110;

localparam GETIR        = 2'd0;
localparam COZYAZMACOKU = 2'd1;
localparam YURUTGERIYAZ = 2'd2;

reg [4:0] register1;
reg [4:0] register2;
reg [4:0] dest_register;

reg [3:0] whichInstruction;
reg [31:0] instruction=0;

reg signed [31:0] extendedImm;
reg signed [19:0] unExtendedImm;

reg [6:0] opcode;
reg [2:0] funct3;
reg [6:0] funct7;

reg signed[31:0] offset;

reg [1:0] simdiki_asama_r;
reg signed [`VERI_BIT-1:0] yazmac_obegi [0:`YAZMAC_SAYISI-1];
reg [`ADRES_BIT-1:0] ps_r;
reg [`ADRES_BIT-1:0] current_ps_r;

integer i=0;
initial begin
    for(i=0; i<`YAZMAC_SAYISI; i=i+1)
        yazmac_obegi[i] = 0;
end

always @(posedge clk) begin

    if (rst) begin
        ps_r = `BELLEK_ADRES;
        simdiki_asama_r = GETIR;
        current_ps_r= ps_r;
        bellek_adres = ps_r;
    end
    else begin
    
        case(simdiki_asama_r)
            
            GETIR:
                begin
                    bellek_yaz = 1'b0; // I am not sure this line of code
                    simdiki_asama_r = COZYAZMACOKU;
                    instruction = bellek_oku_veri;
                    current_ps_r=ps_r;
                    ps_r = ps_r + 4;
                    bellek_adres = ps_r;
                end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
           COZYAZMACOKU:
                begin
                    
                    opcode=instruction [6:0];
                    funct3=instruction [14:12];
                    funct7=instruction [31:25];
                    
                    dest_register = instruction[11:7];
                    register1 = instruction[19:15];
                    register2 = instruction[24:20];
                    
                    simdiki_asama_r = YURUTGERIYAZ;
                    
                    case(opcode)
        
                        7'b0110111: 
                            begin
                                whichInstruction=LUI;
                                unExtendedImm = instruction[31:12];
                            end
                        
                        7'b0010111:
                            begin
                                whichInstruction=AUIPC;
                                unExtendedImm = instruction[31:12];
                            end
                        
                        7'b1101111: 
                            begin
                                whichInstruction=JAL;
                                extendedImm[20] = instruction[31];
                                extendedImm[19:12] = instruction[19:12];
                                extendedImm[11] = instruction[20];
                                extendedImm[10:1] = instruction[30:21];
                                extendedImm[0] = 0; // not sure but it works okey
                                if(extendedImm[20] == 0)
                                    extendedImm[31:21] = 11'b00000000000;
                                else
                                    extendedImm[31:21] = 11'b11111111111;
                                    
                            end
                        
                        7'b1100111:
                            begin
                                whichInstruction=JALR;
                                extendedImm[11:0] = instruction[31:20];
                                if(extendedImm[11] == 0)
                                    extendedImm[31:12] = 20'b0000000000000000000;
                                else
                                    extendedImm[31:12] = 20'b11111111111111111111;
                            end
                        
                        7'b1100011:
                            begin
                                if(funct3 == 3'b000)
                                    whichInstruction=BEQ;
                                else if(funct3 == 3'b001)
                                    whichInstruction=BNE;
                                else if(funct3 == 3'b100)
                                    whichInstruction=BLT;
                                    
                                extendedImm[12] = instruction[31];
                                extendedImm[11] = instruction[7];
                                extendedImm[10:5] = instruction[30:25];
                                extendedImm[4:1] = instruction[11:8];
                                extendedImm[0] = 1'b0;                        // This line of code very importanrt pay attention to this
                                if(extendedImm[12] == 0)
                                    extendedImm[31:13] = 19'b0000000000000000000;
                                else
                                    extendedImm[31:13] = 19'b1111111111111111111;    
                            end
                            
                         7'b0000011: 
                            begin
                                 whichInstruction=LW;
                                 extendedImm[11:0] = instruction[31:20];
                                 if(extendedImm[11] == 0)
                                    extendedImm[31:12] = 20'b0000000000000000000;
                                 else
                                    extendedImm[31:12] = 20'b11111111111111111111;
                                    
                                 bellek_adres = yazmac_obegi[register1] + extendedImm; 
                            end
                           
                         7'b0100011: 
                            begin
                                whichInstruction=SW;
                                extendedImm[11:5] = instruction[31:25];
                                extendedImm[4:0] = instruction[11:7];
                                if(extendedImm[11] == 0)
                                    extendedImm[31:12] = 20'b0000000000000000000;
                                else
                                    extendedImm[31:12] = 20'b11111111111111111111; 
                                    
                                bellek_adres = yazmac_obegi[register1] + extendedImm; 
                                bellek_yaz = 1'b1;
                                bellek_yaz_veri = yazmac_obegi[register2];
                      
                            end
                         
                         7'b0010011:
                            begin
                                whichInstruction=ADDI;
                                extendedImm[11:0] = instruction[31:20];
                                if(extendedImm[11] == 0)
                                    extendedImm[31:12] = 20'b0000000000000000000;
                                else
                                    extendedImm[31:12] = 20'b11111111111111111111;
                            end
                         
                         7'b0110011:
                            begin
                                if(funct3 == 3'b000)
                                    begin
                                        if(funct7 == 7'b0000000)
                                            whichInstruction=ADD;
                                        else if(funct7 == 7'b0100000)
                                            whichInstruction=SUB;
                                    end
                                else if(funct3 == 3'b110)
                                    whichInstruction=OR;
                                else if(funct3 == 3'b111)
                                    whichInstruction=AND;
                                else if(funct3 == 3'b100)
                                    whichInstruction=XOR;
                            end
         
                    endcase
                    
                end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            YURUTGERIYAZ:
                begin
                
                    bellek_yaz = 1'b0; // I am not sure this line of code
                    
                    simdiki_asama_r = GETIR;
                    
                    case(whichInstruction)

                       LUI:
                            begin
                                yazmac_obegi[dest_register][31:12] = unExtendedImm;
                                yazmac_obegi[dest_register][11:0] = 12'b000000000000;
                            end
                       
                       AUIPC:
                            begin
                                offset[31:12] = unExtendedImm;
                                offset[11:0] = 12'b00000000000;
                                yazmac_obegi[dest_register] = ps_r -4 + offset;
                            end
                       
                       JAL:
                            begin
                                yazmac_obegi[dest_register] = ps_r;
                                ps_r = ps_r -4 + extendedImm;
                                bellek_adres = ps_r;
                            end
                            
                       JALR:
                            begin
                                yazmac_obegi[dest_register] = ps_r;
                                ps_r = yazmac_obegi[register1] + extendedImm[11:0];
                                ps_r[0] = 1'b0;
                                bellek_adres = ps_r;
                            end
                       
                       BEQ:
                            begin
                                if(yazmac_obegi[register1] != yazmac_obegi[register2])
                                    begin
                                        ps_r = ps_r -4 + extendedImm;
                                    end
                                bellek_adres = ps_r;
                            end
                       
                       BNE:
                            begin
                                if(yazmac_obegi[register1] == yazmac_obegi[register2])
                                    begin
                                        ps_r = ps_r  -4 + extendedImm;
                                    end
                                bellek_adres= ps_r;
                            end
                        
                       BLT:
                            begin
                                if(yazmac_obegi[register1] >= yazmac_obegi[register2])
                                    begin
                                        ps_r = ps_r -4  + extendedImm;
                                    end
                                bellek_adres = ps_r;
                            end
                            
                       LW : 
                            begin
                                yazmac_obegi[dest_register] = bellek_oku_veri;
                                bellek_adres = ps_r;
                            end
                            
                       SW :    bellek_adres = ps_r;
                       
                       ADDI:   yazmac_obegi[dest_register] = yazmac_obegi[register1] + extendedImm;
                           
                       ADD:    yazmac_obegi[dest_register] = yazmac_obegi[register1] + yazmac_obegi[register2];
                            
                       SUB:    yazmac_obegi[dest_register] = yazmac_obegi[register1] - yazmac_obegi[register2];
                            
                       OR :    yazmac_obegi[dest_register] = yazmac_obegi[register1] | yazmac_obegi[register2];
                       
                       AND:    yazmac_obegi[dest_register] = yazmac_obegi[register1] & yazmac_obegi[register2];
                            
                       XOR:    yazmac_obegi[dest_register] = yazmac_obegi[register1] ^ yazmac_obegi[register2];
                       
                   endcase
                           
                end
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                
          endcase
              
    end
end


endmodule


