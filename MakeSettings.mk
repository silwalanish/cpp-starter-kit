CC := g++
RM := rm
CD := cd
GIT := git
MKDIR := mkdir -p
SHELL := /bin/bash

TICK := \u2714
DEFAULT_COLOR := \033[0m
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m

ECHO := echo -e
ECHO_NO_NEW_LINE := $(ECHO) -n
ECHO_SUCCESS := $(ECHO) "$(GREEN)$(TICK)$(DEFAULT_COLOR)"

DEBUG_MODE := Debug
RELEASE_MODE := Release
