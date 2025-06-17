class pds_vc extends base;

    sequencer seqr;
    driver    drv;

    function new(input string name, base up);
        super.new(name, up);
        seqr = new("seqr", this);
        drv  = new("drv ", this);
    endfunction

endclass : pds_vc
