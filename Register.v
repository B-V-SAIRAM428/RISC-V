`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2025 10:04:16
// Design Name: 
// Module Name: Register
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


module Register(
    input clk,
    input rst,
    input [4:0] read_addr1,          //coming from Intruction memory 
    input [4:0] read_addr2,          //coming from Intruction memory 
    input [4:0] write_addr,          //coming from Intruction memory 
    input [31:0] write_data,         //coming from data memory 
    input wr_en,
    output [31:0] read_data1,    // going to ALU Unit rs1
    output [31:0] read_data2    // going to ALU Unit rs2
    );
    reg [31:0] mem [31:0];
    integer i;
    assign read_data1 = mem[read_addr1];
    assign read_data2 = mem[read_addr2];
    always@(posedge clk) begin
        mem[0] <= 32'd0;
        if (rst) begin
            for(i=0; i<32; i=i+1)
                mem[i] <= 32'b0;
        end else  begin
            if(wr_en && write_addr !=5'd0)  
                mem[write_addr] <= write_data;
        end
    end
endmodule
