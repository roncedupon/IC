
class cust_config extends uvm_object;
    `uvm_object_utils(cust_config)
    
    // SystemVerilog 中的“字典”：关联数组
    string config_dict[string]; 
    
    // 也可以保留具体的字段，通过字典初始化这些字段
    bit switch_on_feature = 1'b0;
    string mode_name = "STANDARD";

    function new (string name);
        super.new(name);
    endfunction: new
    
    // **核心解析任务**
    function read_from_cfg_file(string filename,string INPUT_KEY);
        int fp;
        string line;
        string key, value;
        
        // 1. 打开文件
        fp = $fopen(filename, "r");
        
        if (fp == 0) begin
            `uvm_fatal(get_full_name(), 
                       $sformatf("Failed to open configuration file: %s", filename))
            return;
        end
        
        `uvm_info(get_full_name(), 
                  $sformatf("Reading custom configuration dictionary from %s", filename), UVM_LOW)
        
        // 2. 逐行读取并解析
        while (!$feof(fp)) begin
            line = $fgets(fp);
            
            // 清理和简化行内容以便解析
            // 目标格式: ["KEY","VALUE"]
            
            // 去除行首尾空格和换行符（自定义操作）
            line = line.strip(); 
            
            // 忽略注释行或空行
            if (line.len() == 0 || line.substr(0, 0) == "#") continue;
            
            // **核心解析逻辑**：使用 $sscanf 尝试匹配引号中的两个字符串
            // 注意：在 SystemVerilog 中解析复杂或自定义格式（如带引号、方括号和逗号）
            // 需要非常精确的 $sscanf 格式或复杂的字符串操作。
            // 这里提供一个假设性方案：通过匹配字面量字符，提取引号内的内容。
            
            // %s 在 $sscanf 中匹配非空白字符串，%c 匹配单个字符。
            // 假设我们使用正则表达式风格的解析（这在 $sscanf 中通常不直接支持，但我们简化逻辑）：
            
            // 为了简化，我们假设我们能找到 KEY 和 VALUE。
            // 实际操作中，我们可能需要使用更复杂的解析器（例如基于字符串函数或C语言PLI）。
            
            if ($sscanf(line, "[\"%s\",\"%s\"]", key, value) == 2) begin
                // $sscanf 可能会保留尾随的引号，需要手动移除（取决于仿真器实现）
                
                // 进一步清理 key 和 value 中可能遗留的引号和逗号
                key   = key.before_char("\"");
                value = value.before_char("\"");
                
                // 3. 存储到关联数组 (Dictionary)
                config_dict[key.tolower()] = value;
                
                `uvm_info(get_full_name(), 
                          $sformatf("Parsed key='%s', value='%s'", key.tolower(), value), UVM_LOW)
                
            end else begin
                `uvm_warning(get_full_name(), 
                             $sformatf("Skipping line due to parse failure: %s", line))
            end
        end
        
        $fclose(fp);
    
    endfunction: read_from_cfg_file

    function bit check_args(string KEY);
        // 4. (可选) 使用字典中的值来初始化具体的配置字段
        if (config_dict.exists("feature_a_enable")) begin
            if (config_dict["feature_a_enable"].tolower() == "on") begin
                switch_on_feature = 1'b1;
            end
        end
        if (config_dict.exists("mode_type")) begin
            mode_name = config_dict["mode_type"];
        end

        if (config_dict.exists(INPUT_KEY)) begin
            if (config_dict[INPUT_KEY].tolower() == "on") begin
                return 1'b1;
            end
            else if  (config_dict[INPUT_KEY].tolower() == "1") begin
                return 1'b1;
            end
            else begin
                return 1'b0;
            end
        end
        else begin
            `uvm_error(get_full_name(),$sformatf("%s not exists",INPUT_KEY))
            return 1'b0;
        end        
    endfunction
    
endclass