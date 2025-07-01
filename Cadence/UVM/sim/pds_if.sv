interface pds_if (
    input logic clk,
    input logic reset
);
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
    endtask

    modport dut(input clk, reset, input data_ip, valid_up, output data_op, valid_op);

endinterface
