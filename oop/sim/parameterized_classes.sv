module stack_demo;

    typedef bit [7:0] vec8;

    // Stack class definition
    class stack #(type st = int, int depth = 5);
        local st  data [depth-1:0];
        local int pointer = 0;

        function int push(input st indat);
            if (pointer < depth) begin
                data[pointer] = indat;
                pointer++;
                return 1;
            end else begin
                $display("Stack overflow");
                return 0;
            end
        endfunction

        function int pop(output st outdat);
            if (pointer > 0) begin
                pointer--;
                outdat = data[pointer];
                return 1;
            end
            else begin
                $display("Stack underflow");
                return 0;
            end
        endfunction
    endclass

    stack           instack = new();               // Default int stack
    stack #(vec8,4) bytestack = new();             // 8-bit vector stack of depth 4

    int   i_val;
    vec8  b_val;

    initial begin
        $display("--- Integer Stack ---");
        for (int i = 0; i < 6; i++) begin
            instack.push(i);
        end

        repeat (6) begin
            if (instack.pop(i_val)) begin
                $display("Popped from int stack: %0d", i_val);
            end
        end

        $display("\\n--- Byte Stack ---");
        for (int j = 0; j < 4; j++) begin
            bytestack.push(j * 8'h11);
        end

        repeat (5) begin
            if (bytestack.pop(b_val)) begin
                $display("Popped from byte stack: 0x%0h", b_val);
            end
        end

        $finish;
  end

endmodule
