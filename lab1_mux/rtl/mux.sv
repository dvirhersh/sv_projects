module mux (
    input logic IN1,
    input logic IN2,
    input logic IN3,
    input logic IN4,
    input logic [1:0] SELECTOR,
    output logic RES
);

    always_comb begin : mux_block
        case (SELECTOR)
            2'b00:   RES = IN1; 
            2'b01:   RES = IN2; 
            2'b10:   RES = IN3; 
            2'b11:   RES = IN4; 
            default: RES = 1'b0;
        endcase        
    end
    
endmodule
