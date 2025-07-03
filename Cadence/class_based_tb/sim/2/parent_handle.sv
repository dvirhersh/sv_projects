import class_package::*;

module parent_handle;

	testbench tb1  = new("tb1", null);
	base      ptr;

	initial begin

		tb1.pds1.seqr.print();

		ptr = tb1.pds1.seqr;
		$display("1 ptr.inst = %0s", ptr.get_name());
		ptr = ptr.get_parent();
		$display("2 ptr.inst = %0s", ptr.get_name());
		ptr = ptr.get_parent();
		$display("3 ptr.inst = %0s", ptr.get_name());
		ptr = ptr.get_parent();
		if (ptr != null) 
			$display("4 Parent instance: %0s", ptr.get_name());
		else 
			$display("4 Reached top-level (no parent)");
	end
endmodule : parent_handle
