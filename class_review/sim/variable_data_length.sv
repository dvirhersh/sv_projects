`timescale 1ns/1ps

 class varframe;
          bit [3:0] addr;
    local bit [3:0] len;
          bit [7:0] data_arr[];

    function new(input bit [3:0] paddr, plen=7);
        addr = paddr;
        len  = plen;
        data_arr = new[len];
        foreach (data_arr[i]) begin
            data_arr[i] = $urandom;
        end
    endfunction : new

    function void print;
        $display("addr = %0h, len = %0d, data_arr.size() = %0d", addr, len, data_arr.size());
        $write("data_arr = ");
        foreach (data_arr[i]) begin
            $write("0x%02x ", data_arr[i]);
        end
//        $display("data_arr = 0x%02x", data_arr); // print address of data_arr
        $display(""); // for newline
    endfunction : print

    
 endclass : varframe

module varframe_module;
    varframe frame1;
    varframe frame2;

    initial begin
        frame1 = new(.paddr(5), .plen(8));
        frame1.print();
        frame1.addr = 4;
        frame1.print();
//        frame1.len  = 0;.. Local property len not visible here
        frame2 = new(.paddr(3), .plen(2));
        frame2.print();

        $finish;
    end
endmodule
