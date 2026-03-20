`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.07.2025 14:43:52
// Design Name: 
// Module Name: IM
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


module IM(
    input [31:0]PC,
    output reg [31:0]instruction_out 
    );
    always@(*) begin
        case(PC)
             /// I-type 
      //// Why I do 4 ADDI means, it initial state it was empty i need to put some value in the register so i did below thing 
            32'd0: instruction_out = 32'h00A00113;  // ADDI  x2,x0,10
            32'd4: instruction_out = 32'h01400193;  // ADDI  x3,x0,20
            32'd8: instruction_out = 32'h01E00293;  // ADDI x5,x0,30
            32'd12: instruction_out = 32'h02800313;  // ADDI x6,x0,40
            
            /// R-Type
            32'd16: instruction_out = 32'h003100B3;  // ADD  x1,x2,x3
            32'd20: instruction_out = 32'h40628233;  // SUB  x4,x5,x6
            32'd24: instruction_out = 32'h002093B3;  // SLL  x7,x1,x2
            32'd28: instruction_out = 32'h0062A433;  // SLT x8,x5,x6
            32'd32: instruction_out = 32'h0062B4B3;  // SLTU x9,x5,x6
            32'd36: instruction_out = 32'h0022C533;  // XOR  x10,x5,x2 
            32'd40: instruction_out = 32'h005255B3;  // SRL  x11,x4,x5
            32'd44: instruction_out = 32'h40525633;  // SRA  x12,x4,x5
            32'd48: instruction_out = 32'h003366B3;  // OR   x13,x6,x3
            32'd52: instruction_out = 32'h0040F733;  // AND  x14,x1,x2
            

            
            /// Normal I type operations
            32'd56: instruction_out = 32'h00311793;  // SLLI  x15,x2,3 
            32'd60: instruction_out = 32'h0141A813;  // SLTI  x16,x3,20
            32'd64: instruction_out = 32'h01E2B893;  // SLTIU x17,x5,30
            32'd68: instruction_out = 32'h00A0C913;  // XORI    x18,X1,10
            32'd72: instruction_out = 32'h0031D993;  // SRLI  x19,x3,3  
            32'd76: instruction_out = 32'h40725A13;  // SRAI   x20,x4,7
            32'd80: instruction_out = 32'h014A6A93;  // ORI  x21,x20,20  
            32'd84: instruction_out = 32'h019AFB13;  // AND   x22,x21,25
            
            // S-type 
            32'd88: instruction_out = 32'h00A10623;  // sb x10,12(x2)
            32'd92: instruction_out = 32'h00A11623;  // sh x10,12(x2)
            32'd96: instruction_out = 32'h00A12623;  // sw x10,12(x2)
            //// L-Type
            32'd100: instruction_out = 32'h00308B83;  // LB  x23,3(x1)
            32'd104: instruction_out = 32'h00411C03;  // LH  x24,4(x2)
            32'd108: instruction_out = 32'h0051AC83;  // LW x25,5(x3)
            32'd112: instruction_out = 32'h00624D03;  // LBU  x26,6(x4)
            32'd116: instruction_out = 32'h0072DD83;  // LHU  x27,7(x5)
            
            /// B-Type
            32'd120: instruction_out = 32'h00C58663;  // beq x11,x12,13
            32'd124: instruction_out = 32'h00E69763;  // bne x13,x14,14
            32'd128: instruction_out = 32'h0107C763;  // blt x15,x16,15
            32'd132: instruction_out = 32'h0128D863;  // bge x17,x18,16
            32'd136: instruction_out = 32'h0149E863;  // bltu x19,x20,17
            32'd140: instruction_out = 32'h016AF963;  // bgeu x21,x22,18
            
            /// U-type 
            32'd144: instruction_out = 32'h0001CE37;  // lui x28,28
            32'd148: instruction_out = 32'h0001DE97;  // auipc x29,29
            
            //J-Type
            32'd152: instruction_out = 32'h00E00F6F;  // jal x30,15
            32'd156: instruction_out = 32'h00C78FE7;  // jalr x31,x15,12
            
       
            
            //nop
            default: instruction_out = 32'h00000013;  // addi x0 x0 0
        endcase
    end
endmodule
