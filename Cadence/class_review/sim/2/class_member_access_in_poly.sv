import p1::*;

module ClassMemberAccessInPoly;

	Basic  b1 /*= new()*/;
	Parent p1 = new();
	Child  c1 = new();

	initial begin
		b1 = p1;
		b1.iam();

		p1 = c1;
		p1.iam();
	end

endmodule : ClassMemberAccessInPoly



