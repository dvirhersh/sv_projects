import p1::*;

module modb(input base bin);

    sub s2;

    always @ (bin) begin
        if (!$cast(s2, bin)) begin
            $display("Cast failed",);
        end else begin
            s2.iam(); // Will call sub's iam()
        end
    end

endmodule
