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
GIT_COMMIT_DATE := $(shell git show -s --format=%cd --date=format:'%Y%m%d_%H%M' HEAD)
# 示例目标
run:
	@echo "Current Branch: $(GIT_BRANCH)"
	@echo "Commit ID     : $(GIT_COMMIT)"
	@echo "$(GIT_COMMIT_DATE)"


GIT_HOUR := $(shell git log -1 --format=%cd --date=format-local:%H)
check_git_date:
	@echo "Checking date consistency..."

	$(eval SYS_DATE := $(shell date +%F))#获取最新 git commit 日期（只取年月日）
	$(eval GIT_DATE := $(shell git log -1 --format=%cd --date=short))# 获取最新 git commit 日期（只取年月日）
	
	@echo "System date: $(SYS_DATE)"
	@echo "Last git commit date: $(GIT_DATE)"
	@echo "Git hour is $(GIT_HOUR)"

	@echo CHECKING CURRENT DATE AND GIT DATE...
	@if [ "$(SYS_DATE)" != "$(GIT_DATE)" ]; then \
		echo "❌ Date mismatch! Your latest commit is not from today."; \
		echo "   -> Make sure to commit the latest changes before build."; \
		exit 1; \
	else \
		echo "✅ Date match. Proceeding..."; \
	fi

PROJECT_DIR := ~/IC

FoolProof:
	@cd $(PROJECT_DIR) && \
	GIT_DATE=$$(git log -1 --date=short --format=%cd) && \
	CUR_DATE=$$(date +%F) && \
	if [ "$$GIT_DATE" = "$$CUR_DATE" ]; then \
		echo "✅ Git 日期和系统日期一致: $$GIT_DATE"; \
	else \
		echo "❌ Git 最新提交日期 $$GIT_DATE 和当前系统日期 $$CUR_DATE 不一致，请检查是否 commit 最新更改！"; \
		exit 1; \
	fi

FULL_TIME=2025-06-05 14:02:51
# 分割字符串（按空格分隔）
DATE_PART := $(word 1,$(subst :, ,$(FULL_TIME)))  # 2025-06-05
TIME_PART := $(word 2,$(subst :, ,$(FULL_TIME)))  # 14 02 51

show_parts:
	@echo "日期部分: $(DATE_PART)"
	@echo "时间部分: $(TIME_PART)"