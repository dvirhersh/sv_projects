typedef enum {HEX, BIN, DEC} format_e;

class base;
    bit [7:0] a_byte;

    function void print(format_e format = HEX);
        case (format)
            HEX : $display("a_byte: 0x'%0h", a_byte);
            BIN : $display("a_byte: 0b'%0b", a_byte);
            DEC : $display("a_byte: 0d'%0d", a_byte);
        endcase
    endfunction

    virtual function void print_p();
        $display("a_byte = %0h", a_byte);
    endfunction
endclass

class child extends base;
    bit[3:0] nibble;
    virtual function void print_p();
        super.print_p();
        $display("nibble = %0h", nibble);
    endfunction
endclass 

module print_policy;

    base  bc = new();
    child cc = new();

    initial begin
        bc.a_byte = 14;
        cc.a_byte = 21;
        cc.nibble = 9;
        bc.print();
        bc.print(HEX);
        bc.print(BIN);
        bc.print(DEC);

        // ----
        $display("Polymorphism and Encapsulation");
        $display("1");
        bc.print_p();
        $display("2");
        cc.print_p();
        bc = cc;
        $display("3");
        bc.print_p();

    end
endmodule