NAME = cpppoa-perf

default: all

all: bin/test

fetch-deps:
	git submodule update --init --recursive

cpppoa/lib/libcpppoa.a: fetch-deps
	make -C cpppoa

obj/main.o: src/main.cpp Makefile
	mkdir -p obj
	$(CXX) -c -std=c++11 src/main.cpp -o obj/main.o

bin/test: Makefile obj/main.o cpppoa/lib/libcpppoa.a
	mkdir -p bin
	$(CXX) -std=c++11 -L cpppoa/lib -lcpppoa -o bin/test obj/main.o 

clean:
	rm -r bin || true
	rm -r obj || true
	make -C cpppoa clean
