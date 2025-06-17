class monitor extends base;

	virtual pds_if pif;
	int            portno;

	function new(input string name, base up);
		super.new(name, up);
	endfunction

	task run();
		checkport();
	endtask : run

	task checkport();
		pif.monitor(portno);
	endtask : checkport
		
endclass : monitor