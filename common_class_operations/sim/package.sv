package class_operations;
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

    class multiframe;
        int num;
        baseframe f1;

        function new(input bit [3:0] f1adr);
            f1 = new(f1adr);
        endfunction
    endclass
endpackage
