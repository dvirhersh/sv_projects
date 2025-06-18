`timescale 1ns / 1ns

`include "base.sv"
`include "packet.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "factory.sv"
`include "pds_if.sv"

module top;

    bit clk = 0;
    bit rst = 0;
    always #5 clk = ~clk;

    pds_if pif (
        clk,
        rst
    );

    sequencer seqr;
    driver    drv;
    monitor   mon;

    initial begin
        rst = 1;
        #20;
        rst = 0;
        #10;

        seqr        = new("seqr", null);
        seqr.portno = 1;

        drv         = new("drv", null);
        drv.pif     = pif;
        drv.seqr    = seqr;

        mon         = new("mon", null);
        mon.pif     = pif;
        mon.portno  = 1;

        fork
            mon.run();
            drv.run(5);
        join

        #100;
        $finish;
    end

    dut dut_inst (pif);

endmodule
