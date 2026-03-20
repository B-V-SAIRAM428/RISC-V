module Control_unit(
    input rst,
    input [11:0] func_12,
    input [6:0] func_7,
    input [2:0] func_3,
    input [6:0] opcode,
    output reg [7:0] ALU_control,
    output reg lb_control,
    output reg lh_control,
    output reg lw_control,
    output reg lhu_control,
    output reg lbu_control,
    output reg sb_control,
    output reg sh_control,
    output reg sw_control,
    output reg jal_control,
    output reg jalr_control,
    output reg ecall_control,
    output reg ebreak_control,
    //output reg fence_control,
    output reg beq_control,
    output reg bneq_control,
    output reg blt_control,  /// signed
    output reg bge_control, // signed
    output reg bltu_control,
    output reg bgeu_control,
    output reg wr_en
);

always @(*) begin
        ALU_control = 8'd0;
        lb_control = 1'b0;
        lh_control = 1'b0;
        lw_control = 1'b0;
        lhu_control = 1'b0;
        lbu_control = 1'b0;
        sb_control = 1'b0;
        sh_control = 1'b0;
        sw_control = 1'b0;
        jal_control = 1'b0;
        jalr_control = 1'b0;
       ecall_control = 1'b0;
        ebreak_control = 1'b0;
        //fence_control = 1'b0;
        beq_control =1'b0;
        bneq_control=1'b0;
        blt_control=1'b0;  
        bge_control=1'b0;
        bltu_control=1'b0;
        bgeu_control=1'b0;
        wr_en = 1'b0;
    if (opcode == 7'b0110011) begin // R-type
        wr_en = 1'b1;
        case(func_3)
            3'd0: ALU_control = (func_7==7'd0)? 8'd0 : (func_7==7'd32)? 8'd1 : 8'd0;  // Add and sub
            3'd1: ALU_control = 8'd2; // sll
            3'd2: ALU_control = 8'd3; // slt
            3'd3: ALU_control = 8'd4; // sltu 
            3'd4: ALU_control = 8'd5; // xor
            3'd5: ALU_control = (func_7==7'd0)? 8'd6 : (func_7==7'd32)? 8'd7 : 8'd0; // srl and sra
            3'd6: ALU_control = 8'd8; // or 
            3'd7: ALU_control = 8'd9; // and
            default: ALU_control = 8'd0;
        endcase
    end else if (opcode == 7'b0010011) begin // I-type
         wr_en = 1'b1;
        case(func_3)
            3'd0: ALU_control = 8'd10;  // addi
            3'd1: ALU_control = 8'd11; // slli
            3'd2: ALU_control = 8'd12; // slti
            3'd3: ALU_control = 8'd13; // sltui
            3'd4: ALU_control = 8'd14; // xor
            3'd5: ALU_control = (func_7==7'd0)? 8'd15 : (func_7==7'd32)? 8'd16 : 8'd0; // srli and srai
            3'd6: ALU_control = 8'd17; // or
            3'd7: ALU_control = 8'd18; // and
            default: ALU_control = 8'd0;
        endcase
    end else if (opcode == 7'b1100011) begin // B-type
         wr_en = 1'b0;
        case(func_3)
            3'd0: begin ALU_control = 8'd19; beq_control  = 1'b1; end
            3'd1: begin ALU_control = 8'd20; bneq_control = 1'b1; end
            3'd4: begin ALU_control = 8'd21; blt_control  = 1'b1; end
            3'd5: begin ALU_control = 8'd22; bge_control  = 1'b1; end
            3'd6: begin ALU_control = 8'd23; bltu_control = 1'b1; end
            3'd7: begin ALU_control = 8'd24; bgeu_control = 1'b1; end
        default: ALU_control = 8'd0;
        endcase
    end else if (opcode == 7'b0000011) begin   // L-type
         wr_en = 1'b1;
         ALU_control = 8'd25;
        case(func_3)
            3'd0: lb_control = 1'b1;
            3'd1: lh_control = 1'b1;
            3'd2: lw_control = 1'b1;
            3'd4: lbu_control = 1'b1;
            3'd5: lhu_control = 1'b1;
            default: begin
                ALU_control = 8'd0;
                lb_control = 1'b0;
                lh_control = 1'b0;
                lw_control = 1'b0;
                lhu_control = 1'b0;
                lbu_control = 1'b0;
            end
        endcase
        
    end else if (opcode == 7'b0100011) begin  // s type
         wr_en = 1'b0;
         ALU_control = 8'd26;
        case(func_3) 
            3'd0: sb_control = 1'b1;
            3'd1: sh_control = 1'b1; 
            3'd2: sw_control = 1'b1; 
            default: begin
                ALU_control = 8'd0;
                sb_control = 1'b0;
                sh_control = 1'b0;
                sw_control = 1'b0;
            end
        endcase
    end else if (opcode == 7'b0110111) begin   wr_en = 1'b1; ALU_control = 8'd27;       // U-type
    end else if (opcode == 7'b0010111)  begin wr_en = 1'b1; ALU_control = 8'd28;        // U-type
    end else if (opcode == 7'b1101111) begin jal_control=1'b1;  wr_en = 1'b1;      // J-type
    end else if (opcode == 7'b1100111) begin   /// j - type
        wr_en = 1'b1;
        case(func_3)
            3'd0: jalr_control =1'b1;
            default: jalr_control =1'b0;
        endcase
    end else if (opcode == 7'b1110011 ) begin     ///// ecall and ebreak
         wr_en = 1'b0;
        case(func_12)
            12'd0: ecall_control = 1'b1;
            12'h0001: ebreak_control = 1'b1;
            default: begin
                ecall_control = 1'b0;
                ebreak_control = 1'b0;
            end
        endcase
    end /*else if (opcode == 7'b0001111) begin
        fence_control = 1'b1;
         wr_en = 1'b0;
    end */else begin
        ALU_control = 8'd0;
        lb_control = 1'b0;
        lh_control = 1'b0;
        lw_control = 1'b0;
        lhu_control = 1'b0;
        lbu_control = 1'b0;
        sb_control = 1'b0;
        sh_control = 1'b0;
        sw_control = 1'b0;
        jal_control = 1'b0;
        jalr_control = 1'b0;
        ecall_control = 1'b0;
        ebreak_control = 1'b0;
      //  fence_control = 1'b0;
        beq_control =1'b0;
        bneq_control=1'b0;
        blt_control=1'b0;  
        bge_control=1'b0;
        bltu_control=1'b0;
        bgeu_control=1'b0;
        wr_en = 1'b0;
    end
end

endmodule
