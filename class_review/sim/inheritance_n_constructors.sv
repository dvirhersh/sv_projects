`timescale 1ns / 1ps

class Person;
    int age;

    function new(input int init_age);
        age = init_age;
    endfunction
endclass

class Student extends Person;
    int student_id;

    function new(input int init_age, input int id);
        super.new(init_age);
        student_id = id;
    endfunction

    function void print_info();
        $display("Student -> Age = %0d, ID = %0d", age, student_id);
    endfunction
endclass

module InheritAndConstructor;
    Student student1;

    initial begin
        student1 = new(.init_age(21), .id(1002));
        if (student1 != null) begin
            student1.age = 22;  // updating age after creation
            student1.print_info();
        end else begin
            $display("Error: Failed to create Student object.");
        end
    end
endmodule
