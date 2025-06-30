`timescale 1ns / 1ps

class RandFrame;

         local bit [3:0] addr;
    rand local bit [3:0] len;
               bit [7:0] data_arr[];

    function new(input bit [3:0] paddr);
        addr = paddr;
    endfunction

    function void post_randomize();
        $display("Dvir debug: post_randomize called");
        data_rand();
    endfunction

    function void data_rand();
        data_arr = new[len];
        foreach (data_arr[i])
            data_arr[i] = $urandom;
    endfunction

    function void print();
        $display("=== RandFrame Info ===");
        $display("addr = 0x%0h, len = %0d, data_arr.size() = %0d", addr, len, data_arr.size());
        $write("data_arr = ");
        foreach (data_arr[i]) 
            $write("0x%02x ", data_arr[i]);
        $display("\n=======================");
    endfunction

endclass

module RandFrameModule;
    RandFrame frame1 = new(.paddr(4'd5));
    int ok;

    initial begin
        frame1.print();
        $display("Dvir debug: randomizing frame1...");
        ok = frame1.randomize();
        if (!ok)
            $fatal(1, "Randomization failed for frame1");

        frame1.print();

        $stop;
    end
endmodule
