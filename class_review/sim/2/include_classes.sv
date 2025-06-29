`timescale 1ns / 1ps

class RandFrame;

    local bit          [3:0] addr;
    rand protected bit [3:0] len;
    bit                [7:0] data_arr[];

    function new(input bit [3:0] paddr);
        addr = paddr;
    endfunction

    function void post_randomize();
        $display("post_randomize called");
        data_rand();
    endfunction

    function void data_rand();
        data_arr = new[len];
        foreach (data_arr[i]) data_arr[i] = $urandom;
    endfunction

    function void print();
        $display("=== RandFrame Info ===");
        $display("addr = 0x%0h, len = %0d, data_arr.size() = %0d", addr, len, data_arr.size());
        $write("data_arr = ");
        foreach (data_arr[i]) $write("0x%02x ", data_arr[i]);
        $display("\n=======================");
    endfunction
endclass

class ShortFrame extends RandFrame;
    constraint length {
        len > 0;
        len < 4;
    }

    function new(input bit [3:0] paddr);
        super.new(paddr);
    endfunction
endclass

class MediumFrame extends RandFrame;
    constraint length {
        len > 3;
        len < 8;
    }

    function new(input bit [3:0] paddr);
        super.new(paddr);
    endfunction
endclass

class LongFrame extends RandFrame;
    constraint length {
        len > 7;
        len < 16;
    }

    function new(input bit [3:0] paddr);
        super.new(paddr);
    endfunction
endclass

class Parent;
  bit [3:0] avec;
  bit       abit;

  function void print();
    $display("Parent: avec = %0d, abit = %0b", avec, abit);
  endfunction
endclass

class Child extends Parent;
  int       avec;  // Shadows Parent.avec
  bit [7:0] abyte;

  function void print();
    super.print();
    $display("Child : avec = %0d, abyte = 0x%0h", this.avec, abyte);
  endfunction
endclass
