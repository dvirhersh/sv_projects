class basic;
    bit [7:0] b1;
    string printaa[string];

    virtual function void makepq();
        string str;
        str.hextoa(b1); // hex to ascii
        printaa["b1"] = {"b1 = 0x", str};
    endfunction
endclass

class kid extends basic;
    // Hides b1 from basic, so use a new name or use `super.b1`
    bit [15:0] b1;

    // Override function
    virtual function void makepq();
        string str;
        super.makepq();  
        str.itoa(b1); // integer to ascii
        printaa["b1"] = {"b1 = ", str};
    endfunction
endclass

module print_array;

    basic basic_class = new();
    kid   kid_class   = new();

    initial begin
        $display("Polymorphism and Encapsulation");

        $display("basic_class makepq:");
        basic_class.b1 = 8'hAB;
        basic_class.makepq();
        $display(basic_class.printaa["b1"]);

        $display("kid_class makepq:");
        kid_class.b1 = 16'd258;
        kid_class.makepq();
        $display(kid_class.printaa["b1"]);

        basic_class = kid_class;  // Polymorphic assignment

        $display("basic_class = kid_class makepq:");
        basic_class.makepq();
        $display(basic_class.printaa["b1"]);
    end
endmodule
