`timescale 1ns / 1ps

class RandFrame;

    local bit          [3:0] addr;
    rand protected bit [3:0] len;
    bit                [7:0] data_arr[];

    function new(input bit [3:0] paddr);
        addr = paddr;
    endfunction

    function void iam();
        $display("Rand Frame");
    endfunction : iam
endclass

class ShortFrame extends RandFrame;

    bit s1;

    constraint length {len > 0; len < 4;}

    function new(input bit [3:0] paddr);
        super.new(paddr);
    endfunction

    function void iam();
        $display("Short Frame");
    endfunction : iam

endclass : ShortFrame

module CopySubclassInstToParentHandle;
    RandFrame  rand_f;
    ShortFrame short_f_first = new(4'd5);
    ShortFrame short_f_second;
    int ok;

    initial begin
        rand_f = short_f_first;
        rand_f.iam();
        // bframe1.s1 = 1'b1; // Error

        $cast(short_f_second, rand_f);
        short_f_second.iam();
        short_f_second.s1 = 1'b1;

        $display("short_f_first.s1 = %0d", short_f_first.s1);

        $stop;
    end
endmodule
