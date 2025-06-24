`timescale 1ns/1ps

class parent;
    bit b1;

    function new(input int p1);
        b1 = p1;
    endfunction

    function void print();
        $display("parent: b1 = %0d", b1);
    endfunction
endclass

class child extends parent;
    bit [1:0] p1;

    function new(input bit [1:0] p1);
        super.new(p1);
        this.p1 = p1;
    endfunction

    function void print();
        super.print();  // print b1 from parent
        $display("child : p1 = %0d", p1);
    endfunction
endclass

class grandchild extends child;
    function new(input bit p1);
        super.new(p1);
    endfunction

    function void print();
        super.print();
        $display("grandchild: no extra fields");
    endfunction
endclass

module inheritance;
    parent     parent1;
    child      child2;
    grandchild grandchild3;

    initial begin
        parent1     = new(1'b1);
        child2      = new(2'b10);
        grandchild3 = new(2'b11);

        parent1.print();
        child2.print();
        grandchild3.print();
    end
endmodule
