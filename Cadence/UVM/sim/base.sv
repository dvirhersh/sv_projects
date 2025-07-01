virtual class base;

    string inst;
    base   parent;

    function new(string name, base up = null);
        inst   = name;
        parent = up;
    endfunction

    function string pathname();
        base ptr = this;
        pathname = inst;
        while (ptr.parent != null) begin
            ptr = ptr.parent;
            pathname = {ptr.inst, ".", pathname};
        end
    endfunction

endclass
