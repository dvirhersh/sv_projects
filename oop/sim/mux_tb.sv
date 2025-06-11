`timescale 1ns/1ps

class stimulus;
    rand bit sel, a, b;

    function void display();
        $display("sel=%0b a=%0b b=%0b", sel, a, b);
    endfunction
endclass

module mux_tb;
    logic sel, a, b, y;

    mux uut (.sel(sel), .a(a), .b(b), .y(y));

    stimulus s;

    initial begin
        s = new();
        repeat (5) begin
            void'(s.randomize());
            sel = s.sel; a = s.a; b = s.b;
            #5;
            s.display();
            $display("y=%0b\n", y);
        end
        $finish;
    end
endmodule
