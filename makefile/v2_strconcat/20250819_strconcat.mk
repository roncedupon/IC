#!/usr/bin/make -f

# 定义拼接函数：将两个参数用xxxx连接
concat_with_xxxx = $(1)xxxx$(2)

# 测试用例
TEST1_A = Hello
TEST1_B = World
RESULT1 = $(call concat_with_xxxx,$(TEST1_A),$(TEST1_B))

TEST2_A = Foo
TEST2_B = Bar
RESULT2 = $(call concat_with_xxxx,$(TEST2_A),$(TEST2_B))
#要注意这里有一个call的关键字！！！！！！！！！！！！！！！！！！
# 显示结果
all:
	@echo "测试1: $(RESULT1)"
	@echo "测试2: $(RESULT2)"

# 清理目标（可选）
clean:
	@echo "清理完成"
