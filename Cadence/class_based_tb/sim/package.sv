package package_like_uvm;

    class packet #(int DATA_WIDTH = 8);
        rand bit [3:0] source, target;
        rand bit [DATA_WIDTH-1:0] data;
        string         inst;
        int			   pkt_num;
    
        function new(input string name, int num = 0);
            source  = 0;
            target  = 0;
            data    = 8'h00;
            inst    = name;
            pkt_num = num;
        endfunction
    
        function void print();
            $display("@%0t pS Packet - Source: %0h, Target: %0h, Data: 0x%0h", $time, source, target, data);
        endfunction
    
        function bit compare(packet p);
            return (p.source == source && p.target == target && p.data == data);
        endfunction
    endclass

    class psingle extends packet;
        function new(input string name = "psingle");
            super.new(name);
        endfunction
    endclass

    class pmulticast extends packet;
        function new(input string name = "pmulticast");
            super.new(name);
        endfunction
    endclass

    virtual class base;

        string inst;
        base   parent;

        function new(input string name, base up);
            inst   = name;
            parent = up;
        endfunction

        function string pathname();
            base ptr = this;
            pathname = inst;
            while (ptr.parent != null) begin
                ptr = ptr.parent;
                pathname = {ptr.inst, ".", pathname};
            end
        endfunction : pathname

    endclass : base

    typedef enum {sgle, mult, rnd} seqr_ctrl_e;

    class sequencer extends base;

        int         ok;
        int         portno;
        psingle     sone;
        pmulticast  mone;
        seqr_ctrl_e seqr_ctrl;


        function new(input string name, base up);
            super.new(name, up);
        endfunction

        function void get_next_item(output packet pkt);
        case (seqr_ctrl)
            sgle: begin
                sone = new("sone");
                sone.source = portno;
                ok = sone.randomize();
                if (!ok) 
                    $fatal(1, "Failed to randomize psingle");
                pkt = sone;
            end
            mult: begin
                mone = new();
                mone.source = portno;
                ok = mone.randomize();
                if (!ok) 
                    $fatal(1, "Failed to randomize pmulticast");
                pkt = mone;
            end
            rnd: begin
                if ($urandom_range(0, 1) == 0) 
                    seqr_ctrl = sgle;
                else 
                    seqr_ctrl = mult;
                get_next_item(pkt);  // Recursive call with now-resolved policy  
            end
        endcase
        endfunction : get_next_item

        function void print();
            $display("@ %s", this.pathname());
        endfunction : print

    endclass : sequencer

    
    class driver extends base;

        virtual pds_if pif;
        packet         pkt;
        sequencer      sref;

        function new(input string name, base up);
            super.new(name, up);
        endfunction

        task run(int count);
            repeat (count) begin
                sref.get_next_item(pkt);  // Get a packet from the sequencer
                send_to_dut(pkt);  // Drive it to the DUT
            end
        endtask : run

        task send_to_dut(input packet pkt);
            pif.drive_packet(pkt);  // Call the interface task
            pkt.print();
        endtask : send_to_dut

        function void print();
            $display("@ %s", this.pathname());
        endfunction : print

    endclass : driver
    

    class monitor extends base;

        virtual pds_if pif;
        int            portno;

        function new(input string name, base up);
            super.new(name, up);
        endfunction

        task run();
            checkport();
        endtask : run

        task checkport();
            pif.monitor(portno);
        endtask : checkport

    endclass : monitor

    class pds_vc extends base;
    
        sequencer seqr;
        driver    drv;
        monitor   mon;
    
        function new(input string name, base up);
            super.new(name, up);
            seqr = new("seqr", this);
            drv = new("drv ", this);
            mon = new("mon ", this);
            drv.sref = seqr;
        endfunction
    
        function void setpolicy(seqr_ctrl_e sc);
            seqr.seqr_ctrl = sc;
            $display("[setpolicy] %s: Policy set to %s", this.inst, sc.name());
        endfunction : setpolicy
    
        task run(int count);
            drv.run(count);
        endtask : run
    
        task configure(virtual pds_if ppif, int portno);
            drv.pif     = ppif;
            mon.pif     = ppif;
            mon.portno  = portno;
            seqr.portno = portno;
        endtask : configure
    
    endclass : pds_vc
endpackage : package_like_uvm
