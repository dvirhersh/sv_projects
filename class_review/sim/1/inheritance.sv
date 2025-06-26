`timescale 1ns/1ps

class Parent;
    bit b1;

    function new(input int p1);
        b1 = p1;
    endfunction

    function void print();
        $display("Parent: b1 = %0d", b1);
    endfunction
endclass

class Child extends Parent;
    bit [1:0] p1;

    function new(input bit [1:0] p1);
        super.new(p1);
        this.p1 = p1;
    endfunction

    function void print();
        super.print();  // print b1 from Parent
        $display("Child : p1 = %0d", p1);
    endfunction
endclass

class GrandChild extends Child;
    function new(input bit p1);
        super.new(p1);
    endfunction

    function void print();
        super.print();
        $display("GrandChild: no extra fields");
    endfunction
endclass

module inheritance;
    Parent     parent1;
    Child      child2;
    GrandChild grandchild3;

    initial begin
        parent1     = new(1'b1);
        child2      = new(2'b10);
        grandchild3 = new(2'b11);

        parent1.print();
        child2.print();
        grandchild3.print();
    end
endmodule
