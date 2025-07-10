`ifndef CFS_ALGN_TEST_PKG_SV
	`define CFS_ALGN_TEST_PKG_SV

	`include "uvm_macros.svh"
	`include "../verif/cfs_algn_pkg.sv"

	package cfs_algn_test_pkg;
		import uvm_pkg::*;
		import cfs_algn_pkg::*;
		import cfs_apb_pkg::*;

		`include "cfs_algn_test_base.sv"
		`include "cfs_algn_test_reg_access.sv"

	endpackage

`endif