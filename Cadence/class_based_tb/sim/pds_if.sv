interface pds_if (input logic clk, input logic reset);
	logic [15:0] data_ip;
	logic [15:0] data_op;
	logic        valid_up;
	logic        valid_op;

	task drive_packet(input packet pkt);
		@(negedge clk);
		data_ip  = {pkt.source, pkt.target, pkt.data};
		valid_up = 1;
		valid_op = 0;
		@(negedge clk);
		valid_up = 0;
		valid_op = 1;
	endtask : drive_packet

	task monitor(bit[3:0] portno);
		packet pkt0;
		forever begin
			@(posedge valid_op) 
				pkt0 = new("pkt", 0);
			{pkt0.source, pkt0.target, pkt0.data} = data_op;
		end
		
	endtask : monitor

	// modport dut(input data_ip, valid_up, clk, reset);
	// modport drv(output data_ip, valid_up, input clk, reset);
endinterface
