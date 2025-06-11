`timescale 1ns / 1ps

module mux_tb;

    logic IN1, IN2, IN3, IN4;
    logic [1:0] SELECTOR;
    logic RES;

    mux uut (
    .IN1(IN1), .IN2(IN2), .IN3(IN3), .IN4(IN4),
    .SELECTOR(SELECTOR), .RES(RES)
    );

    task apply_test(input logic [3:0] inputs, input logic [1:0] sel, input logic expected);
        begin
            IN1 = inputs[0];
            IN2 = inputs[1];
            IN3 = inputs[2];
            IN4 = inputs[3];
            SELECTOR = sel;
            #5;
            $display("Fixed: SEL=%b | IN={%b,%b,%b,%b} => RES=%b (expected %b)",
                    sel, inputs[3], inputs[2], inputs[1], inputs[0], RES, expected);
            assert (RES === expected) else $error("Test failed at SEL=%b", sel);
        end
    endtask

    // Task for randomized test
    task random_test();
        logic [3:0] inputs;
        logic [1:0] sel;
        logic expected;
        begin
            inputs = $random;
            sel = $urandom_range(0, 3);
            expected = inputs[sel];

            IN1 = inputs[0];
            IN2 = inputs[1];
            IN3 = inputs[2];
            IN4 = inputs[3];
            SELECTOR = sel;
            #5;
            $display("Random: SEL=%b | IN={%b,%b,%b,%b} => RES=%b (expected %b)",
                    sel, inputs[3], inputs[2], inputs[1], inputs[0], RES, expected);
            assert (RES === expected) else $error("Random test failed at SEL=%b", sel);
        end
    endtask

    // Initial block
    initial begin
        $display("Starting self-contained mux_tb test...");

        // Fixed test cases
        apply_test(4'b0001, 2'b00, 1);
        apply_test(4'b0010, 2'b01, 1);
        apply_test(4'b0100, 2'b10, 1);
        apply_test(4'b1000, 2'b11, 1);
        apply_test(4'b0000, 2'b00, 0);
        apply_test(4'b1111, 2'b10, 1);

        // Randomized test cases
        for (int i = 0; i < 5; i++) begin
            random_test();
        end

        $display("All tests completed.");
        $finish;
    end

endmodule
