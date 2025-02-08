class MyClass;
    // No explicit new function
    int value;

    // Other methods and members
    function void display();
        $display("Value: %0d", value);
    endfunction
endclass

module test;
    initial begin
        // Create an instance of MyClass
        MyClass obj = new();

        // Set the value and display it
        obj.value = 10;
        obj.display();
    end
endmodule
