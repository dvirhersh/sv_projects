package p1;

    class base;
        local bit [3:0] addr;
        rand protected bit [3:0] len;
        bit [7:0] data_arr[];

        function new(input bit [3:0] paddr);
            addr = paddr;
        endfunction

        function void iam();
            $display("Rand Frame");
        endfunction
    endclass

    class sub extends base;
        bit s1;

        constraint length {len > 0; len < 4;}

        function new(input bit [3:0] paddr);
            super.new(paddr);
        endfunction

        function void iam();
            $display("Short Frame");
        endfunction
    endclass : sub

    virtual class Basic;
        pure virtual function void iam();
        //     $display("I'm a Basic");            
        // endfunction
    endclass

    class Parent extends Basic;
        bit [3:0] avec;
        bit       abit;

        function void print();
            $display("Parent: avec = %0d, abit = %0b", avec, abit);
        endfunction

        virtual function void iam();
            $display("I'm a Parent");            
        endfunction : iam
  endclass

    class Child extends Parent;
        int       avec;  // Shadows Parent.avec
        bit [7:0] abyte;

        function void print();
            super.print();
            $display("Child : avec = %0d, abyte = 0x%0h", this.avec, abyte);
        endfunction

        virtual function void iam();
            $display("I'm a Child");            
        endfunction : iam
    endclass

    class stack #(type st = int, int depth = 5);
        local st  data[depth];
        local int pointer = 0;

        // Push: returns 0 on success, -1 on overflow
        function int push(input st indat);
            if (pointer >= depth) begin
                return -1;  // overflow
            end
            data[pointer] = indat;
            pointer++;
            return 0;
        endfunction : push

        // Pop: returns 0 on success, -1 on underflow
        function int pop(output st outdat);
            if (pointer <= 0) begin
                return -1;  // underflow
            end
            pointer--;
            outdat = data[pointer];
            return 0;
        endfunction : pop

  endclass : stack

endpackage : p1
  