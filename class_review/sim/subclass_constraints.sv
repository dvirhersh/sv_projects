class basefram;
    local           bit[3:0] addr;
    rand protected  bit[3:0] len;
    rand            bit[7:0] data_arr[];

    function new(input bit[3:0] paddr);
        addr = paddr;
    endfunction

    function void print;
        $display("addr = %0h, len = %0d, data_arr.size() = %0d", addr, len, data_arr.size());
        $write("data_arr = ");
        foreach (data_arr[i]) begin
            $write("0x%01x ", data_arr[i]); 
        end
    endfunction : print
endclass

class shortframe extends superClass;
    function new();
        
    endfunction //new()
endclass //shortframe extends superClass