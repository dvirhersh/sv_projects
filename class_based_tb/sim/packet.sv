class packet;
	rand bit [3:0] source;
	rand bit [3:0] target;
	rand bit [7:0] data;
    string         inst;
	int			   pkt_num;

	function new(input string name, int num = 0);
		source  = 0;
		target  = 0;
		data    = 8'h00;
		inst    = name;
        pkt_num = num;
	endfunction

	function void print();
		$display("Packet - Source: %0d, Target: %0d, Data: 0x%0h", source, target, data);
	endfunction
endclass
