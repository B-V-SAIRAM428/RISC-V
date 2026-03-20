`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2025 14:50:43
// Design Name: 
// Module Name: Top_unit
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


module Top_unit(
    input clk,
    input rst,
    output [31:0] current_pc,
    output [31:0] ALU_result
    );
    wire [31:0]PC;
    wire [31:0]instruction_out;       
    wire [7:0]ALU_control;      
    wire beq;
    wire bneq;
    wire blt;
    wire bge;
    wire bltu;
    wire bgeu;
    wire lb_control;
    wire lh_control;
    wire lw_control;
    wire lhu_control;
    wire lbu_control;
    wire sb_control;
    wire sh_control;
    wire sw_control;
    wire beq_control;
    wire bneq_control;
    wire blt_control;  /// signed
    wire bge_control; // signed
    wire bltu_control;
    wire bgeu_control;
    wire jal_control;
    wire jalr_control;
    wire [31:0] imm_value_s_type;
    wire [31:0] imm_value_u_type;
    wire [31:0] imm_addr_branch;
    wire [31:0] imm_addr_jal;
    wire [31:0] imm_addr_jalr;
    wire [31:0] imm_value;
    wire wr_en;
    wire branch_taken;
    wire [31:0] rd_data1;
    wire halt;
    wire ecall_control;
    wire ebreak_control;
    
    IFU FU(clk,rst,current_pc,PC);      // IFU Unit
    
    IM M(PC,instruction_out);       //IM Unit
    
    Control_unit cu(                // Control unit
     rst,
     instruction_out[31:20],
     instruction_out[31:25],
     instruction_out[14:12],
     instruction_out[6:0],
     ALU_control,
     lb_control,
     lh_control,
     lw_control,
     lhu_control,
     lbu_control,
     sb_control,
     sh_control,
     sw_control,
     jal_control,
     jalr_control,
     ecall_control,
     ebreak_control,
     beq_control,
     bneq_control,
     blt_control,  /// signed
     bge_control, // signed
     bltu_control,
     bgeu_control,
     wr_en);
    
    Data_path DP(               // Datapath 
     clk,
     rst,
     instruction_out[19:15], 
     instruction_out[24:20],
     instruction_out[11:7],
     wr_en,       
     ALU_control,
     imm_value,
     imm_value_s_type,
     lb_control,
     lh_control,
     lw_control,
     lhu_control,
     lbu_control,
     sb_control,
     sh_control,
     sw_control,
     beq_control,
     bneq_control,
     blt_control,/// signed
     bge_control, // signed
     bltu_control,
     bgeu_control,
     PC,
     imm_value_u_type,
     beq, bneq, blt, bge,bltu,bgeu,rd_data1, ALU_result);
    
    assign halt = ecall_control || ebreak_control;
    
    assign branch_taken = beq||bneq||blt||bge||bltu||bgeu;
    
    assign current_pc = halt?PC:branch_taken?PC+imm_addr_branch:jal_control?PC+imm_addr_jal:jalr_control?
                        ((rd_data1+imm_addr_jalr)&32'hFFFFFFFE): PC+4;
    
    assign  imm_value = {{20{instruction_out[31]}},instruction_out[31:20]};
    
    assign imm_addr_jal = {{12{instruction_out[31]}},instruction_out[19:12],instruction_out[20],instruction_out[30:21],1'b0};
    
    assign imm_addr_jalr = {{20{instruction_out[31]}},instruction_out[31:20]};
    
    assign imm_addr_branch = {{19{instruction_out[31]}}, instruction_out[31], instruction_out[7], instruction_out[30:25], instruction_out[11:8], 1'b0};    
    
    assign imm_value_u_type = {instruction_out[31:12], 12'b0};
    
    assign imm_value_s_type = {{20{instruction_out[31]}}, instruction_out[31:25], instruction_out[11:7]};
   
endmodule
