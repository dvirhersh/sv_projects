`timescale 1ns / 1ps

class RandFrame;
         local     bit [3:0] addr;
    rand protected bit [3:0] len;
                   bit [7:0] data_arr[];

    function new(input bit [3:0] input_address);
        addr = input_address;
    endfunction

    function void post_randomize();
        $display(">> post_randomize triggered");
        data_rand();
    endfunction

    function void data_rand();
        data_arr = new[len];
        foreach (data_arr[i])
            data_arr[i] = $urandom_range(0, 255);
    endfunction

    function void print();
        $display("=== RandFrame Info ===");
        $display("addr = 0x%0h, len = %0d, data_arr.size() = %0d", addr, len, data_arr.size());
        $write("data_arr = ");
        foreach (data_arr[i])
            $write("0x%02x ", data_arr[i]);
        $display("\n=================");
    endfunction
endclass

class MultiFrame;
    int count;
    rand RandFrame frame1;
    rand RandFrame frame2;

    function new(input bit [3:0] f1adr, input bit [3:0] f2adr);
        frame1 = new(f1adr);
        frame2 = new(f2adr);
    endfunction

    function void print();
        $display("--- Frame Aggregator ---");
        frame1.print();
        frame2.print();
    endfunction
endclass

module AggregateClasses;
    MultiFrame multi_frame;
    int ok;

    initial begin
        multi_frame = new(.f1adr(4'd2), .f2adr(4'd3));
        multi_frame.count = 2;

        ok  = multi_frame.frame1.randomize();
        ok &= multi_frame.frame2.randomize();

        if (!ok)
            $fatal(1, "Randomization failed for one or both frames");

        multi_frame.print();

        multi_frame.frame1.data_arr[0] = 8'h4;
        multi_frame.print();

        $stop;
    end
endmodule
