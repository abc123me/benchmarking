#include "benchlib.h"

char* getName(){
	#if defined(__clang__)
		return "C w/ Clang";
	#elif defined(__GNUC__)
		return "C w/ GCC";
	#else
		return "C";
	#endif
}
int prime(int n){
        if(n == 2) return 1;
        if(n < 2) return 0;
        if((n & 1) == 0) return 0;
        for(int i = 3; i < n; i += 2)
                if(n % i == 0)
                        return 0;
        return 1;
}
void primes(int n, int* buf){
        if(n <= 0) return;
        buf[0] = 2;
        int i = 1, j = 3;
        while(i < n){
                if(prime(j)){
                        buf[i] = j;
                        i++;
                }
                j += 2;
        }
}

