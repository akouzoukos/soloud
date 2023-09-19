#!/usr/bin/env make

BUILD = build/$(PLATFORM)
SRC = src

CXXFLAGS = -I./include -O3

# Compiler and linker flags
# Source files
SRCS = $(wildcard $(SRC)/**/*.cpp)
SRCS += $(wildcard $(SRC)/**/*.c)

SRCS += $(wildcard $(SRC)/audiosource/wav/*.cpp)
SRCS += $(wildcard $(SRC)/audiosource/wav/*.c)

ifeq ($(PLATFORM),wasm)
CXXFLAGS += -D WITH_SDL2_STATIC=1 -s USE_SDL=2

SRCS += $(wildcard $(SRC)/backend/sdl2_static/*.cpp)
SRCS += $(wildcard $(SRC)/backend/sdl2_static/*.c)
else
CXXFLAGS += -D WITH_SDL2_STATIC=1 -lSDL2 -I/opt/devkitpro/portlibs/switch/include/SDL2 -fPIC -fPIE

SRCS += $(wildcard $(SRC)/backend/sdl2_static/*.cpp)
SRCS += $(wildcard $(SRC)/backend/sdl2_static/*.c)
endif

# Object files
OBJS = $(subst $(SRC)/,$(BUILD)/, $(addsuffix .o,$(basename $(SRCS))))

# Build rules
.PHONY: all clean

all: libs

libs: $(OBJS)
	@mkdir -p lib/$(PLATFORM)
	$(AR) rcs lib/$(PLATFORM)/libsoloud.a $^

$(BUILD)/%.o: $(SRC)/%.cpp
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c -o $@ $< -I./include

$(BUILD)/%.o: $(SRC)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CXXFLAGS) -c -o $@ $< -I./include

clean:
	rm -f $(OBJS) lib/$(PLATFORM)/libsoloud.a
