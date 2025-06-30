`timescale 1ns / 1ps

class VarFrame;
          bit [3:0] addr;
    local bit [3:0] len;
          bit [7:0] data_arr[];

    // Constructor
    function new(input bit [3:0] paddr, input bit [3:0] plen = 4'd7);
        addr     = paddr;
        len      = plen;
        data_arr = new[len];
        foreach (data_arr[i]) 
            data_arr[i] = $urandom;
    endfunction

    function void print();
        $display("addr = 0x%0h, len = %0d, data_arr.size() = %0d", addr, len, data_arr.size());
        $write("data_arr = ");
        foreach (data_arr[i]) 
            $write("0x%02x ", data_arr[i]);
        $display("");  // newline
    endfunction
endclass

module VarFrameModule;
    VarFrame frame1;
    VarFrame frame2;

    initial begin
        frame1 = new(.paddr(4'd5), .plen(4'd8));
        frame1.print();

        frame1.addr = 4'd4;
        frame1.print();
//        frame1.len  = 0;.. Local property len not visible here
        frame2 = new(.paddr(3), .plen(2));
        frame2.print();

        $stop;
    end
endmodule
