`ifndef CFS_APB_SEQUENCE_RANDOM_SV
    `define CFS_APB_SEQUENCE_RANDOM_SV

    class cfs_apb_sequence_random extends cfs_apb_sequence_base;

        rand int unsigned num_items;

        constraint num_items_default {soft num_items inside {[1 : 10]};}

        `uvm_object_utils(cfs_apb_sequence_random)

        function new(string name = "");
            super.new(name);
        endfunction

        virtual task body();
            for (int i = 0; i < num_items; i++) begin
                cfs_apb_sequence_simple seq;
                `uvm_do(seq)
            end
        endtask

        endclass
`endif
