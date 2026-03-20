`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2025 21:46:08
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] rs1,       // Data coming from register unit 
    input [31:0] rs2,       // Data coming from register unit
    input [7:0] ALU_control, // Coming from CU 
    input [31:0] imm_value,  /// For both I and L type
    input [31:0] imm_value_s_type,  // for s type
    input [31:0]PC,
    input [31:0]imm_value_u_type,
    output reg [31:0] ALU_result          // This can send to back to register or sent to memory. For this design it is taking as output
    );
    
    always @(*) begin
        ALU_result = 32'd0;
        case(ALU_control)
        
            /// R -type
            8'd0:   ALU_result = rs1 + rs2;
            8'd1:   ALU_result = rs1 - rs2;
            8'd2:   ALU_result = rs1 << rs2[4:0];
            8'd3:   ALU_result = ($signed(rs1) < $signed(rs2))? 32'd1:32'd0;
            8'd4:   ALU_result = rs1 < rs2? 32'd1:32'd0;
            8'd5:   ALU_result = rs1 ^ rs2;
            8'd6:   ALU_result = rs1 >> rs2[4:0];
            8'd7:   ALU_result = $signed(rs1) >>> rs2[4:0];
            8'd8:   ALU_result = rs1 | rs2;
            8'd9:   ALU_result = rs1 & rs2;
            
            // I - Type
            8'd10:  ALU_result = rs1 + imm_value;
            8'd11:  ALU_result = rs1 << imm_value[4:0];
            8'd12:  ALU_result = ($signed(rs1) < $signed(imm_value))?32'd1:32'd0;
            8'd13:  ALU_result = rs1 < imm_value? 32'd1:32'd0;
            8'd14:  ALU_result = rs1 ^ imm_value;
            8'd15:  ALU_result = rs1 >> imm_value[4:0];
            8'd16:  ALU_result = $signed(rs1) >>> imm_value[4:0];
            8'd17:  ALU_result = rs1 | imm_value;
            8'd18:  ALU_result = rs1 & imm_value;
            
            /// B- Type
            8'd19:  ALU_result = rs1 == rs2? 32'd1:32'd0;
            8'd20:  ALU_result = rs1 != rs2? 32'd1:32'd0;
            8'd21:  ALU_result = ($signed(rs1) < $signed(rs2))? 32'd1:32'd0;
            8'd22:  ALU_result = ($signed(rs1) >= $signed(rs2))? 32'd1:32'd0;
            8'd23:  ALU_result = rs1 < rs2? 32'd1:32'd0;
            8'd24:  ALU_result = rs1 >= rs2? 32'd1:32'd0;
            
            // L-Type
            8'd25:  ALU_result = rs1 + imm_value;

            // S-Type
            8'd26:  ALU_result = rs1 + imm_value_s_type;
            
            // U _ Type
            8'd27:  ALU_result = imm_value_u_type;   // LUI
            8'd28:  ALU_result = PC + imm_value_u_type;   // AUIPC
            
            
            default: begin 
                    ALU_result = 0; // default to avoid latch
               end     
        endcase
    end
endmodule
