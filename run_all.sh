#!/bin/sh
amount=1000
if [ $# -gt 0 ]; then amount=$1; fi

#./bench.lua $amount
#./bench.js $amount
#./bench.py $amount
java bench $amount
java -Djava.library.path=. bench_jni benchjni_gcc $amount
java -Djava.library.path=. bench_jni benchjni_clang $amount
java -Djava.library.path=. bench_jni benchjni_asm $amount
./bench.gcc.c $amount
./bench.clang.c $amount
./bench.asm $amount
./bench.cs $amount
