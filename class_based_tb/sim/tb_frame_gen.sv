`timescale 1ns / 1ps
`include "frame_gen.sv"

module tb_frame_gen;
    initial begin
        automatic frame_gen fg = new();
        fg.setcount(7);
        $display("Count = %0d", fg.getcount());
    end
endmodule
