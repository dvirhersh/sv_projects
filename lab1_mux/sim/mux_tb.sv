`timescale 1ns / 1ps

module mux_tb;

    // Inputs
    logic IN1, IN2, IN3, IN4;
    logic [1:0] SELECTOR;

    // Output
    logic RES;

    // Instantiate the DUT
    mux uut (
        .IN1(IN1),
        .IN2(IN2),
        .IN3(IN3),
        .IN4(IN4),
        .SELECTOR(SELECTOR),
        .RES(RES)
    );

    // Task to apply test stimulus
    task apply_test(input logic [3:0] inputs, input logic [1:0] sel, input logic expected);
        begin
            IN1 = inputs[0];
            IN2 = inputs[1];
            IN3 = inputs[2];
            IN4 = inputs[3];
            SELECTOR = sel;
            #5; // wait for propagation
            $display("SEL=%b | IN={%b,%b,%b,%b} => RES=%b (expected %b)", sel, IN4, IN3, IN2, IN1, 
                     RES, expected);
            assert (RES === expected) else $error("Test failed for SELECTOR=%b", sel);
        end
    endtask

    initial begin
        $display("Starting mux test...");

        apply_test(4'b0001, 2'b00, 1);  // IN1 selected
        apply_test(4'b0010, 2'b01, 1);  // IN2 selected
        apply_test(4'b0100, 2'b10, 1);  // IN3 selected
        apply_test(4'b1000, 2'b11, 1);  // IN4 selected
        apply_test(4'b0000, 2'b00, 0);  // IN1 = 0
        apply_test(4'b1111, 2'b10, 1);  // IN3 = 1
        apply_test(4'b0000, 2'b01, 1);  // IN2 = 0

        $display("All tests passed.");
        $finish;
    end
    
endmodule 