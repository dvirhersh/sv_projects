class parity_gen;
	function new();
	endfunction
endclass

class frame_gen;
	local int count;
	bit parity;

	parity_gen pg;

	function new();
		pg = new();
	endfunction : new

	function int getcount();
		return count;
	endfunction : getcount

	function void setcount(input int a);
		count = a;
	endfunction : setcount
endclass : frame_gen
