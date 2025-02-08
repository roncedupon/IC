  
  class DerivedClass extends BaseClass;
    int moreData;
  
    function void display();
      $display("DerivedClass: data = %0d, moreData = %0d", data, moreData);
    endfunction
  endclass