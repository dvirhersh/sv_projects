virtual class base;

    string inst;
    base   parent;

    function new(input string name, base up);
        inst   = name;
        parent = up;
    endfunction

    function string pathname();
        base ptr = this;
        pathname = inst;
        while (ptr.parent != null) begin
            ptr = ptr.parent;
            pathname = {ptr.inst, ".", pathname};
        end
    endfunction : pathname

endclass : base

class sequencer extends base;

    function new(input string name, base up);
        super.new(name, up);
    endfunction

    function void print();
        $display("@ %s", this.pathname());
    endfunction : print

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

        if (ptr != null) $display("ptr.inst = %s", ptr.inst);

        if (ptr.parent != null) $display("ptr.parent.inst = %s", ptr.parent.inst);
        else $display("ptr.parent = null");

        pds1.seqr.print();  // Expected output: @ pds1.seqr
    end
endmodule
