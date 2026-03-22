# Makefile to set AAA based on SERVER_LOCATION environment variable

# Check if SERVER_LOCATION is set to BJ
ifeq ($(SERVER_LOCATION),BJ)
    AAA := AAAB
else
    # Default value if SERVER_LOCATION is not BJ
    AAA := AAA
endif

# Target to display the value of AAA
show-aaa:
	@echo "AAA = $(AAA)"
	@echo "SERVER_LOCATION = $(SERVER_LOCATION)"

# Phony target
.PHONY: show-aaa
