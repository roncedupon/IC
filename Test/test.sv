function void uvm_factory::set_type_override_by_type (uvm_object_wrapper original_type,
    uvm_object_wrapper override_type,
    bit replace=1);
bit replaced;

// check that old and new are not the same
if (original_type == override_type) begin
if (original_type.get_type_name() == "" || original_type.get_type_name() == "<unknown>")
uvm_report_warning("TYPDUP", {"Original and override type ",
"arguments are identical"}, UVM_NONE);
else
uvm_report_warning("TYPDUP", {"Original and override type ",
"arguments are identical: ",
original_type.get_type_name()}, UVM_NONE);
return;
end
// register the types if not already done so, for the benefit of string-based lookup
if (!m_types.exists(original_type))
register(original_type); 


// check for existing type override
foreach (m_type_overrides[index]) begin
    if (m_type_overrides[index].orig_type == original_type ||
        (m_type_overrides[index].orig_type_name != "<unknown>" &&
        m_type_overrides[index].orig_type_name != "" &&
        m_type_overrides[index].orig_type_name == original_type.get_type_name())) begin
        string msg;
        msg = {"Original object type '",original_type.get_type_name(),
        "' already registered to produce '",
        m_type_overrides[index].ovrd_type_name,"'"};
        if (!replace) begin
            msg = {msg, ".  Set 'replace' argument to replace the existing entry."};
            uvm_report_info("TPREGD", msg, UVM_MEDIUM);
            return;
        end
        msg = {msg, ".  Replacing with override to produce type '",
        override_type.get_type_name(),"'."};
        uvm_report_info("TPREGR", msg, UVM_MEDIUM);
        replaced = 1;
        m_type_overrides[index].orig_type = original_type; 
        m_type_overrides[index].orig_type_name = original_type.get_type_name(); 
        m_type_overrides[index].ovrd_type = override_type; 
        m_type_overrides[index].ovrd_type_name = override_type.get_type_name(); 
    end
end


// make a new entry
if (!replaced) begin
    uvm_factory_override override;
    override = new(.orig_type(original_type),
    .orig_type_name(original_type.get_type_name()),
    .full_inst_path("*"),
    .ovrd_type(override_type));

    m_type_overrides.push_back(override);
end

endfunction


