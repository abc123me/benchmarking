#include "time.h"
#include "stdio.h"
#include "stdlib.h"
#include "inttypes.h"
#include "benchlib.h"

unsigned long time_ns();
unsigned long time_us();
unsigned long time_ms();

int main(int argc, char** argv){
	uint32_t amount = 10000;
	uint8_t benches = 1;
	if(argc > 1)
		amount = atoi(argv[1]);
	if(argc > 2)
		benches = atoi(argv[2]);
	if(amount <= 0)
		amount = 1;
	if(benches <= 0)
		benches = 1;
	uint32_t* buf = (uint32_t*) malloc(sizeof(uint32_t) * amount);
	uint64_t* times = (uint64_t*) malloc(sizeof(uint64_t) * benches);
	for(uint8_t b = 0; b < benches; b++){
		uint64_t start = time_ms();
		primes(amount, buf);
		uint64_t time = time_ms() - start;
		times[b] = time;
	}
	printf("[%s]: Finding %i primes took ", getName(), amount);
	if(benches > 1){
		printf("[%lu", times[0]);
		for(uint8_t i = 1; i < benches; i++)
			printf(", %lu", times[i]);
		putchar(']');
	} else {
		printf("%lums", times[0]);
	}

	putchar('\n');
	free(buf);
	free(times);
	return 0;
}

unsigned long time_ns(){
	struct timespec r;
	clock_gettime(CLOCK_MONOTONIC, &r);
	return r.tv_nsec + r.tv_sec * 1000000000;
}
unsigned long time_us(){ return time_ns() / 1000; }
unsigned long time_ms(){ return time_ns() / 1000000; }
