`timescale 1ns/1ps

class randframe;
         local bit [3:0] addr;
    rand local bit [3:0] len;
               bit [3:0] data_arr[];

    function new(input bit[3:0] paddr);
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

    function void print;
        $display("addr = %0h, len = %0d, data_arr.size() = %0d", addr, len, data_arr.size());
        $write("data_arr = ");
        foreach (data_arr[i]) begin
            $write("0x%01x ", data_arr[i]); 
        end
        $display(""); 
    endfunction : print

endclass

module rand_frame_len_module;
    randframe frame3 = new(.paddr(5));
    integer ok;

    initial begin
        ok = frame3.randomize();
        if (!ok)
            $fatal(1, "Randomization failed for frame3 at time %0t", $time);
        frame3.print();
        $finish;

    end
endmodule
