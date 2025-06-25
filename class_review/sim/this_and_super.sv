`timescale 1ns / 1ps

class Device;
    bit power_on;

    function new(input bit init_power_state);
        power_on = init_power_state;
    endfunction
endclass

class Sensor extends Device;
    bit [1:0] mode;

    function new(input bit init_power_state);
        super.new(init_power_state);
        this.mode = {1'b0, init_power_state};  // For example: extend single-bit to 2-bit mode
    endfunction

    function void print();
        $display("Sensor -> Mode = %0d, Power = %0b", mode, power_on);
    endfunction
endclass

class SmartSensor extends Sensor;
    function new(input bit init_power_state);
        super.new(init_power_state);
    endfunction
endclass

module ThisSuper;
    Device      base_device     = new('b0);
    Sensor      basic_sensor    = new('b1);
    SmartSensor advanced_sensor = new('b0);

    initial begin

        if (basic_sensor != null) 
            basic_sensor.print();
         else 
            $display("Error: Failed to create Sensor object.");
    end
endmodule
