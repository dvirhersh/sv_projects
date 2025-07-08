`ifndef CFS_ALGN_TEST_BASE_SV
	`define CFS_ALGN_TEST_BASE_SV

	class csf_algn_test_base extends uvm_test;

		cfs_algn_env env;

		`uvm_componect_utils(csf_algn_test_base)

		function new(string name = "", uvm_component parent);
			super.new(name, parent);
		endfunction

		virtual function void build_phase(uvm_phase phase);
			super.build_phase(phase);

			env = cfs_algn_env::type_id::create("env", this);
		endfunction : build_phase
		
	endclass : csf_algn_test_base

`endif