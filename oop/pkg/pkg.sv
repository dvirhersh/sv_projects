package p1;

    class base;
        virtual function void iam();
        $display("Base Frame");
        endfunction
    endclass

    class sub extends base;
        function void iam();
        $display("Short Frame");
        endfunction : iam
    endclass : sub

endpackage : p1
