`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.07.2025 21:11:07
// Design Name: 
// Module Name: Data_path
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


module Data_path(
    input clk,
    input rst,
    input [4:0] read_addr1,           
    input [4:0] read_addr2,           
    input [4:0] write_addr, 
    input wr_en,       
    input [7:0]ALU_control,
    input [31:0]imm_value,
    input [31:0]imm_value_s_type,
    input lb_control,
    input lh_control,
    input lw_control,
    input lhu_control,
    input lbu_control,
    input sb_control,
    input sh_control,
    input sw_control,
    input beq_control,
    input bneq_control,
    input blt_control,/// signed
    input bge_control, // signed
    input bltu_control,
    input bgeu_control,
    input [31:0]PC,
    input [31:0] imm_value_u_type,
    output beq, bneq, blt, bge,bltu,bgeu,
    output [31:0] read_data1,
    output [31:0] ALU_result
    );
    wire [31:0] read_data2; 
    wire [31:0] wr_data;
    wire [31:0] rd_data;
    
    // data was coming form ALU and data memory to register
    assign wr_data = (lw_control | lb_control | lh_control | lbu_control | lhu_control) ? rd_data : ALU_result; 
    
    assign beq = (ALU_result == 32'd1 && beq_control==1'b1)? 1'b1:1'b0;
    assign bneq = (ALU_result == 32'd1 && bneq_control==1'b1)? 1'b1:1'b0;
    assign blt = (ALU_result == 32'd1 && blt_control==1'b1)? 1'b1:1'b0;
    assign bge = (ALU_result == 32'd1 && bge_control==1'b1)? 1'b1:1'b0;
    assign bltu = (ALU_result == 32'd1 && bltu_control==1'b1)? 1'b1:1'b0;
    assign bgeu = (ALU_result == 32'd1 && bgeu_control==1'b1)? 1'b1:1'b0;
    
    
    Register RU ( 
                 clk,
                 rst,
                 read_addr1,           
                 read_addr2,           
                 write_addr,         
                 wr_data,    
                 wr_en,     
                 read_data1,    
                 read_data2  
                );
    
   ALU AU (
            read_data1,       
            read_data2,       
            ALU_control, 
            imm_value, 
            imm_value_s_type, 
            PC,
            imm_value_u_type,      
            ALU_result
           ); 
   
   Data_memory DM(
                 clk, 
                 rst,                    
                 ALU_result,
                 read_data2,
                 wr_en,
                 lb_control,
                 lh_control,
                 lw_control,
                 lhu_control,
                 lbu_control,
                 sb_control,
                 sh_control,
                 sw_control,                // Coming from Control unit
                 rd_data 
                );
endmodule
