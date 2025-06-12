`timescale 1ns / 1ps

class baseframe;
    bit                [3:0] addr;
    rand protected bit [3:0] len;
    rand bit           [3:0] data_arr[];

    function new(input bit [3:0] paddr);
        addr = paddr;
    endfunction

    constraint frame_length { data_arr.size() == len; }
    constraint min_length   { len > 0; }

    function void post_randomize();
        $display("Randomization completed for addr = %0h", addr);
    endfunction

    function void print();
        $display("addr = %0h, len = %0d, data_arr.size() = %0d", addr, len, data_arr.size());
        $write("data_arr = ");
        foreach (data_arr[i]) $write("0x%01x ", data_arr[i]);
        $display("");
    endfunction
endclass

class shortframe extends baseframe;
    constraint length { len inside {[1:3]}; }

    function new(input bit [3:0] paddr);
        super.new(paddr);
    endfunction
endclass

class mediumframe extends baseframe;
    constraint length { len inside {[4:7]}; }

    int count;
    function new(input bit [3:0] paddr);
        super.new(paddr);
    endfunction
endclass

class longframe extends baseframe;
    constraint length { len inside {[8:15]}; }

    function new(input bit [3:0] paddr);
        super.new(paddr);
    endfunction
endclass

class multiframe;
    baseframe frame1;
    baseframe frame2;

    function new(input baseframe f1, input baseframe f2);
        this.frame1 = f1;
        this.frame2 = f2;
    endfunction
endclass

module rand_frame_len_module;
    shortframe  short_frame4  = new(4'h5);
    mediumframe medium_frame5 = new(4'h7);
    longframe   long_frame6   = new(4'h9);
    multiframe  one;
    int ok;

    initial begin
        // Randomize all frames and check for success
        ok = short_frame4.randomize();
        if (!ok) $fatal(1, "Randomization failed for short_frame4");

        ok = medium_frame5.randomize();
        if (!ok) $fatal(1, "Randomization failed for medium_frame5");

        ok = long_frame6.randomize();
        if (!ok) $fatal(1, "Randomization failed for long_frame6");

        short_frame4.print();
        medium_frame5.print();
        long_frame6.print();

        // Pass already-randomized frames into multiframe
        one = new(short_frame4, medium_frame5);

        // Access and modify multiframe fields
        one.frame1.data_arr[0] = 4'b0000;

        // Optional: cast to access mediumframe.count
        // if ($cast(mediumframe mf, one.frame2)) begin
            // mf.count = 2;
            // $display("mediumframe count set to %0d", mf.count);
        // end
    end
endmodule
