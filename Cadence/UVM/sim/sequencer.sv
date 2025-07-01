typedef enum {
  sgle,
  mult,
  rnd
} seqr_ctrl_e;

class sequencer extends base;

    int         ok;
    int         portno;
    seqr_ctrl_e seqr_ctrl;

    function new(string name = "seqr", base up = null);
        super.new(name, up);
    endfunction

    function void get_next_item(output packet pkt);
        pkt = packet::new("pkt", this);
        pkt.source = portno;
        ok = pkt.randomize();
        if (!ok) 
            $fatal(1, "Failed to randomize packet");
    endfunction

    function void print();
        $display("@ %s", this.pathname());
    endfunction

endclass
