NAME = cpppoa-perf

default: all

all: bin/test bin/run

fetch-deps:
	git submodule update --init --recursive

cpppoa/lib/libcpppoa.a: fetch-deps
	make -C cpppoa

obj/main.o: src/main.cpp Makefile
	mkdir -p obj
	$(CXX) -c -std=c++11 src/main.cpp -o obj/main.o

bin/run: Makefile obj/main.o cpppoa/lib/libcpppoa.a
	mkdir -p bin
	$(CXX) -std=c++11 -L cpppoa/lib -lcpppoa -o bin/run obj/main.o 

bin/test: test/test.sh
	mkdir -p bin
	cp test/test.sh bin/test

test: bin/run bin/test
	./bin/test

clean:
	rm -r bin || true
	rm -r obj || true
	make -C cpppoa clean
