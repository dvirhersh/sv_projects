import class_package::*;

module parent_handle;

	testbench tb1 = new("tb1", null);
	base      ptr;
	Packet    pkt;
	sequencer seqr;  // local alias to simplify access

	initial begin
		seqr = tb1.pds1.seqr;

		// Print initial info
		seqr.print();

		// Walk up the parent chain
		ptr = seqr;
		for (int i = 1; i <= 10; i++) begin
			if (ptr != null) 
				$display("%0d ptr.inst = %0s", i, ptr.get_name());
			else begin
				$display("%0d Reached top-level (no parent)", i);
				break;
			end
			ptr = ptr.get_parent();
		end

		// Generate and print packets
		seqr.portno = 5;

		// Once
		seqr.get_next_item(pkt);
		pkt.print("TB: ");

		// Loop
		for (int i = 0; i < 10; i++) begin
			seqr.get_next_item(pkt);
			pkt.print($sformatf("TB[%0d]: ", i));
		end
	end

endmodule : parent_handle
