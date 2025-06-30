`timescale 1ns / 1ps

import class_operations::*;

module aggregate_class;

    multiframe one = new(2);
    baseframe  bc1 = new(6, "bc1");
    baseframe  bc2;

    initial begin
        one.num = 42;
        one.frame1.b1 = 1;
        one.frame2.b1 = 3;
        one.print();

        // =========== Object copying test ===========
        $display("bc1 name = %s", bc1.getname());

        // Clone bc1 to bc2 (use copy constructor if needed)
        // bc2 = new(bc1.getname());
        bc2 = new bc1;
        $display("bc2 (copy of bc1) name = %s", bc2.getname());

        bc2.setname("bc2");
        $display("bc2 (renamed) name = %s", bc2.getname());
    end
endmodule
