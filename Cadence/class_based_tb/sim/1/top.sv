`timescale 1ns / 1ps

import package_like_uvm::*;
`include "pds_if.sv"

module top;

    bit clock = 0;
    bit reset = 0;
    always #5 clock = ~clock;

    pds_if p0 (clock, reset);
    pds_if p1 (clock, reset);

    pds_vc port0 = new("port0", null); // construct
    base   ptr;
    packet pkt;

    // switch dut (p0, ...) // DUT
  // Instantiate the DUT
  dut DUT (
    .clk       (p0.clk),
    .rst_n     (p0.reset),
    .in_data   (p0.data_ip),
    .in_valid  (p0.valid_up),
    .out_data  (p0.data_op),
    .out_valid (p0.valid_op)
  );

    initial begin

        port0.configure(.ppif(p0), .portno(0));

        port0.setpolicy(rnd);
        port0.run(3);

        port0.setpolicy(sgle);
        port0.run(6);

        // Connect the virtual interface
        port0.drv.pif = p0;

        ptr = port0.seqr;

        if (ptr != null) 
            $display("ptr.inst = %s", ptr.inst);

        if (ptr.parent != null) 
            $display("ptr.parent.inst = %s", ptr.parent.inst);
        else 
            $display("ptr.parent = null");

        port0.seqr.print();  // Expected: @ port0.seqr
        port0.drv.print();

        // Generate and print a packet
        port0.seqr.portno = 4;
        port0.seqr.get_next_item(pkt);
        pkt.print();

        // Drive packet through driver
        port0.drv.run(1);  // Run the driver for 1 transaction
    end

endmodule
