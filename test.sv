
class uvm_typed_callbacks#(type T=int);


  static string m_typename;

  typedef uvm_typed_callbacks#(T) this_type;
  typedef uvm_callbacks_base      super_type;

  //The actual global object from the derivative class. Note that this is
  //just a reference to the object that is generated in the derived class.
  static this_type m_t_inst;

  static function this_type m_initialize();

    return m_t_inst;
  endfunction

  //Type checking interface: is given ~obj~ of type T?
  virtual function bit m_am_i_a(int obj);
    T this_type;
    if (obj == null)
      return 1;
    return($cast(this_type,obj));
  endfunction
endclass