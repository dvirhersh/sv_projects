package class_operations;

    typedef enum {HEX, BIN, DEC} format_e;

    class baseframe;
                  bit       b1;
                  bit [3:0] addr;
        protected string    inst;

        function new(input bit [3:0] paddr, input string pst = "");
            addr = paddr;
            inst = pst;
        endfunction

        function void post_randomize();
            $display("Randomization completed for addr = %0h", addr);
        endfunction

        function void print();
            $display(inst, ".addr = %0h", addr);
            $display(inst, ".b1 = %b", b1);
        endfunction

        function string getname();
            return inst;
        endfunction

        function void setname(input string pst);
            inst = pst;
        endfunction
    endclass

    class multiframe;
        int       num;
        baseframe frame1;
        baseframe frame2;
        
        function new(input bit [3:0] f1adr);
            frame1 = new(f1adr, "frame1");
            frame2 = new(f1adr, "frame2");
        endfunction

        function void print();
            $display("num = %0d", num);
            frame1.print();
            frame2.print();
        endfunction
    endclass

    class base;
        bit [7:0] a_byte;

        function void print(format_e format = HEX);
        begin
            case (format)
                HEX: $display("a_byte: 0x'%0h", a_byte);
                BIN: $display("a_byte: 0b'%0b", a_byte);
                DEC: $display("a_byte: 0d'%0d"  , a_byte);
                default: $display("a_byte: unknown format");
            endcase
        end
        endfunction

        virtual function void print_p();
            $display("a_byte = d'%0d", a_byte);
        endfunction
    endclass

    class child extends base;
        bit [3:0] nibble;

        virtual function void print_p();
            super.print_p();
            $display("nibble = d'%0d", nibble);
        endfunction
    endclass

    class Basic;
        bit [7:0] b1;
        string printaa[string];

        virtual function void makepq();
            string str;
            str.hextoa(b1); // hex to ascii
            printaa["b1"] = {"b1 = 0x", str};
        endfunction
    endclass

    class Child extends Basic;
        // Hides b1 from Basic, so use a new name or use `super.b1`
        bit [15:0] b1;

        // Override function
        virtual function void makepq();
            string str;
            super.makepq();
            str.itoa(b1);  // integer to ascii
            printaa["b1"] = {"b1 = ", str};
        endfunction
    endclass

endpackage
