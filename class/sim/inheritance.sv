class parent;
    bit [3:0] a_vec;
    bit       a_bit;

    function void print();
        $display("parent: a_vec = %d, a_bit = %d", a_vec, a_bit);
    endfunction
endclass

class child extends parent;
    int  a_vec;
    byte a_byte;

    function void print();
        super.print();
        $display("child: a_vec = %0d, a_byte = 0x%h", a_vec, a_byte);
    endfunction
endclass

module inheritance;
    child one = new();

    initial begin
        one.a_vec  = 4;     // from parent
        one.a_bit  = 1'b1;  // from parent
        one.a_byte = 8'hFF; // from child
        one.print();
    end
endmodule
