`timescale 1ns/1ps

 class basicframe;
    // class properties
    bit [3:0] addr;
    bit [7:0] data;

    // explicit constructor
    function new(input bit [3:0] paddr);
        addr = paddr;
        data = $urandom;
    endfunction : new

    // class method
    function void print;
        $display("addr = %h, data =  %h", addr, data);
    endfunction : print
    
 endclass

module simple_class;
    basicframe frame1 = new(.paddr(3));
    basicframe frame2;

    initial begin
        frame2 = new(.paddr(4));
        frame1.addr = 5;
        frame1.print();
        frame2.print();

        $finish;
    end
endmodule
