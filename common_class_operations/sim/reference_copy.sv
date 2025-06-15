class baseframe;
    bit [3:0] addr;

    function new(input bit [3:0] paddr);
        addr = paddr;
    endfunction

    function void post_randomize();
        $display("Randomization completed for addr = %0h", addr);
    endfunction

    function void print();
        $display("addr = %0h", addr);
        $display("");
    endfunction
endclass
module ref_copy;

    baseframe b1;
    baseframe b2;

    initial begin
        b1 = new(5);
        b2 = b1; // copy
        b1.addr = 6;
        $display("b1.addr = %0d", b1.addr); // 6
        $display("b2.addr = %0d", b2.addr); // 6
        b1 = null;
        $display("after b1 = null - b2.addr = %0d", b2.addr);  // ?
  end
endmodule