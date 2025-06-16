class baseframe_1;
    bit b1;

    function void print();
        $display("b1 = %b", b1);
    endfunction
endclass

class multiframe_1;
    int count;
    baseframe_1 frame1;
    baseframe_1 frame2;

    function new();
        frame1 = new();
        frame2 = new();
    endfunction

    function void print();
        $display("count = %0d", count);
        frame1.print();
        frame2.print();
    endfunction
endclass

module aggregate_class;
    initial begin
        multiframe_1 one = new();
        one.count = 42;  // example value
        one.frame1.b1 = 1;
        one.frame2.b1 = 0;
        one.print();
    end
endmodule
