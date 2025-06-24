`timescale 1ns / 1ps

class RandFrame2;

         local bit [3:0] addr;
    rand       bit [3:0] len;
               bit [7:0] data_arr[];

    // Constructor
    function new(input bit [3:0] paddr);
        addr = paddr;
    endfunction

    function void post_randomize();
        data_rand();
    endfunction

    function void data_rand();
        data_arr = new[len];
        foreach (data_arr[i]) 
            data_arr[i] = $urandom;
    endfunction

    function void print();
        $display("addr = 0x%0h, len = %0d, data_arr.size() = %0d", addr, len, data_arr.size());
        $write("data_arr = ");
        foreach (data_arr[i]) 
            $write("0x%02x ", data_arr[i]);
        $display();  // newline
    endfunction

endclass

module InLineConstraintsModule;
    RandFrame2 frame1 = new(4'd5);
    int ok;

  initial begin
        ok = frame1.randomize() with { len > 0; len <= 7; };
        if (!ok) 
            $fatal("Randomization failed (range 1–7)");
        frame1.print();

        ok = frame1.randomize() with {len dist { [1 :  7] := 1, [8 : 15] := 2}; };
        if (!ok) 
            $fatal("Randomization failed (dist)");
        frame1.print();

        $stop;
    end

endmodule
