class monitor extends base;

    virtual interface pds_if pif;
    int portno;

    function new(string name = "mon", base up = null);
        super.new(name, up);
    endfunction

    task run();
        packet pkt;
        forever begin
            @(posedge pif.valid_op);
            pkt = packet::new("mon_pkt", this);
            {pkt.source, pkt.target, pkt.data} = pif.data_op;
            $display("MONITOR[%0d] Got packet:", portno);
            pkt.print();
        end
    endtask

endclass
