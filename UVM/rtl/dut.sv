module dut (
    pds_if.dut pif
);

    always_ff @(posedge pif.clk or posedge pif.reset) begin
        if (pif.reset) begin
            pif.data_op  <= 0;
            pif.valid_op <= 0;
        end else if (pif.valid_up) begin
            pif.data_op  <= pif.data_ip + 1;
            pif.valid_op <= 1;
        end else begin
            pif.valid_op <= 0;
        end
    end

endmodule
