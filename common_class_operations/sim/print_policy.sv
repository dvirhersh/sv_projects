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
endclass

module print_policy;

    base bc = new();

    initial begin
        bc.a_byte = 14;
        bc.print();
        bc.print(HEX);
        bc.print(BIN);
        bc.print(DEC);
    end
endmodule