`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2023 10:05:11
// Design Name: 
// Module Name: tb_ALU
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


module tb_ALU(

    );
    
    reg [1:0] process;
    reg [31:0] input1;
    reg [31:0] input2;

    // Outputs
    wire [31:0] output1;
    wire isEqual;

    // Instantiate the Unit Under Test (UUT)
    AMB uut (
        .process(process), 
        .input1(input1), 
        .input2(input2), 
        .output1(output1), 
        .isEqual(isEqual)
    );

    initial begin
        // Initialize Inputs
        process = 2'b00;
        input1 = 32'h0000_0000;
        input2 = 32'h0000_0000;

        // Wait 100 ns for global reset to finish
        #100;

        // Add two numbers
        process = 2'b00; // ADD
        input1 = 32'h1234_5678;
        input2 = 32'h8765_4321;
        #10;
        $display("ADD: %h + %h = %h", input1, input2, output1);

        // Subtract two numbers
        process = 2'b01; // SUBTRACT
        input1 = 32'h1111_1111;
        input2 = 32'h2222_2222;
        #10;
        $display("SUBTRACT: %h - %h = %h", input1, input2, output1);

        // Compare two numbers
        process = 2'b10; // COMPARE
        input1 = 32'h1234_5678;
        input2 = 32'h1234_5678;
        #10;
        $display("COMPARE: %h == %h ? %b", input1, input2, isEqual);

        // Compare two different numbers
        input1 = 32'h1234_5678;
        input2 = 32'h8765_4321;
        #10;
        $display("COMPARE: %h == %h ? %b", input1, input2, isEqual);

        // End simulation
        $finish;
    end
      
          
endmodule
