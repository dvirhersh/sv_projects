package package_like_uvm;
    typedef enum {sgle, mult, rnd} seqr_ctrl_e;
    `include "packet.sv"
    `include "psingle.sv"
    `include "pmulticast.sv"
    `include "base.sv"
    `include "sequencer.sv"
    `include "driver.sv"
    `include "monitor.sv"
    `include "pds_vc.sv"
endpackage : package_like_uvm
