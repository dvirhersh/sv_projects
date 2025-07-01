import class_package::*;

module parent_handle;

	pds_vc pds1 = new("pds1", null);  // topmost instance has no parent
	base   ptr;

	initial begin
		ptr = pds1.seqr;

		$display("Current instance: %0s", ptr.get_name());
		ptr = ptr.get_parent();

		if (ptr != null) 
			$display("Parent instance: %0s", ptr.get_name());
		else 
			$display("Reached top-level (no parent)");
	end

endmodule : parent_handle
