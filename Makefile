include MakeSettings.mk
include ProjectInfo.mk
include BuildOptions.mk

TARGET_OS ?= Windows
TARGET_ARCH ?= x64
BUILD_MODE ?= $(RELEASE_MODE)
EXECUTABLE_NAME ?= $(PROJECT_NAME).o
TEST_EXECUTABLE_NAME ?= $(PROJECT_NAME)-test.o

ifeq "$(BUILD_MODE)" "$(DEBUG_MODE)"
DEBUG_FLAGS := -g
endif

TARGET_SYSTEM := $(BUILD_MODE)/$(TARGET_OS)/$(TARGET_ARCH)
DEPENDENCIES := $(LIBS_DIR)/$(TARGET_SYSTEM)

INTERMEDIATE_DIR := $(BUILD_DIR)/$(TARGET_SYSTEM)
OUTPUT_DIR := $(BIN_DIR)/$(TARGET_SYSTEM)

TESTS_FILES := $(shell find $(TESTS_DIR) -name "*.cpp")
SOURCE_FILES := $(shell find $(SOURCE_DIR) -name "*.cpp")
HEADER_FILES := $(shell find $(INCLUDES_DIR) -name "*.hpp")
INTERMEDIATE_FILES := $(patsubst $(SOURCE_DIR)/%.cpp, $(INTERMEDIATE_DIR)/%.o, $(SOURCE_FILES))
TEST_INTERMEDIATE_FILES := $(patsubst $(TESTS_DIR)/%.cpp, $(INTERMEDIATE_DIR)/%.o, $(TESTS_FILES))

EXECUTABLE := $(OUTPUT_DIR)/${EXECUTABLE_NAME}
TEST_EXECUTABLE := $(OUTPUT_DIR)/${TEST_EXECUTABLE_NAME}

.PHONY = build compile run test clean setup help

## all : Generates executable
all: $(EXECUTABLE) $(TEST_EXECUTABLE)

## build : Generates executable
build: $(EXECUTABLE)

## compile : Compiles and generates intermediate files.
compile: $(INTERMEDIATE_FILES)

## setup: Installs dependencies.
setup:
	@$(MKDIR) $(BUILD_DIR)
	@$(CD) $(BUILD_DIR) && conan install .. --build=missing

$(EXECUTABLE): $(INTERMEDIATE_FILES)
	@$(ECHO_NO_NEW_LINE) "$(BLUE)[$(TARGET_OS) $(TARGET_ARCH)] Linking...\t"
	@$(MKDIR) $(OUTPUT_DIR)
	@$(CC) $(CFLAGS) $(CCFLAGS) $(DEBUG_FLAGS) $^ -o $@ -L$(DEPENDENCIES) $(LINK_PARAMS)
	@$(ECHO_SUCCESS)

$(TEST_EXECUTABLE): $(TEST_INTERMEDIATE_FILES) $(filter-out %main.o, $(INTERMEDIATE_FILES))
	@$(ECHO_NO_NEW_LINE) "$(BLUE)[$(TARGET_OS) $(TARGET_ARCH)] Linking...\t"
	@$(MKDIR) $(OUTPUT_DIR)
	@$(CC) $(CFLAGS) $(CCFLAGS) $(DEBUG_FLAGS) $^ -o $@ -L$(DEPENDENCIES) $(LINK_PARAMS)
	@$(ECHO_SUCCESS)

$(INTERMEDIATE_DIR)/%.o: $(SOURCE_DIR)/%.cpp $(INCLUDES_DIR)/%.hpp
	@$(MKDIR) $(@D)
	@$(ECHO_NO_NEW_LINE) "$(BLUE)[$(TARGET_OS) $(TARGET_ARCH)] Compiling $<...\t"
	@$(CC) $(CFLAGS) $(CCFLAGS) $(DEBUG_FLAGS) -c $< -I $(INCLUDES_DIR) $(ADDITIONAL_INCLUDES) -o $@
	@$(ECHO_SUCCESS)

$(INTERMEDIATE_DIR)/%.o: $(TESTS_DIR)/%.cpp
	@$(MKDIR) $(@D)
	@$(ECHO_NO_NEW_LINE) "$(BLUE)[$(TARGET_OS) $(TARGET_ARCH)] Compiling tests $<...\t"
	@$(CC) $(CFLAGS) $(CCFLAGS) $(DEBUG_FLAGS) -c $< -I $(INCLUDES_DIR) $(ADDITIONAL_INCLUDES) -o $@
	@$(ECHO_SUCCESS)

$(INCLUDES_DIR)/%.hpp: ;

## run : Run the executable file.
run: $(EXECUTABLE)
	@$(ECHO) "$(YELLOW)Starting $<...$(DEFAULT_COLOR)"
	@$(CD) $(OUTPUT_DIR) && ./$(EXECUTABLE_NAME)

## test : Runs the unit tests.
test: $(TEST_EXECUTABLE)
	@$(ECHO) "$(YELLOW)Running tests...$(DEFAULT_COLOR)"
	@$(CD) $(OUTPUT_DIR) && ./$(TEST_EXECUTABLE_NAME)

## clean : Clean build artifacts.
clean:
	@$(ECHO_NO_NEW_LINE) "$(RED)Cleaning...\t"
	@$(RM) -rf $(BUILD_DIR)
	@$(RM) -rf $(BIN_DIR)
	@$(ECHO_SUCCESS)

## help : Prints help text.
help: Makefile
	@echo "make [COMMAND]"
	@echo "COMMAND"
	@sed -n 's/^##//p' $<
