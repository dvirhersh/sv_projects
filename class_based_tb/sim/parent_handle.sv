`include "packet.sv"
`include "psingle.sv"
`include "pmulticast.sv"
`include "base.sv"
`include "sequencer.sv"
`include "pds_vc.sv"
`include "pds_if.sv"
`include "driver.sv"
`include "monitor.sv"

module parent_handle;

    bit clk = 0;
    bit rst = 0;
    always #5 clk = ~clk;

    pds_if pif_inst (clk, rst);

    // 2. Class-based environment
    pds_vc pds1 = new("pds1", null);
    base   ptr;
    packet pkt;

    initial begin
        // Connect the virtual interface
        pds1.drv.pif = pif_inst;

        // Link sequencer to driver
        pds1.drv.sref = pds1.seqr;

        ptr = pds1.seqr;

        if (ptr != null) 
            $display("ptr.inst = %s", ptr.inst);

        if (ptr.parent != null) 
            $display("ptr.parent.inst = %s", ptr.parent.inst);
        else 
            $display("ptr.parent = null");

        pds1.seqr.print();  // Expected: @ pds1.seqr
        pds1.drv.print();

        // Generate and print a packet
        pds1.seqr.portno = 4;
        pds1.seqr.get_next_item(pkt);
        pkt.print();

        // Drive packet through driver
        pds1.drv.run(1);  // Run the driver for 1 transaction
    end

endmodule
