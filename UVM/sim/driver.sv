class driver extends base;

    virtual interface pds_if pif;
    sequencer seqr;

    function new(string name = "drv", base up = null);
        super.new(name, up);
    endfunction

    task run(int count = 1);
        packet pkt;
        for (int i = 0; i < count; i++) begin
            seqr.get_next_item(pkt);
            $display("DRIVER: sending packet %0d", i);
            pkt.print();
            pif.drive_packet(pkt);
        end
    endtask

    function void print();
        $display("@ %s", this.pathname());
    endfunction

endclass
