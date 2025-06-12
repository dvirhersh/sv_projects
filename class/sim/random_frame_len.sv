`timescale 1ns/1ps

class randframe;
         local bit [3:0] addr;
    rand local bit [3:0] len;
    rand       bit [3:0] data_arr[];

    function new(input bit[3:0] paddr);
        addr = paddr;
    endfunction 

    constraint frame_length{
        data_arr.size() == len; }

    constraint min_length{ len > 0; }


    function void post_randomize();
        $display("Dvir 1");
        data_rand();
        $display("Dvir 3");
    endfunction 

    function void data_rand();
        data_arr = new[len];
        foreach (data_arr[i])
            data_arr[i] = $urandom;
        $display("Dvir 2");
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
    randframe frame4 = new(.paddr(4));
    randframe frame5 = new(.paddr(5));
    int ok;

    initial begin
        ok = frame4.randomize();
        if (!ok)
            $fatal(1, "Randomization failed for frame4 at time %0t", $time);
        frame4.print();

        ok = frame5.randomize();
        if (!ok)
            $fatal(1, "Randomization failed for frame5 at time %0t", $time);
        frame5.print();

        $finish;
    end
endmodule
