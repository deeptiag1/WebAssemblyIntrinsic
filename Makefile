PROJECT_NAME = webassemblyintrinsic
COMPILER = clang++
#COMPILER = g++

CFLAGS = -std=c++17 -I/usr/include/c++/7.3.0 -O0 --target=wasm32-unknown-unknown
LFLAGS = --target=wasm32 -nostdlib
INCLUDE_DIR = ./
TEST_DIR = ./
SRC_DIR = ./
EXECUTABLE_NAME = WebAssemblyIntrinsic

all: $(EXECUTABLE_NAME)

#-Wl,--no-entry if no main
$(EXECUTABLE_NAME): $(EXECUTABLE_NAME).o
	 $(COMPILER) $(LFLAGS) -Wl,--no-entry -o $(EXECUTABLE_NAME) $(EXECUTABLE_NAME).o

$(EXECUTABLE_NAME).o: $(EXECUTABLE_NAME).cpp
	 $(COMPILER) $(CFLAGS) -c $(EXECUTABLE_NAME).cpp

disasm:
	clang -std=c++17 -O0 -emit-llvm --target=wasm32-unknown-unknown $(EXECUTABLE_NAME).cpp -c -o $(EXECUTABLE_NAME).bc
	llvm-dis < $(EXECUTABLE_NAME).bc > $(EXECUTABLE_NAME).dis
clean:
	 rm -f $(EXECUTABLE_NAME).o $(EXECUTABLE_NAME).bc $(EXECUTABLE_NAME).dis $(EXECUTABLE_NAME)
