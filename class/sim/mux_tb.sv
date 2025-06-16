`timescale 1ns/1ps

class stimulus;
    rand bit sel, a, b;

    function void display();
        $display("sel = %0b, a = %0b, b = %0b", sel, a, b);
    endfunction
endclass

 class basicframe;
     bit [3:0] addr;
     bit [7:0] data;

     // explicit constructor
     function new(input bit [3:0] paddr);
         addr = paddr;
         data = $urandom;
     endfunction : new

     function void print;
         $display("addr = %h, data =  %h", addr, data);
     endfunction : print
    
 endclass

module mux_tb;
    logic sel, a, b, y;

    mux uut (.sel(sel), .a(a), .b(b), .y(y));

    stimulus s;
        basicframe frame1 = new(.paddr(3));
        basicframe frame2;

    initial begin

        frame2 = new(.paddr(4));
        frame1.addr = 5;
        frame1.print();
        frame2.print();

        s = new();
        repeat (5) begin
            void'(s.randomize());
            sel = s.sel; a = s.a; b = s.b;
            #5;
            s.display();
            $display("y = %0b\n", y);
        end
        $finish;
    end
endmodule


