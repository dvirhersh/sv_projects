class parent;
    int p1;

    function new(input int pp1);
        p1 = pp1;
    endfunction

endclass

class child extends parent;
    int c1;

    function new(input int pp1, pc1);
        super.new(pp1);
        c1 = pc1;        
    endfunction

    function void print();
        $display("child: p1 = %0d, c1 = %0d", p1, c1);
    endfunction
endclass

module inheritance;
    child child1;

    initial begin
        child1 = new(.pp1(4), .pc1(2));
        child1.print();
        child1.p1 = 9;
        child1.print();
    end
endmodule
