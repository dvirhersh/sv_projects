`timescale 1ns / 1ps

class Parent;
    bit [3:0] avec;
    bit       abit;

    function void print();
        $display("Parent: avec = %0d, abit = %0b", avec, abit);
    endfunction
endclass

class Child extends Parent;
    int       avec;  // Shadows Parent.avec
    bit [7:0] abyte;

    function void print();
        super.print();
        $display("Child : avec = %0d, abyte = 0x%0h", this.avec, abyte);
    endfunction
endclass

module SimpleInheritReview;
    Child one = new();

    initial begin
        one.super.avec = 3;
        one.avec       = 4;
        one.abit       = 1'b1;
        one.abyte      = 8'hff;
        one.print();
    end
endmodule
