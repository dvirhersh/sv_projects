`ifndef CFS_MD_PKG_SV
    `define CFS_MD_PKG_SV

    `include "uvm_macros.svh"

    `include "cfs_md_if.sv"

    package cfs_md_pkg;

        import uvm_pkg::*;

        `include "cfs_md_types.sv"
        `include "cfs_md_reset_handler.sv"
        `include "cfs_md_item_base.sv"
        `include "cfs_md_item_drv.sv"
        `include "cfs_md_item_drv_master.sv"
        `include "cfs_md_item_mon.sv"
        `include "cfs_md_agent_config.sv"
        `include "cfs_md_agent_config_slave.sv"
        `include "cfs_md_agent_config_master.sv"
        `include "cfs_md_monitor.sv"
        `include "cfs_md_sequencer.sv"
        `include "cfs_md_sequencer_master.sv"
        `include "cfs_md_driver.sv"
        `include "cfs_md_driver_master.sv"
        `include "cfs_md_agent.sv"
        `include "cfs_md_agent_slave.sv"
        `include "cfs_md_agent_master.sv"

        `include "cfs_md_sequence_base.sv"
        `include "cfs_md_sequence_simple_master.sv"

    endpackage

`endif