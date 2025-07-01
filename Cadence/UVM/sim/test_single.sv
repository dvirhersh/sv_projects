driver port0_drv;
monitor port0_mon;

initial begin
    port0_drv = new("drv0", this);
    port0_drv.pif = p0;
    port0_drv.seqr = new("seqr0", port0_drv);

    port0_mon = new("mon0", this);
    port0_mon.pif = p0;
    port0_mon.portno = 0;

    fork
        port0_mon.run();
        port0_drv.run(5);
    join
end
