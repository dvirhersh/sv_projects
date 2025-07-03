package packet_pkg;

	class Packet;
		rand bit [3:0] src;
		rand bit [3:0] tgt;
		rand bit [7:0] data;

		string name;

		// Constructor includes optional instance name
		function new(input string name = "pkt",  input bit [3:0] src = 4'h0, 
					 input bit [3:0] tgt = 4'h0, input bit [7:0] data = 8'h00);
			this.name = name;
			this.src  = src;
			this.tgt  = tgt;
			this.data = data;
		endfunction

		function bit [15:0] pack();
			return {tgt, src, data};
		endfunction

		function void unpack(input bit [15:0] raw);
			tgt  = raw[15:12];
			src  = raw[11:8];
			data = raw[7:0];
		endfunction

		function void print(input string prefix = "");
			$display("%s[%s] tgt=0x%0h src=0x%0h data=0x%0h", prefix, name, tgt, src, data);
		endfunction
	endclass

	class fourpacket;
		Packet p[4];

		function new();
            foreach (p[i]) begin
                p[i] = new($sformatf("p[%0d]", i));
                void'(p[i].randomize());
            end
		endfunction

		function void deep_print();
			$display("---- FourPacket Dump ----");
			foreach (p[i]) begin
				$write("p[%0d] -> ", i);
				p[i].print();
			end
		endfunction
	endclass
	
endpackage
