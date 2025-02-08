#define L0_WIDTH 3352
#define L0_HEIGHT 3328
#define L0_BIAS_HEIGHT 31
#define L0_WIDTH_WITH_TEMP_COMP (L0_WIDTH + 8 + 32)
#define L0_WIDTH_WITH_TEMP_COMP_ALIGN (L0_WIDTH_WITH_TEMP_COMP + 64) //3456
#define L0_TIA_GROSS_WIDTH 3408
#define L0_HEIGHT_WITH_REDUNDANCE 3332
#define SRAM_COMP_SHIFT_BASE_ADDR                     0x0000
#define SRAM_COMP_SCALE_BASE_ADDR                     0xD800
#define SRAM_COMP_BIAS_BASE_ADDR                      0x1B000
RetCode Simulator::ExpandToAlign(const uint64_t* data, std::size_t data_len, std::vector<uint64_t>& expansion) {
  auto aligned_byte_len = alignTo(data_len, INSTRUCTION_BYTE_LEN);
  expansion.resize(aligned_byte_len / sizeof(uint64_t));   // after 1024

  if (! memcpy(expansion.data(), data, data_len)) {
      return RetCode::UNEXPECTED;
  }
  // replenish the rest with 0
  if (! memset(expansion.data() + data_len / sizeof(uint64_t), 0, aligned_byte_len - data_len)) {
      return RetCode::UNEXPECTED;
  }
  return RetCode::SUCCESS;
}
RetCode Simulator::InitInference(std::size_t flash_die_id, std::size_t L2_id, std::size_t L0_id,
                                uint64_t* tia_data, std::size_t tia_size, uint64_t* comp_data, std::size_t comp_size) {
  if ((!tia_data) or (tia_size == 0) or (!comp_data) or (comp_size == 0)) {
    DLOG(ERROR) << "(!tia_data) or (tia_size == 0) or (!comp_data) or (comp_size == 0)";
    return RetCode::INVALID_INPUT;
  }
  auto tia_bytes = reinterpret_cast<uint8_t*>(tia_data);
  auto verify_l0id = tia_bytes[tia_size - 1] & 0xff;
  bool cellsum = (verify_l0id == L0_id + 1);
  std::vector<uint64_t> aligned_tia_data;
  RETURN_IF_UNSUCCESS(ExpandToAlign(tia_data, tia_size, aligned_tia_data));
  std::vector<uint64_t> aligned_comp_shift;
  std::vector<uint64_t> aligned_comp_scale;
  std::vector<uint64_t> aligned_comp_bias;
  constexpr std::size_t k_comp_shift_size = L0_WIDTH_WITH_TEMP_COMP_ALIGN;
  constexpr std::size_t k_comp_scale_size = L0_WIDTH_WITH_TEMP_COMP_ALIGN;
  constexpr std::size_t k_comp_bias_size = L0_WIDTH_WITH_TEMP_COMP_ALIGN * sizeof(int16_t);
  RETURN_IF_UNSUCCESS(ExpandToAlign(comp_data, k_comp_shift_size, aligned_comp_shift));
  RETURN_IF_UNSUCCESS(ExpandToAlign(comp_data + (k_comp_shift_size) / sizeof(uint64_t), k_comp_scale_size, aligned_comp_scale));
  RETURN_IF_UNSUCCESS(ExpandToAlign(comp_data + (k_comp_shift_size + k_comp_scale_size) / sizeof(uint64_t), k_comp_bias_size, aligned_comp_bias));
  DLOG(DEBUG) << "Aligned Tia size: " << aligned_tia_data.size();
  DLOG(DEBUG) << "Aligned Comp shift size: " << aligned_comp_shift.size();
  DLOG(DEBUG) << "Aligned Comp scale size: " << aligned_comp_scale.size();
  DLOG(DEBUG) << "Aligned Comp bias size: " << aligned_comp_bias.size();

  auto tia_addr = CalcTIAAddr(L0_id, false);  // positive
  auto off_u64 = INSTRUCTION_BYTE_LEN / k_batch_of_u64_len;
  constexpr auto k_beat_u64 = INSTRUCTION_BYTE_LEN / sizeof(uint64_t);
  for (std::size_t i = 0; i < aligned_tia_data.size(); i += k_batch_of_u64_len) {
    IPCoreBufferWrite(tia_addr + off_u64 * i, aligned_tia_data.data() + i, k_batch_of_u64_len, flash_die_id, L2_id);
  }
  tia_addr = CalcTIAAddr(L0_id, true);  // negative
  for (std::size_t i = 0; i < aligned_tia_data.size(); i += k_batch_of_u64_len) {
    IPCoreBufferWrite(tia_addr + off_u64 * i, aligned_tia_data.data() + i, k_batch_of_u64_len, flash_die_id, L2_id);
  }
  auto comp_addr = CalcCompAddr(SRAM_COMP_SHIFT_BASE_ADDR, L0_id, aligned_comp_shift.size() / k_beat_u64);
  DLOG(DEBUG) << "shift addr is 0x"<< std::hex << comp_addr;
  for (std::size_t i = 0; i < aligned_comp_shift.size(); i += k_batch_of_u64_len) {
    IPCoreBufferWrite(comp_addr + off_u64 * i, aligned_comp_shift.data() + i, k_batch_of_u64_len, flash_die_id, L2_id);
  }
  comp_addr = CalcCompAddr(SRAM_COMP_SCALE_BASE_ADDR, L0_id, aligned_comp_scale.size() / k_beat_u64);
  DLOG(DEBUG) << "scale addr is 0x"<< std::hex << comp_addr;
  for (std::size_t i = 0; i < aligned_comp_scale.size(); i += k_batch_of_u64_len) {
    IPCoreBufferWrite(comp_addr + off_u64 * i, aligned_comp_scale.data() + i, k_batch_of_u64_len, flash_die_id, L2_id);
  }
  comp_addr = CalcCompAddr(SRAM_COMP_BIAS_BASE_ADDR, L0_id, aligned_comp_bias.size() / k_beat_u64);
  DLOG(DEBUG) << "bias addr is 0x"<< std::hex << comp_addr;
  for (std::size_t i = 0; i < aligned_comp_bias.size(); i += k_batch_of_u64_len) {
    IPCoreBufferWrite(comp_addr + off_u64 * i, aligned_comp_bias.data() + i, k_batch_of_u64_len, flash_die_id, L2_id);
  }

  if (cellsum) {
    assert(L0_id % 2 == 0 && "L0 id must be an even when cellsum is true");
    auto tia_addr = CalcTIAAddr(L0_id + 1, false);  // positive
    for (std::size_t i = 0; i < aligned_tia_data.size(); i += k_batch_of_u64_len) {
      IPCoreBufferWrite(tia_addr + off_u64 * i, aligned_tia_data.data() + i, k_batch_of_u64_len, flash_die_id, L2_id);
    }
    tia_addr = CalcTIAAddr(L0_id + 1, true);  // negative
    for (std::size_t i = 0; i < aligned_tia_data.size(); i += k_batch_of_u64_len) {
      IPCoreBufferWrite(tia_addr + off_u64 * i, aligned_tia_data.data() + i, k_batch_of_u64_len, flash_die_id, L2_id);
    }
    auto comp_addr = CalcCompAddr(SRAM_COMP_SHIFT_BASE_ADDR, L0_id + 1, aligned_comp_shift.size() / k_beat_u64);
    DLOG(DEBUG) << "shift addr is 0x"<< std::hex << comp_addr;
    for (std::size_t i = 0; i < aligned_comp_shift.size(); i += k_batch_of_u64_len) {
      IPCoreBufferWrite(comp_addr + off_u64 * i, aligned_comp_shift.data() + i, k_batch_of_u64_len, flash_die_id, L2_id);
    }
    comp_addr = CalcCompAddr(SRAM_COMP_SCALE_BASE_ADDR, L0_id + 1, aligned_comp_scale.size() / k_beat_u64);
    DLOG(DEBUG) << "scale addr is 0x"<< std::hex << comp_addr;
    for (std::size_t i = 0; i < aligned_comp_scale.size(); i += k_batch_of_u64_len) {
      IPCoreBufferWrite(comp_addr + off_u64 * i, aligned_comp_scale.data() + i, k_batch_of_u64_len, flash_die_id, L2_id);
    }
    comp_addr = CalcCompAddr(SRAM_COMP_BIAS_BASE_ADDR, L0_id + 1, aligned_comp_bias.size() / k_beat_u64);
    DLOG(DEBUG) << "bias addr is 0x"<< std::hex << comp_addr;
    for (std::size_t i = 0; i < aligned_comp_bias.size(); i += k_batch_of_u64_len) {
      IPCoreBufferWrite(comp_addr + off_u64 * i, aligned_comp_bias.data() + i, k_batch_of_u64_len, flash_die_id, L2_id);
    }
  }
  DLOG(DEBUG) << std::dec;

  return RetCode::SUCCESS;
}