class driver extends base;

	virtual pds_if pif; 
	packet    	   pkt;
	sequencer 	   sref;

	function new(input string name, base up);
		super.new(name, up);
	endfunction

	task run(int count);
		repeat (count) begin
			sref.get_next_item(pkt);  // Get a packet from the sequencer
			send_to_dut(pkt);  // Drive it to the DUT
		end
	endtask : run

	task send_to_dut(input packet pkt);
		pif.drive_packet(pkt);  // Call the interface task
		pkt.print();
	endtask : send_to_dut

	function void print();
        $display("@ %s", this.pathname());
    endfunction : print

endclass : driver
