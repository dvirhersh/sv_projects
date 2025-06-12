`timescale 1ns/1ps

class randframe;
                    bit [3:0] addr;
    rand protected  bit [3:0] len;
    rand            bit [3:0] data_arr[];

    function new(input bit [3:0] paddr);
        addr = paddr;
    endfunction

    constraint frame_length {
        data_arr.size() == len;
    }

    constraint min_length {
        len > 0;
    }

    function void post_randomize();
        // No need to manually assign with $urandom
        $display("Randomization completed for addr = %0h", addr);
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

class shortframe extends randframe;
    constraint length { len > 0; len < 3; }

    function new(input bit [3:0] paddr);
        super.new(paddr);
    endfunction
endclass

module rand_frame_len_module;
    shortframe short_frame4 = new(5);
    int ok;

    initial begin
        ok = short_frame4.randomize();
        if (!ok) $fatal(1, "Randomization failed");
        short_frame4.print();
    end
    
    
endmodule
