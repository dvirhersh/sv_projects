`timescale 1ns / 1ps

class RandFrame;

         local bit [3:0] addr;
    rand local bit [3:0] len;
               bit [3:0] data_arr[];

    // Constructor
    function new(input bit [3:0] paddr);
        addr = paddr;
    endfunction

    function void post_randomize();
        $display("Dvir debug 1");
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
        foreach (data_arr[i]) $write("0x%02x ", data_arr[i]);
        $display("");  // newline
    endfunction
endclass

module RandFrameModule;
    RandFrame frame1 = new(.paddr(4'd5));
    int ok;

    initial begin
        $display("Dvir debug 0");
        ok = frame1.randomize();
        $display("Dvir debug 2");
        frame1.print();
        $stop;
    end
endmodule
