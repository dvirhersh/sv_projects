import p1::*;

typedef logic [7:0] vec8;

module ParameterizedClasses;

    // int stack of depth 5 (default)
    stack #() intstack = new();

    // 8-bit vector stack, depth 4
    stack #(.st(vec8), .depth(4)) bytestack = new();

    int ret;
    int val_out;
    vec8 byte_out;

    initial begin
        // Push integers 10, 20 into intstack
        ret = intstack.push(10);
        $display("Push 10 -> ret = %0d", ret);
        ret = intstack.push(20);
        $display("Push 20 -> ret = %0d", ret);

        // Pop from intstack
        ret = intstack.pop(val_out);
        $display("Pop -> val_out = %0d, ret = %0d", val_out, ret);

        // Push bytes 8'hA5 and 8'h5A into bytestack
        ret = bytestack.push(8'hA5);
        $display("Push 0xA5 -> ret = %0d", ret);
        ret = bytestack.push(8'h5A);
        $display("Push 0x5A -> ret = %0d", ret);

        // Pop from bytestack
        ret = bytestack.pop(byte_out);
        $display("Pop -> byte_out = 0x%02h, ret = %0d", byte_out, ret);
    end

endmodule : ParameterizedClasses
