
# 文件说明
## 25/06/17

#### 新增
- physics_map.bin: 烧录所需map文件，需要拆分后backdoor；
- debug_map.json: 烧录map中的部分信息，供debug参考；
- map_split.txt: 由烧录流程决定的 physics_map.bin 拆分方案，其中保存内容为 TransReq 结构体的三个关键参数，保存格式：[blockAddr, pingpongID, bytes]，每个数组都需要拆分成一个文件；
- logical_map_4096.bin: 烧录map对应的逻辑map，后门验证可参考；

---