TARGET_OS ?= Linux
TARGET_ARCH ?= x86
BUILD_MODE ?= Debug
EXECUTABLE_NAME ?= $(PROJECT_NAME).o

# Add custom include paths
ADDITIONAL_INCLUDES = -I$(VENDOR_DIR)/glm

# SET CCFLAGS and CFLAGS for more params for compiler
# CCFLAGS=
# CFLAGS=

# SET LINK_PARAMS for more params for linker
# LINK_PARAMS=
