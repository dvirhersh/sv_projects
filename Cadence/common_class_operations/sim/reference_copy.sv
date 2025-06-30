import class_operations::*;

module RefCopy;

    baseframe b1, b2, b3;
    multiframe m1, m2;

    initial begin
        b1 = new(5);
        
        // == Reference Copy ==
        b2 = b1; // copy
        $display("\n== Rerference copy ==\n");
        b1.addr = 8;
        $display("b2.addr = %0d", b2.addr); 
        b1 = null;
        
        // Clone
        b1 = new(5);
        b3 = new(1);
        b3.addr = b1.addr;
        $display("b3.addr = %0d", b3.addr); 
        b3 = null;
        // Easier clone
        b3 = new b1;
        b3.addr = 11;
        $display("b3.addr = %0d", b3.addr);

        // Shallow and Deep Clone
        m1 = new(4);
        m1.num = 5;
        m2 = new m1; // shallow clone

        // change values and check changing
        m1.num = 3;
        m1.f1.addr = 9;
        $display("\n== shallow clone ==\n");
        $display("m1.num = %0d, m2.num = %0d", m1.num, m2.num); // m2.num is independent
        $display("m1.f1.addr = %0d, m2.f1.addr = %0d", m1.f1.addr, m2.f1.addr); // m2.f1.addr is like m1!

        m1 = null;
        m2 = null;

        // Deep Cloning
        m1 = new(7);
        m1.num = 5;
        
        m2 = new(8);
        m2.num = m1.num;
        m2.f1.addr = m1.f1.addr;
        
        m1.f1.addr = 9;
        $display("\n== deep clone ==\n");
        $display("m1.num = %0d, m2.num = %0d", m1.num, m2.num); // m2.num is independent
        $display("m1.f1.addr = %0d, m2.f1.addr = %0d", m1.f1.addr, m2.f1.addr); // m2.f1.addr is like m1!

    end
endmodule