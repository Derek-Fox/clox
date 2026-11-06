CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -g -Wno-unused-parameter

SRC_DIR = ./src
BUILD_DIR = ./build
TARGET = clox

# Profiling build (gprof): `make profile` produces ./clox-profile
PROFILE_BUILD_DIR = ./build-profile
PROFILE_TARGET = clox-profile
PROFILE_CFLAGS = $(CFLAGS) -pg -O2

SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
PROFILE_OBJS = $(SRCS:$(SRC_DIR)/%.c=$(PROFILE_BUILD_DIR)/%.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@

$(PROFILE_BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(PROFILE_CFLAGS) -c $< -o $@

$(PROFILE_TARGET): $(PROFILE_OBJS)
	$(CC) $(PROFILE_CFLAGS) -o $@ $^

profile: $(PROFILE_TARGET)

clean:
	rm -f $(OBJS) $(TARGET)
	rm -f $(PROFILE_OBJS) $(PROFILE_TARGET)
	rm -rf $(BUILD_DIR) $(PROFILE_BUILD_DIR)
	rm -f gmon.out

.PHONY: all clean profile
