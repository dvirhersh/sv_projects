import p1::*;

module test;

	base b;
	sub  s1 = new(4'd3);
    sub  s2;

	initial begin
		b = s1;

		if (!$cast(s2, b)) begin
			$display("Cast failed");
		end else begin
			$display("Cast succeeded");
			s2.iam();  // Will print "Short Frame"
		end
	end

endmodule
