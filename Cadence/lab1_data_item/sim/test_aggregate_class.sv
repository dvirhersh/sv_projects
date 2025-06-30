`timescale 1ns / 1ps

module test_aggregate_class;
    
    fourpacket fp = new();
    
    initial begin

        foreach (fp.p[i])
            fp.p[i].randomize();

        fp.deep_print();
    end
endmodule
