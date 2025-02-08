module test;
  import uvm_pkg::*;

  uvm_event_pool ep=new("ep");

  initial begin
    uvm_event e;
    e = ep.get("fred");
    e = ep.get("george");
    uvm_default_table_printer.knobs.reference = 0;
    ep.print();

    begin
      uvm_report_server svr;
      svr = _global_reporter.get_report_server();

      svr.summarize();

      if (svr.get_severity_count(UVM_FATAL) +
          svr.get_severity_count(UVM_ERROR) == 0)
         $write("** UVM TEST PASSED **\n");
      else
         $write("!! UVM TEST FAILED !!\n");
   end

  end
endmodule