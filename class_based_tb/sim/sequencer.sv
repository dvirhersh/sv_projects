class sequencer extends base;

  int        ok;
  int        portno;
  psingle    single;
  pmulticast multi;

  function new(input string name, base up);
    super.new(name, up);
  endfunction

  function void get_next_item(output packet pkt);
    randcase
      1: begin
        single = new();
        single.source = portno;
        ok = single.randomize();
        if (!ok) $fatal("Failed to randomize psingle");
        pkt = single;
      end
      2: begin
        multi = new();
        multi.source = portno;
        ok = multi.randomize();
        if (!ok) $fatal("Failed to randomize pmulticast");
        pkt = multi;
      end
    endcase
  endfunction : get_next_item

  function void print();
    $display("@ %s", this.pathname());
  endfunction : print

endclass : sequencer
