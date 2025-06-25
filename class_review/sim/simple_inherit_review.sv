`timescale 1ns / 1ps

class parent;
    bit [3:0] avec;
    bit       abit;

    function void print();
        $display("parent: avec = %0d, abit = %0b", avec, abit);
    endfunction
endclass

class child extends parent;
    int       avec;  // Shadows parent.avec
    bit [7:0] abyte;

    function void print();
        super.print();
        $display("child : avec = %0d, abyte = 0x%0h", this.avec, abyte);
    endfunction
endclass

module SimpleInheritReview;
    child one = new();

    initial begin
        one.super.avec = 3;  // Explicitly set parent's avec
        one.avec       = 4;  // Child's avec
        one.abit       = 1'b1;
        one.abyte      = 8'hff;  // Will now display as 0xFF
        one.print();
    end
endmodule
