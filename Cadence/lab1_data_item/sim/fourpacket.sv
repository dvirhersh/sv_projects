`include "packet.sv"

class fourpacket;
    packet p[3:0];

    function new();
        foreach (p[i]) p[i] = new();
    endfunction

    function void deep_print();
        $display("---- FourPacket Dump ----");
        foreach (p[i]) begin
            $write("p[%0d] -> ", i);
            p[i].print();
        end
    endfunction
endclass
