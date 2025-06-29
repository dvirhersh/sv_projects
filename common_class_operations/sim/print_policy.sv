import class_operations::*;

module PrintPolicy;

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