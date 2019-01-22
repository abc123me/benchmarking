#include "stdio.h"
#include "stdlib.h"
#include "jni.h"
#include "bench_jni.h"
#include "benchlib.h"

JNIEXPORT void JNICALL Java_bench_1jni_primes(JNIEnv* env, jclass c, jint num, jintArray buf){
	jsize len = (*env)->GetArrayLength(env, buf);
	jint* dat = (*env)->GetIntArrayElements(env, buf, 0);
	if(sizeof(jint) != sizeof(int)){
		printf("Sizes not the same, end of world\n");
		exit(-1);
	}
	primes(num, (int*) dat);
	return;
}
JNIEXPORT jboolean JNICALL Java_bench_1jni_prime(JNIEnv* env, jclass c, jint num){
	return prime((int) num);
}
JNIEXPORT jstring JNICALL Java_bench_1jni_getName(JNIEnv* env, jclass c){
	return (*env)->NewStringUTF(env, getName());
}
