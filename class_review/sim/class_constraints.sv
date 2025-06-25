`timescale 1ns / 1ps

class RandFrame;

         local bit [3:0] addr;
    rand local bit [3:0] len;
    rand       bit [7:0] data_arr[];

    function new(input bit [3:0] paddr);
        addr = paddr;
    endfunction

    constraint frame_length { 
        data_arr.size() == len; }
    
    constraint min_length   { 
        len > 0; }

    function void print();
        $display("=== RandFrame Info ===");
        $display("addr = 0x%0h, len = %0d, data_arr.size() = %0d", addr, len, data_arr.size());
        $write("data_arr = ");
        foreach (data_arr[i]) 
            $write("0x%02x ", data_arr[i]);
        $display("\n=======================");
    endfunction

endclass


module ClassConstraintsModule;
    RandFrame frame1 = new(4'd5);
    int ok;

    initial begin
        for (int i = 0; i < 3; i++) begin
            ok = frame1.randomize();
            if (!ok) 
                $fatal("Randomization failed on iteration %0d", i);
            frame1.print();
        end
        $stop;
    end

endmodule
