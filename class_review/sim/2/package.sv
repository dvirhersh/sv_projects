package p1;

    class base;
        local bit [3:0] addr;
        rand protected bit [3:0] len;
        bit [7:0] data_arr[];

        function new(input bit [3:0] paddr);
            addr = paddr;
        endfunction

        function void iam();
            $display("Rand Frame");
        endfunction
    endclass

    class sub extends base;
        bit s1;

        constraint length {len > 0; len < 4;}

        function new(input bit [3:0] paddr);
            super.new(paddr);
        endfunction

        function void iam();
            $display("Short Frame");
        endfunction
    endclass : sub

endpackage : p1
  