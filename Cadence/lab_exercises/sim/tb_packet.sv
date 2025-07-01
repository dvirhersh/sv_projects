`timescale 1ns / 1ps
import packet_pkg::*;

module tb_packet;
    initial begin
        automatic Packet pkt1 = new("pkt1");
        Packet pkt2;
        bit [15:0] raw;

        if (!pkt1.randomize())
            $fatal("Randomization failed for pkt1");
        pkt1.print("Randomized");

        raw = pkt1.pack();
        $display("Packed = 0x%04h", raw);

        pkt2 = new("pkt2");
        pkt2.unpack(raw);
        pkt2.print("Unpacked");
    end
endmodule
