`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2025 21:31:16
// Design Name: 
// Module Name: RISC_Tb
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


module RISC_Tb(

    );
    reg clk=0;
    reg rst=1;
    wire [31:0]ALU_result;
    wire [31:0] current_pc;
    Top_unit uut (.clk(clk),.rst(rst),.ALU_result(ALU_result),.current_pc(current_pc));
    
    initial begin
        #100 rst = 0;
        #5000 $finish;
    end
    always #5 clk = ~clk;               
endmodule
