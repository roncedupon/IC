//对run_test进行解析

task uvm_root::run_test(string test_name="");

  uvm_factory factory= uvm_factory::get();
  //static function uvm_factory get()--Get the factory singleton
  //获取factory的单例对象

  bit testname_plusarg;//看后面的赋值，如果有test_name，那么就为1
                        //实际上是一个标志位，用来标记是否从命令行参数（也称为“plusargs”）中成功获取了测试名称（test name）

  int test_name_count;//可以看后面的赋值操作，有时候会运行多个test
  string test_names[$];//存储多个test
  string msg;//如果uvm_test_top=null则输出一个报错信息，
  uvm_component uvm_test_top;

  process phase_runner_proc; // store thread forked below for final cleanup
                            //用于将下面被forked的phase线程存起来并且执行最后的清理操作
  testname_plusarg = 0;

  // Set up the process that decouples the thread that drops objections from
  // the process that processes drop/all_dropped objections. Thus, if the
  // original calling thread (the "dropper") gets killed, it does not affect
  // drain-time and propagation of the drop up the hierarchy.
  // Needs to be done in run_test since it needs to be in an
  // initial block to fork a process.
  uvm_objection::m_init_objections();

`ifndef UVM_NO_DPI

  // Retrieve the test names provided on the command line.  Command line
  // overrides the argument.
  test_name_count = clp.get_arg_values("+UVM_TESTNAME=", test_names);//clp的类型是uvm_cmdline_processor
                                                                    //这里用于从命令行获取全部的test name，看看手册里关于get_arg_values使用就很好理解了

  // If at least one, use first in queue.
  if (test_name_count > 0) begin
    test_name = test_names[0];//获取第一个test name
    testname_plusarg = 1;//并且设置标志位为1
  end

  // If multiple, provided the warning giving the number, which one will be
  // used and the complete list.
  if (test_name_count > 1) begin//如果test不止一个，那么把所有test都存起来
    string test_list;
    string sep;
    for (int i = 0; i < test_names.size(); i++) begin
      if (i != 0)
        sep = ", ";
      test_list = {test_list, sep, test_names[i]};
    end
    uvm_report_warning("MULTTST", 
      $sformatf("Multiple (%0d) +UVM_TESTNAME arguments provided on the command line.  '%s' will be used.  Provided list: %s.", test_name_count, test_name, test_list), UVM_NONE);
  end

`else

     // plusarg overrides argument
  if ($value$plusargs("UVM_TESTNAME=%s", test_name)) begin//这里有个问题，不用dpi的话，就只能有一个test嘛？
    `uvm_info("NO_DPI_TSTNAME", "UVM_NO_DPI defined--getting UVM_TESTNAME directly, without DPI", UVM_NONE)
    testname_plusarg = 1;
  end

`endif

  // if test now defined, create it using common factory
  if (test_name != "") begin
    if(m_children.exists("uvm_test_top")) begin
      uvm_report_fatal("TTINST",
          "An uvm_test_top already exists via a previous call to run_test", UVM_NONE);
      #0; // forces shutdown because $finish is forked
    end
    $cast(uvm_test_top, factory.create_component_by_name(test_name,
          "", "uvm_test_top", null));

    if (uvm_test_top == null) begin
      msg = testname_plusarg ? {"command line +UVM_TESTNAME=",test_name} : 
                               {"call to run_test(",test_name,")"};
      uvm_report_fatal("INVTST",
          {"Requested test from ",msg, " not found." }, UVM_NONE);
    end
  end

  if (m_children.num() == 0) begin
    uvm_report_fatal("NOCOMP",
          {"No components instantiated. You must either instantiate",
           " at least one component before calling run_test or use",
           " run_test to do so. To run a test using run_test,",
           " use +UVM_TESTNAME or supply the test name in",
           " the argument to run_test(). Exiting simulation."}, UVM_NONE);
    return;
  end

  uvm_report_info("RNTST", {"Running test ",test_name, "..."}, UVM_LOW);

  // phase runner, isolated from calling process
  fork begin
    // spawn the phase runner task
    phase_runner_proc = process::self();//获取当前进程的句柄
    uvm_phase::m_run_phases();
  end
  join_none
  #0; // let the phase runner start
  
  wait (m_phase_all_done == 1);//是一个成员变量，由uvm_phase控制-->源码里搜索m_phase_all_done
  
  // clean up after ourselves
  phase_runner_proc.kill();

  report_summarize();

  if (finish_on_completion)
    $finish;

endtask