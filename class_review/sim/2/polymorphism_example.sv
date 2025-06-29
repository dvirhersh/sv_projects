`include "include_classes.sv"

module PolymorphismExample;

	RandFrame  frame[7:0];
	ShortFrame sf;
	MediumFrame mf;

	initial begin
		foreach (frame[i]) begin
			randcase
				2: begin
					sf = new(.paddr(2));
					frame[i] = sf;
				end
				1: begin
					mf = new(.paddr(1));
					frame[i] = sf;
				end
			endcase

			// operations on frame
			// Complete frame data
			// Send frame to DUT
		end
	end
endmodule

//=======================

//class Packet;
//  virtual function void print();
//    $display("Packet: base class");
//  endfunction
//endclass

//class DataPacket extends Packet;
//  function void print();
//    $display("DataPacket: derived class");
//  endfunction
//endclass

//module test_polymorphism;
//  Packet p;
//  DataPacket dp;

//  initial begin
//    dp = new();
//    p = dp; // base class handle points to derived class object
//    p.print(); // Output: "DataPacket: derived class"
//    dp.print(); // Output: "DataPacket: derived class"
//  end
//endmodule
