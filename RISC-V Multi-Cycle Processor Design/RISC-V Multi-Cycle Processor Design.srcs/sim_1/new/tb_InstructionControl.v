`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2023 16:00:20
// Design Name: 
// Module Name: tb_InstructionControl
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
module tb_InstructionControl;

reg [31:0] instruction;
wire [3:0] whichInstruction;
wire [31:0] immResult;

// Instantiate the InstructionControl module
InstructionControl uut (
    .instruction(instruction),
    .whichInstruction(whichInstruction),
    .extendedImm(immResult)
);

// Initial block to apply stimulus
initial begin
    /*
    // Test case 1: LUI instruction
    instruction = 32'b00000000000000010000000000110111;
    #10; // Wait for a few simulation cycles
    // Check the result
    $display("LUI",whichInstruction);
    if (whichInstruction !== 4'b0000) $display("Test case 1 failed");
    $display(immResult);

    // Test case 2: AUIPC instruction
    instruction = 32'b00000000000100010000000000010111;
    #10; // Wait for a few simulation cycles
    // Check the result
    $display("AUIPC",whichInstruction);
    if (whichInstruction !== 4'b0001) $display("Test case 2 failed");
    $display(immResult);

    // Test case 3: JAL instruction
    instruction = 32'b00000001000000010000000001101111;
    #10; // Wait for a few simulation cycles
    // Check the result
    $display("JAL",whichInstruction);
    if (whichInstruction !== 4'b0010) $display("Test case 3 failed");
    $display(immResult);

    // Test case 4: JALR instruction
    instruction = 32'b00000000000000010000000011100111;
    #10; // Wait for a few simulation cycles
    // Check the result
    $display("JALR",whichInstruction);
    if (whichInstruction !== 4'b0011) $display("Test case 4 failed");
    $display(immResult);

    // Test case 5: BEQ instruction
    instruction = 32'b0000000100000001000000001100011;
    #10; // Wait for a few simulation cycles
    // Check the result
    $display("BEQ",whichInstruction);
    if (whichInstruction !== 4'b0100) $display("Test case 5 failed");
    $display(immResult);

    // Test case 6: LW instruction
    instruction = 32'b00000000000000010000000100000011;
    #10; // Wait for a few simulation cycles
    // Check the result
    $display("LW",whichInstruction);
    if (whichInstruction !== 4'b0111) $display("Test case 6 failed");
    $display(immResult);

    // Test case 7: ADDI instruction
    instruction = 32'b00000000000000010000000000010011;
    #10; // Wait for a few simulation cycles
    // Check the result
    $display("ADDI",whichInstruction);
    if (whichInstruction !== 4'b1001) $display("Test case 7 failed");
    $display(immResult);
    */
    // Test case 8: ADD instruction
    instruction = 32'b00000000001000010000000000110011;
    #10; // Wait for a few simulation cycles
    // Check the result
    $display("ADD",whichInstruction);
    if (whichInstruction !== 4'b1010) $display("Test case 8 failed");
    $display(immResult);

    $stop; // Stop simulation
    
end

endmodule

