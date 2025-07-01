class parity_gen;
    function bit compute_parity(input bit [7:0] data);
        return ^data; // even parity
    endfunction
endclass

class frame_gen;
    local int count;
    bit parity;

    parity_gen pg;

    function new();
        pg = new();
    endfunction

    function int getcount();
        return count;
    endfunction

    function void setcount(input int a);
        count = a;
    endfunction
endclass

module test;
    initial begin
        automatic frame_gen fg = new();
        fg.setcount(42);
        $display("Count is: %0d", fg.getcount());
    end
endmodule
