// import packet_pkg::*;

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
		endfunction
	endclass

	class Packet;
		rand bit [3:0] source;
		rand bit [3:0] tgt;
		rand bit [7:0] data;

		string name;

		// Constructor includes optional instance name
		function new(input string name = "pkt", input bit [3:0] source = 4'h0,
					input bit [3:0] tgt = 4'h0, input bit [7:0] data = 8'h00);
		this.name = name;
		this.source = source;
		this.tgt = tgt;
		this.data = data;
		endfunction

		function bit [15:0] pack();
		return {tgt, source, data};
		endfunction

		function void unpack(input bit [15:0] raw);
		tgt = raw[15:12];
		source = raw[11:8];
		data = raw[7:0];
		endfunction

		function void print(input string prefix = "");
		$display("%s[%s] tgt=0x%0h source=0x%0h data=0x%0h", prefix, name, tgt, source, data);
		endfunction
	endclass

	class psingle extends Packet;
		function new(input string name = "psingle");
		super.new(name);
		endfunction
	endclass

	class pmulticast extends Packet;
		function new(input string name = "pmulticast");
		super.new(name);
		endfunction
	endclass

	class sequencer extends base;
		int 	   ok;
		int        portno;
		psingle    single;
		pmulticast multi;

		function new(input string name, base up);
			super.new(name, up);
		endfunction

		function void print();
			$display("@ ",this.pathname());
		endfunction : print

		function void get_next_item(output Packet pkt);
			randcase
				1: begin
					single = new("single");
					single.source = portno;
					ok = single.randomize();
					pkt = single;
				end
				2: begin
					multi = new("multi");
					multi.source = portno;
					ok = multi.randomize();
					pkt = multi;
				end
			endcase			
		endfunction
	endclass

	class pds_vc extends base;
		sequencer seqr;

		function new(input string name, base up);
			super.new(name, up);
			seqr = new("seqr", this);
		endfunction
	endclass

	class testbench extends base;
		pds_vc pds1;

		function new(input string name, base up);
			super.new(name, up);
			pds1 = new("pds1", this);
		endfunction
	endclass

endpackage : class_package
