interface pds_if (input bit clk, reset);
	logic [15:0] data_ip;
	logic        valid_up;

	task drive_packet(input packet pkt);
		@(negedge clk);
		data_ip  = {pkt.source, pkt.target, pkt.data};
		valid_up = 1;
		@(negedge clk);
		valid_up = 0;
	endtask : drive_packet

	// modport dut(input data_ip, valid_up, clk, reset);
	// modport drv(output data_ip, valid_up, input clk, reset);
endinterface
