package class_operations;

    typedef enum {HEX, BIN, DEC} format_e;

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
        int       num;
        baseframe f1;

        function new(input bit [3:0] f1adr);
            f1 = new(f1adr);
        endfunction
    endclass

    class base;
        bit [7:0] a_byte;

        function void print(format_e format = HEX);
        begin
            case (format)
                HEX: $display("a_byte: 0x%0h", a_byte);
                BIN: $display("a_byte: 0b%0b", a_byte);
                DEC: $display("a_byte: %0d"  , a_byte);
                default: $display("a_byte: unknown format");
            endcase
        end
        endfunction

        virtual function void print_p();
            $display("a_byte = %0h", a_byte);
        endfunction
    endclass

    class child extends base;
        bit [3:0] nibble;

        virtual function void print_p();
            super.print_p();
            $display("nibble = %0h", nibble);
        endfunction
    endclass

endpackage
