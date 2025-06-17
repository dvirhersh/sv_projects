typedef enum {sgle, mult, rnd} 
    seqr_ctrl_e;

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
        sgle :begin
            sone = new("sone");
            sone.source = portno;
            ok = sone.randomize();
            if (!ok) 
                $fatal(1, "Failed to randomize psingle");
            pkt = sone;
        end
        mult :begin
            mone = new();
            mone.source = portno;
            ok = mone.randomize();
            if (!ok) 
                $fatal(1, "Failed to randomize pmulticast");
            pkt = mone;
        end
        rnd :begin
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
