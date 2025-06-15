import p1::*;

module moda;

    base bout;
    sub  s1 = new();

    initial begin
        bout = s1;  // Upcast: sub to base
        bout.iam();  // Dynamic dispatch → prints "Short Frame"
    end

endmodule
