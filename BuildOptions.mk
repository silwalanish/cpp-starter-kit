-include build/conanbuildinfo.mak

TARGET_OS ?= Linux
TARGET_ARCH ?= x86
BUILD_MODE ?= Debug
EXECUTABLE_NAME ?= $(PROJECT_NAME).o

# Add custom include paths
ADDITIONAL_INCLUDES = $(addprefix -I, $(CONAN_INCLUDE_DIRS))

# SET CCFLAGS and CFLAGS for more params for compiler
CFLAGS += $(CONAN_CFLAGS)
CCFLAGS += $(CONAN_CXXFLAGS)
CCFLAGS += $(addprefix -D, $(CONAN_DEFINES))

# SET LINK_PARAMS for more params for linker
LINK_PARAMS += $(addprefix -L, $(CONAN_LIB_DIRS))
LINK_PARAMS += $(addprefix -l, $(CONAN_LIBS))
