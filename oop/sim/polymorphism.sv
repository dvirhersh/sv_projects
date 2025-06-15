class baseframe;

                   bit [3:0] addr;
    rand protected bit [3:0] len;
    rand           bit [3:0] data_arr[];

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

    virtual function void iam();
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


class mediumframe extends baseframe;
    constraint length {len inside {[4 : 7]};}
    int count;

    function new(input bit [3:0] paddr);
        super.new(paddr);
    endfunction

    function void iam();
        $display("Medium Frame");
    endfunction
endclass


module polymorphism;
    baseframe frame[7:0];
    shortframe sf;
    mediumframe mf;
    int ok;

    initial begin
        foreach (frame[i]) begin
        randcase
            2: begin
                sf = new(4'h0);
                ok = sf.randomize();
                if (!ok) $fatal("Randomization failed for shortframe");
                frame[i] = sf;
            end
            1: begin
                mf = new(4'h1);
                ok = mf.randomize();
                if (!ok) $fatal("Randomization failed for mediumframe");
                frame[i] = mf;
            end
        endcase
        end

        foreach (frame[i]) begin
            $display("---- Frame %0d ----", i);
            frame[i].iam();
            frame[i].print();
        end
    end
endmodule
