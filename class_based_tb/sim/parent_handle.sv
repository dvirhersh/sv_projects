virtual class base;
    string inst;
    base   parent;

    function new(input string name, base up);
        inst   = name;
        parent = up;
    endfunction
endclass : base

class sequencer extends base;

    function new(input string name, base up);
        super.new(name, up);
    endfunction

endclass : sequencer

class pds_vc extends base;

    sequencer seqr;

    function new(input string name, base up);
        super.new(name, up);
        seqr = new("seqr", this);
    endfunction

endclass : pds_vc

module parent_handle;
    pds_vc pds1 = new("pds1", null);
    base   ptr;

    initial begin
        ptr = pds1.seqr;
        if (ptr != null) $display("ptr.inst     = %s", ptr.inst);

        ptr = ptr.parent;
        if (ptr != null) $display("ptr.parent.inst = %s", ptr.inst);
        else $display("ptr.parent = null");
    end
endmodule
