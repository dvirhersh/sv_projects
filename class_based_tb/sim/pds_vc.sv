class pds_vc extends base;

    sequencer seqr;
    driver    drv;
    monitor   mon;

    function new(input string name, base up);
        super.new(name, up);
        seqr = new("seqr", this);
        drv  = new("drv ", this);
        mon  = new("mon ", this);
        drv.sref = seqr;
    endfunction

    function void setpolicy(seqr_ctrl_e sc);
        seqr.seqr_ctrl = sc;
        $display("[setpolicy] %s: Policy set to %s", this.inst, sc.name());
    endfunction : setpolicy

    task run(int count);
        drv.run(count);
	endtask : run

    task configure(virtual pds_if ppif, int portno);
        drv.pif     = ppif;
        mon.pif     = ppif;
        mon.portno  = portno;
        seqr.portno = portno;
    endtask : configure

endclass : pds_vc
