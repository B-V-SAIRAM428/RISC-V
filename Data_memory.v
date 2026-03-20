`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2025 21:33:35
// Design Name: 
// Module Name: Data_memory
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


module Data_memory(
    input clk,
    input rst,                // Coming form Top_module          
    input [31:0]addr,         /// RS1 of load instruction
    input [31:0] wr_data,        //coming from ALU output for store operation that take the data from register to memory
    input wr_en,
    input lb_control,
    input lh_control,
    input lw_control,
    input lhu_control,
    input lbu_control,
    input sb_control,
    input sh_control,
    input sw_control,                // Coming from Control unit
    output reg [31:0] rd_data       //coming from ALU output for load operation that take the data from memory to register
    );
    reg [31:0] mem[31:0];
    integer i;
    always@(posedge clk) begin
        if (rst) begin
            for (i=0; i<32; i=i+1)
                mem[i] <= 32'd0;
        end else if (!wr_en) begin
             if(sb_control)
                mem[addr] <= {{24{wr_data[7]}},wr_data[7:0]};
             else if(sh_control)
                mem[addr] <= {{16{wr_data[15]}},wr_data[15:0]};
             else
                mem[addr] <= wr_data;
        end
   end
   always@(*) begin
        if(wr_en) begin
            if(lb_control)
                rd_data = {{24{mem[addr][7]}},mem[addr][7:0]};
            else if (lh_control)
                rd_data = {{16{mem[addr][15]}},mem[addr][15:0]};
            else if(lw_control)
                rd_data = mem[addr];
            else if(lhu_control)
                rd_data = {{16{1'b0}},mem[addr][15:0]};
            else if(lbu_control)
                rd_data = {{24{1'b0}},mem[addr][7:0]};
            else
                rd_data = 32'd0;
        end else
            rd_data = 32'd0;
   end
endmodule
