# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/kbpoyo/code/uC-OS2-s3c2440

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/kbpoyo/code/uC-OS2-s3c2440/build

# Include any dependencies generated for this target.
include src/boot/CMakeFiles/boot.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/boot/CMakeFiles/boot.dir/compiler_depend.make

# Include the progress variables for this target.
include src/boot/CMakeFiles/boot.dir/progress.make

# Include the compile flags for this target's objects.
include src/boot/CMakeFiles/boot.dir/flags.make

src/boot/CMakeFiles/boot.dir/boot.S.o: src/boot/CMakeFiles/boot.dir/flags.make
src/boot/CMakeFiles/boot.dir/boot.S.o: ../src/boot/boot.S
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/kbpoyo/code/uC-OS2-s3c2440/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building ASM object src/boot/CMakeFiles/boot.dir/boot.S.o"
	cd /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot && /home/kbpoyo/opt/FriendlyARM/toolschain/4.4.3/bin/arm-linux-gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -o CMakeFiles/boot.dir/boot.S.o -c /home/kbpoyo/code/uC-OS2-s3c2440/src/boot/boot.S

src/boot/CMakeFiles/boot.dir/boot.S.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing ASM source to CMakeFiles/boot.dir/boot.S.i"
	cd /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot && /home/kbpoyo/opt/FriendlyARM/toolschain/4.4.3/bin/arm-linux-gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -E /home/kbpoyo/code/uC-OS2-s3c2440/src/boot/boot.S > CMakeFiles/boot.dir/boot.S.i

src/boot/CMakeFiles/boot.dir/boot.S.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling ASM source to assembly CMakeFiles/boot.dir/boot.S.s"
	cd /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot && /home/kbpoyo/opt/FriendlyARM/toolschain/4.4.3/bin/arm-linux-gcc $(ASM_DEFINES) $(ASM_INCLUDES) $(ASM_FLAGS) -S /home/kbpoyo/code/uC-OS2-s3c2440/src/boot/boot.S -o CMakeFiles/boot.dir/boot.S.s

src/boot/CMakeFiles/boot.dir/boot.c.o: src/boot/CMakeFiles/boot.dir/flags.make
src/boot/CMakeFiles/boot.dir/boot.c.o: ../src/boot/boot.c
src/boot/CMakeFiles/boot.dir/boot.c.o: src/boot/CMakeFiles/boot.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/kbpoyo/code/uC-OS2-s3c2440/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object src/boot/CMakeFiles/boot.dir/boot.c.o"
	cd /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot && /home/kbpoyo/opt/FriendlyARM/toolschain/4.4.3/bin/arm-linux-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/boot/CMakeFiles/boot.dir/boot.c.o -MF CMakeFiles/boot.dir/boot.c.o.d -o CMakeFiles/boot.dir/boot.c.o -c /home/kbpoyo/code/uC-OS2-s3c2440/src/boot/boot.c

src/boot/CMakeFiles/boot.dir/boot.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/boot.dir/boot.c.i"
	cd /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot && /home/kbpoyo/opt/FriendlyARM/toolschain/4.4.3/bin/arm-linux-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/kbpoyo/code/uC-OS2-s3c2440/src/boot/boot.c > CMakeFiles/boot.dir/boot.c.i

src/boot/CMakeFiles/boot.dir/boot.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/boot.dir/boot.c.s"
	cd /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot && /home/kbpoyo/opt/FriendlyARM/toolschain/4.4.3/bin/arm-linux-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/kbpoyo/code/uC-OS2-s3c2440/src/boot/boot.c -o CMakeFiles/boot.dir/boot.c.s

# Object files for target boot
boot_OBJECTS = \
"CMakeFiles/boot.dir/boot.S.o" \
"CMakeFiles/boot.dir/boot.c.o"

# External object files for target boot
boot_EXTERNAL_OBJECTS =

src/boot/boot: src/boot/CMakeFiles/boot.dir/boot.S.o
src/boot/boot: src/boot/CMakeFiles/boot.dir/boot.c.o
src/boot/boot: src/boot/CMakeFiles/boot.dir/build.make
src/boot/boot: src/boot/CMakeFiles/boot.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/kbpoyo/code/uC-OS2-s3c2440/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable boot"
	cd /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/boot.dir/link.txt --verbose=$(VERBOSE)
	cd /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot && arm-linux-objcopy -S -O binary /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot/boot.elf /home/kbpoyo/code/uC-OS2-s3c2440/bin/boot.bin
	cd /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot && arm-linux-objcopy /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot/boot.elf /home/kbpoyo/code/uC-OS2-s3c2440/image/boot.elf
	cd /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot && arm-linux-objdump -x -d -S -m armv4 /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot/boot.elf > boot_dis.txt
	cd /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot && arm-linux-readelf -a /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot/boot.elf > boot_elf.txt

# Rule to build all files generated by this target.
src/boot/CMakeFiles/boot.dir/build: src/boot/boot
.PHONY : src/boot/CMakeFiles/boot.dir/build

src/boot/CMakeFiles/boot.dir/clean:
	cd /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot && $(CMAKE_COMMAND) -P CMakeFiles/boot.dir/cmake_clean.cmake
.PHONY : src/boot/CMakeFiles/boot.dir/clean

src/boot/CMakeFiles/boot.dir/depend:
	cd /home/kbpoyo/code/uC-OS2-s3c2440/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/kbpoyo/code/uC-OS2-s3c2440 /home/kbpoyo/code/uC-OS2-s3c2440/src/boot /home/kbpoyo/code/uC-OS2-s3c2440/build /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot /home/kbpoyo/code/uC-OS2-s3c2440/build/src/boot/CMakeFiles/boot.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/boot/CMakeFiles/boot.dir/depend

