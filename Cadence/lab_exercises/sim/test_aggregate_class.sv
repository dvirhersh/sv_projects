`timescale 1ns / 1ps

import packet_pkg::*;

module test_aggregate_class;

    initial begin
        fourpacket fp;
        fp = new();

        $display("=== Aggregated Packet Output ===");
        fp.deep_print();
    end

endmodule

