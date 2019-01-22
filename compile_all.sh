#!/bin/sh

jni_include="-I /usr/lib/jvm/java-8-openjdk-amd64/include/ -I /usr/lib/jvm/java-8-openjdk-amd64/include/linux"

echo "Assembling benchlib.asm"
nasm -f elf64 benchlib.asm -o benchlib.asm.o
echo "Compiling benchlib.c"
gcc -c benchlib.c -o benchlib.c.gcc.o -O3 -fpic
clang -c benchlib.c -o benchlib.c.clang.o -O3 -fpic
echo "Compiling bench.c"
gcc -c bench_src.c -o bench.o
echo "Creating executables"
# Assembly
gcc bench.o benchlib.asm.o -o bench.asm -O3
# Normal, statically linked
gcc bench.o benchlib.c.gcc.o -o bench.gcc.c -O3
clang bench.o benchlib.c.clang.o -o bench.clang.c -O3
echo "Compiling Java"
javac bench_src.java
javac bench_jni.java
javah bench_jni
echo "Compiling JNI bullshit"
dojni(){
	gcc -c benchlibjni.c -o benchlibjni.o -O3 -fpic $jni_include
	gcc benchlibjni.o $1 -shared -o $2
	rm -v benchlibjni.o
}
dojni benchlib.c.gcc.o   libbenchjni_gcc.so
dojni benchlib.c.clang.o libbenchjni_clang.so
#dojni benchlib.asm.o     libbenchjni_asm.so
echo "Done, cleaning up"
rm -v *.o
