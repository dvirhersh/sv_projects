class baseframe;

    bit                [3:0] addr;
    rand protected bit [3:0] len;
    rand bit           [3:0] data_arr[];

    function new(input bit [3:0] paddr);
        addr = paddr;
    endfunction

    constraint frame_length {data_arr.size() == len;}
    constraint min_length {len > 0;}

    function void post_randomize();
        $display("Randomization completed for addr = %0h", addr);
    endfunction

    function void print();
        $display("addr = %0h, len = %0d, data_arr.size() = %0d", addr, len, data_arr.size());
        $write("data_arr = ");
        foreach (data_arr[i]) $write("0x%01x ", data_arr[i]);
        $display("");
    endfunction

    function void iam();
        $display("Base Frame");
    endfunction
endclass

class shortframe extends baseframe;
    bit s1;
    constraint length {len inside {[1 : 3]};}

    function new(input bit [3:0] paddr);
        super.new(paddr);
    endfunction

  function void iam();
    $display("Short Frame");
  endfunction
endclass

module rand_frame_len_module;
    baseframe  bf;
    shortframe sf = new(4'h5);
    int ok;

    initial begin
        bf = sf;

    bf.iam();  // "Base Frame"
//        bf.s1 = 1'b1; // error 
    end
endmodule
