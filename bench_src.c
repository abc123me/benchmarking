#include "time.h"
#include "stdio.h"
#include "stdlib.h"
#include "benchlib.h"

unsigned long time_ns();
unsigned long time_us();
unsigned long time_ms();

int main(int argc, char** argv){
	int amount = 10000;
	if(argc > 1)
		amount = atoi(argv[1]);
	int* buf = (int*) malloc(sizeof(int) * amount);
	unsigned long start = time_ms();
	primes(amount, buf);
	unsigned long time = time_ms() - start;
	printf("[%s]: Finding %i primes took %lums\n", getName(), amount, time);
	free(buf);
	return 0;
}

unsigned long time_ns(){
	struct timespec r;
	clock_gettime(CLOCK_MONOTONIC, &r);
	return r.tv_nsec + r.tv_sec * 1000000000;
}
unsigned long time_us(){ return time_ns() / 1000; }
unsigned long time_ms(){ return time_ns() / 1000000; }
