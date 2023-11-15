`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2023 15:45:51
// Design Name: 
// Module Name: tb_ImmGenerator
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


`timescale 1ns/1ps

module tb_ImmGenerator(

    );

reg [31:0] instruction;
wire [31:0] extendedImm;

// Instantiate the ImmGenerator module
ImmGenerator uut (
    .instruction(instruction),
    .extendedImm(extendedImm)
);

// Initial block to apply stimulus
initial begin
    // Test case 1: JAL instruction
    instruction = 32'b00100000010000000000000001101111;
    #10; // Wait for a few simulation cycles
    // Check the result
    if (extendedImm !== 32'b11111111111111111111111111111111) $display("Test case 1 failed");

    // Test case 2: JALR instruction
    instruction = 32'b00110000010000000000000011101111;
    #10; // Wait for a few simulation cycles
    // Check the result
    if (extendedImm !== 32'b11111111111111111111111111111111) $display("Test case 2 failed");

    // Test case 3: BEQ instruction
    instruction = 32'b00110000000000000000001001101111;
    #10; // Wait for a few simulation cycles
    // Check the result
    if (extendedImm !== 32'b1111111111111111111) $display("Test case 3 failed");

    // Test case 4: BNE instruction
    instruction = 32'b01000000000000000000001001101111;
    #10; // Wait for a few simulation cycles
    // Check the result
    if (extendedImm !== 32'b1111111111111111111) $display("Test case 4 failed");

    // Test case 5: BLT instruction
    instruction = 32'b01100000000000000000001001101111;
    #10; // Wait for a few simulation cycles
    // Check the result
    if (extendedImm !== 32'b1111111111111111111) $display("Test case 5 failed");

    // Test case 6: LW instruction
    instruction = 32'b01110000010000000000000010001111;
    #10; // Wait for a few simulation cycles
    // Check the result
    if (extendedImm !== 32'b11111111111111111111) $display("Test case 6 failed");

    // Test case 7: SW instruction
    instruction = 32'b10000000010000000000000010001111;
    #10; // Wait for a few simulation cycles
    // Check the result
    if (extendedImm !== 32'b11111111111111111111) $display("Test case 7 failed");

    // Test case 8: ADDI instruction
    instruction = 32'b10010000010000000000000000101111;
    #10; // Wait for a few simulation cycles
    // Check the result
    if (extendedImm !== 32'b11111111111111111111) $display("Test case 8 failed");

    $stop; // Stop simulation
end

endmodule

