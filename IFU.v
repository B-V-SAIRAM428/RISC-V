`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2025 22:30:58
// Design Name: 
// Module Name: IFU
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


module IFU(
    input clk,
    input rst,
    input [31:0] current_pc,
    output reg [31:0] PC
    );
    always@(posedge clk) begin
            if(rst == 1) begin
                PC <= 0;
            end else if (current_pc <= 160)
                PC <= current_pc;   
            else
                PC <= 32'd0;
            
    end
endmodule
