#define SRAM1_BASE_ADDR 0x100000
const uint32_t CPU0_CPU1_SHARE_CFG_DEFAULT_VALUE_ADDR=SRAM1_BASE_ADDR;
uint32_t*CPU0_CPU1_SHARE_CFG=(uint32_t*)CPU0_CPU1_SHARE_CFG_DEFAULT_VALUE_ADDR;//[0:0] IDLE

//common func
uint32_t is_cpu0_idle(){
  print_info("check cpu 0 idle:%x",*CPU0_CPU1_SHARE_CFG);
  return !((*CPU0_CPU1_SHARE_CFG) & CPU0_IDLE_MASK);
}
uint32_t is_cpu1_idle(){
  print_info("check cpu 1 idle:%x",*CPU0_CPU1_SHARE_CFG);
  return !((*CPU0_CPU1_SHARE_CFG) & CPU1_IDLE_MASK);
}
void set_cpu0_idle(){
  (*CPU0_CPU1_SHARE_CFG)&=~CPU0_IDLE_MASK;
  print_info("set_cpu0_idle:%x",*CPU0_CPU1_SHARE_CFG);
}
void set_cpu1_idle(){
  (*CPU0_CPU1_SHARE_CFG)&=~CPU1_IDLE_MASK;
  print_info("set_cpu1_idle:%x",*CPU0_CPU1_SHARE_CFG);
}
void set_cpu0_busy(){
  (*CPU0_CPU1_SHARE_CFG)|=CPU0_IDLE_MASK;
  print_info("set_cpu0_busy:%x",*CPU0_CPU1_SHARE_CFG);
}
void set_cpu1_busy(){
  (*CPU0_CPU1_SHARE_CFG)|=CPU1_IDLE_MASK;
  print_info("set_cpu1_busy:%x",*CPU0_CPU1_SHARE_CFG);
}
void wait_cpu0_idle(){
    while(!is_cpu0_idle()){
          print_info("waiting for cpu0 idle...");
          delay_us(1);
    }  
}
void wait_cpu1_idle(){
    while(!is_cpu1_idle()){
          print_info("waiting for cpu1 idle...");
          delay_us(1);
    }  
}

void dualcpu_func(int cpu_id){
    if (cpu_id==0){
        wait_cpu1_idle();
        set_cpu0_busy();
        //cpu0操作逻辑
        set_cpu0_idle();
    }else{
        wait_cpu0_idle();
        set_cpu1_busy();
        //cpu1操作逻辑
        set_cpu1_idle();        
    }

}
int main(){
    dualcpu_func();
}