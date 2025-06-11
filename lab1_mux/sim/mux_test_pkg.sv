package mux_test_pkg;

  class MuxTest;
    rand bit [3:0] inputs;
    rand bit [1:0] selector;
    bit expected;

    // Constructor with optional positional arguments
    function new(bit [3:0] i = 4'b0000, bit [1:0] s = 2'b00);
      inputs = i;
      selector = s;
      expected = i[s];
    endfunction

    // Run test with current inputs/selector
    task run(ref logic IN1, IN2, IN3, IN4, [1:0] SELECTOR, logic RES);
      IN1 = inputs[0];
      IN2 = inputs[1];
      IN3 = inputs[2];
      IN4 = inputs[3];
      SELECTOR = selector;
      #5;
      $display("SEL=%b | IN={%b,%b,%b,%b} => RES=%b (expected %b)",
                selector, inputs[3], inputs[2], inputs[1], inputs[0], RES, expected);
      assert (RES === expected) else $error("Mismatch at selector %b", selector);
    endtask

    // Randomize and run
    task randomize_and_run(ref logic IN1, IN2, IN3, IN4, [1:0] SELECTOR, logic RES);
      if (!randomize()) $fatal("Randomization failed!");
      expected = inputs[selector];
      run(IN1, IN2, IN3, IN4, SELECTOR, RES);
    endtask

  endclass

endpackage
