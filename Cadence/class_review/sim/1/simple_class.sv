`timescale 1ns/1ps

class BasicFrame;
    // Class properties
    rand bit [3:0] addr;
    rand bit [7:0] data;

    // Constructor
    function new(input bit [3:0] paddr);
        this.addr = paddr;
        this.data = $urandom;
    endfunction

    // Method to print the frame content
    function void print();
        $display("addr = 0x%0h, data = 0x%0h", addr, data);
    endfunction
endclass

module simple_class;
    // Object declarations
    BasicFrame frame1 = new(4'd3);
    BasicFrame frame2;

    initial begin
        frame1.print();

        frame1.addr = 4'd5;
        frame1.print();

        frame2 = new(4'd4);
        frame2.print();

        $stop;
    end
endmodule
