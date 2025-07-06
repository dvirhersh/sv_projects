class packet #(int DATA_WIDTH = 8);
	rand bit [3:0] source, target;
	rand bit [DATA_WIDTH-1:0] data;
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
		$display("@%0t pS Packet - Source: %0h, Target: %0h, Data: 0x%0h", $time, source, target, data);
	endfunction

	function bit compare(packet p);
		return (p.source == source && p.target == target && p.data == data);
	endfunction

endclass
