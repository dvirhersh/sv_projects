module dut (
        input logic clk,
        input logic rst_n,

        // Input channel
        input  logic       in_valid,
        output logic       in_ready,
        input  logic [7:0] in_data,

        // Output channel
        output logic       out_valid,
        input  logic       out_ready,
        output logic [7:0] out_data);

    typedef enum logic [1:0] {IDLE, BUSY, DONE} state_t;
    state_t state;

    logic [7:0] buffer;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state     <= IDLE;
            buffer    <= 8'h00;
            out_valid <= 1'b0;
            in_ready  <= 1'b1;
        end else begin
            case (state)
                IDLE: begin
                    if (in_valid && in_ready) begin
                        buffer   <= in_data;
                        in_ready <= 1'b0;
                        state    <= BUSY;
                    end
                    out_valid <= 1'b0;
                end

                BUSY: begin
                    state <= DONE;
                end

                DONE: begin
                    out_valid <= 1'b1;
                    if (out_ready) begin
                        out_valid <= 1'b0;
                        in_ready  <= 1'b1;
                        state     <= IDLE;
                    end
                end
            endcase
        end
    end

    assign out_data = buffer;

endmodule
