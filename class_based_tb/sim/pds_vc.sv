class pds_vc extends base;

  sequencer seqr;

  function new(input string name, base up);
    super.new(name, up);
    seqr = new("seqr", this);
  endfunction

endclass : pds_vc
