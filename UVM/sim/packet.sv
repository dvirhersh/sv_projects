class packet extends base;

    rand bit [3:0] source, target;
    rand bit [7:0] data;

    function new(string name = "pkt", base up = null);
        super.new(name, up);
    endfunction

    function void print();
        $display("Packet @%s: src=%0h, tgt=%0h, data=0x%0h", this.pathname(), source, target, data);
    endfunction

endclass
