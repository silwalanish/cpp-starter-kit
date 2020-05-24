PROJECT_NAME = projectname
PROJECT_VERSION = 1.0

PROJECT_STRUCTURE = build output deps src deps/include deps/libs
GIT_TRACKED = deps src deps/include deps/libs
# BUILD_PARAMS set this to the extra params passed in linking

SHELL = /bin/bash

SRC_DIR = src
OBJ_DIR = build
OUTPUT_DIR = output

DEPS_DIR = deps
INCLUDE_DIR = $(DEPS_DIR)/include
LIBS_DIR = $(DEPS_DIR)/libs

SRCS := $(shell find $(SRC_DIR) -name "*.cpp")
OBJS := $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(SRCS))

TICK = \u2714
DEFAULT_COLOR = \033[0m
RED = \033[0;31m
GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m

.PHONY = build compile run clean setup

all: $(OUTPUT_DIR)/$(PROJECT_NAME).o

build: $(OUTPUT_DIR)/$(PROJECT_NAME).o

compile: $(OBJS)

$(OUTPUT_DIR)/$(PROJECT_NAME).o: $(OBJS)
	@echo -e -n "$(BLUE)Linking...\t"
	@g++ $^ -o $@ -L$(LIBS_DIR) $(BUILD_PARAMS)
	@echo -e "$(GREEN)$(TICK)$(DEFAULT_COLOR)"

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(@D)
	@echo -e -n "$(BLUE)Compiling $<...\t"
	@g++ -c $< -I $(INCLUDE_DIR)
	@echo -e "$(GREEN)$(TICK)$(DEFAULT_COLOR)"
	@mv $(@F) $(@D)

run: $(OUTPUT_DIR)/$(PROJECT_NAME).o
	@echo -e "$(YELLOW)Starting $^...$(DEFAULT_COLOR)"
	@./$^

clean:
	@echo -e -n "$(RED)Cleaning...\t"
	@rm -rf $(OBJS)
	@echo -e "$(GREEN)$(TICK)$(DEFAULT_COLOR)"

setup:
	@echo -e -n "$(YELLOW)Creating project structure...\t"
	@mkdir -p $(PROJECT_STRUCTURE)
	@echo -e "$(GREEN)$(TICK)$(DEFAULT_COLOR)"
ifeq (, $(shell which git))
	@echo -e "$(RED)Git not installed.$(DEFAULT_COLOR)"
else
	@if [[ ! -d .git ]]; then \
		echo -e "$(GREEN)Initializing Git"; \
		git init; \
		for i in $(GIT_TRACKED); \
		do \
			touch $$i/.gitkeep; \
		done; \
		echo -e -n "$(GREEN)Generating .gitignore file...\t"; \
		echo -e "build/\noutput/" >> .gitignore; \
		echo -e "$(GREEN)$(TICK)$(DEFAULT_COLOR)"; \
	fi
endif
