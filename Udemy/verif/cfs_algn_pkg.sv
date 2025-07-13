`ifndef CFS_ALGN_PKG_SV
	`define CFS_ALGN_PKG_SV

	`include "uvm_macros.svh"
	`include "apb_env/cfs_apb_pkg.sv"
	`include "md_env/cfs_md_pkg.sv"

	package cfs_algn_pkg;
		import uvm_pkg::*;
		import cfs_apb_pkg::*;
		import cfs_md_pkg::*;

		`include "cfs_algn_env.sv"
	endpackage

`endif