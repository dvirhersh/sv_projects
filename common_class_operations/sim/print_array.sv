import class_operations::*;

module PrintArray;

    Basic basic_class = new();
    Child child_class = new();

    initial begin
        $display("Polymorphism and Encapsulation");

        $display("basic_class makepq:");
        basic_class.b1 = 8'hAB;
        basic_class.makepq();
        $display(basic_class.printaa["b1"]);

        $display("child_class makepq:");
        child_class.b1 = 16'd258;
        child_class.makepq();
        $display(child_class.printaa["b1"]);

        basic_class = child_class;  // Polymorphic assignment

        $display("basic_class = child_class makepq:");
        basic_class.makepq();
        $display(basic_class.printaa["b1"]);
    end
endmodule
