CASECTRL=0
COMMON_DEFINE = AAA
ifeq ($(CASECTRL),1)
	COMMON_DEFINE += BBBBB

endif
run:
	echo $(COMMON_DEFINE)
run2:
	echo "AAAAAAAAA"

# 获取当前 Git 分支名
GIT_REF := $(shell git describe --tags --exact-match 2>/dev/null || git rev-parse --abbrev-ref HEAD)

# 获取当前 commit ID 的前 8 位
GIT_COMMIT := $(shell git rev-parse --short=8 HEAD)

# 示例目标
print_git_info:
	@echo "Current Branch: $(GIT_BRANCH)"
	@echo "Commit ID     : $(GIT_COMMIT)"
