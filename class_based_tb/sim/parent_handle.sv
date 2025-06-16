`include "packet.sv"
`include "psingle.sv"
`include "pmulticast.sv"
`include "base.sv"
`include "sequencer.sv"
`include "pds_vc.sv"

module parent_handle;

    pds_vc pds1 = new("pds1", null);
    base   ptr;
    packet pkt;

    initial begin
        ptr = pds1.seqr;

        if (ptr != null) 
            $display("ptr.inst = %s", ptr.inst);

        if (ptr.parent != null) 
            $display("ptr.parent.inst = %s", ptr.parent.inst);
        else 
            $display("ptr.parent = null");

        pds1.seqr.print();  // Expected: @ pds1.seqr

        // Generate and print a packet
        pds1.seqr.portno = 4;
        pds1.seqr.get_next_item(pkt);
        pkt.print();
    end

endmodule
