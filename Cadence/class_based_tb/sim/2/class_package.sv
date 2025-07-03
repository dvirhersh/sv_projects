package class_package;

	virtual class base;

		protected string inst;
		protected base   parent;

		function new(input string name = "", base up = null);
			inst   = name;
			parent = up;
		endfunction

		function string get_name();
			return inst;
		endfunction

		function base get_parent();
			return parent;
		endfunction

		function string pathname();
			base ptr = this;
			pathname = inst;
			while (ptr.get_parent() != null) begin
				ptr = ptr.get_parent();
				pathname = {ptr.get_name(), ".", pathname};
			end
			
		endfunction : pathname

	endclass : base

	class sequencer extends base;

		int 	   ok;
		int        portno;
		// psingle    single;
		// pmulticast multi;

		function new(input string name, base up);
			super.new(name, up);
		endfunction

		function void print();
			$display("@ ",this.pathname());
		endfunction : print

	endclass : sequencer

	class pds_vc extends base;

		sequencer seqr;

		function new(input string name, base up);
			super.new(name, up);
			seqr = new("seqr", this);
		endfunction

	endclass : pds_vc

	class testbench extends base;

		pds_vc pds1;

		function new(input string name, base up);
			super.new(name, up);
			pds1 = new("pds1", this);
		endfunction

  endclass : testbench

endpackage : class_package
