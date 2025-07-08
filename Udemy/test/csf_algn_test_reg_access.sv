`ifndef CFS_ALGN_TEST_REG_ACCESS_SV
	`define CFS_ALGN_TEST_REG_ACCESS_SV

	class csf_algn_test_reg_access extends uvm_algn_test_base;

		`uvm_componect_utils(csf_algn_test_reg_access)

		function new(string name = "", uvm_component parent);
			super.new(name, parent);
		endfunction

		virtual task run_phase(uvm_phase phase);
			phase.raise_objection(this, "TEST_DONE");

			`uvm_info("DEBUG", "start of test", UVM_LOW)

			#100 ns;

			`uvm_info("DEBUG", "end of test", UVM_LOW)

			phase.drop_objection(this, "TEST_DONE");
		endtask
		
	endclass : csf_algn_test_reg_access

`endif