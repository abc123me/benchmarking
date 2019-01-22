#!/bin/sh
amount=5000
benches=1
if [ $# -gt 0 ]; then amount=$1; fi
if [ $# -gt 1 ]; then benches=$2; fi

slow=0
if [ $amount -gt 5000 ]; then
	echo "Disabling Lua and Python due to their slow speed"
	slow=1
fi

args="$amount $benches"

if [ $slow -eq 0 ]; then ./bench.lua $args; fi
./bench.js $args
if [ $slow -eq 0 ]; then ./bench.py $args; fi
java bench_src $args
java -Djava.library.path=. bench_jni benchjni_gcc $args
java -Djava.library.path=. bench_jni benchjni_clang $args
# java -Djava.library.path=. bench_jni benchjni_asm $args
./bench.gcc.c $args
./bench.clang.c $args
./bench.asm $args
./bench.cs $args
