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

	endclass : base

	class sequencer extends base;

		function new(input string name, base up);
			super.new(name, up);
		endfunction

	endclass : sequencer

	class pds_vc extends base;

		sequencer seqr;

		function new(input string name, base up);
			super.new(name, up);
			seqr = new("seqr", this);
		endfunction

	endclass : pds_vc

endpackage : class_package
