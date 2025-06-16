`timescale 1ns / 1ps

class baseframe_1;
    bit b1;
    protected string inst;

    function new(input string pst = "");
        inst = pst;
    endfunction

    function string getname();
        return inst;
    endfunction

    function void setname(input string pst);
        inst = pst;
    endfunction

    function void print();
        $display(inst, ".b1 = %b", b1);
    endfunction
endclass

class multiframe_1;
    int count;
    baseframe_1 frame1;
    baseframe_1 frame2;

    function new();
        frame1 = new("frame1");
        frame2 = new("frame2");
    endfunction

    function void print();
        $display("count = %0d", count);
        frame1.print();
        frame2.print();
    endfunction
endclass

module aggregate_class;
    multiframe_1 one = new();
    baseframe_1  bc1 = new("bc1");
    baseframe_1  bc2;

    initial begin
        one.count = 42;
        one.frame1.b1 = 1;
        one.frame2.b1 = 0;
        one.print();

        // =========== Object copying test ===========
        $display("bc1 name = %s", bc1.getname());

        // Clone bc1 to bc2 (use copy constructor if needed)
        bc2 = new(bc1.getname());
        $display("bc2 (copy of bc1) name = %s", bc2.getname());

        bc2.setname("bc2");
        $display("bc2 (renamed) name = %s", bc2.getname());
    end
endmodule
