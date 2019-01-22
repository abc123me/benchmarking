#!/usr/bin/env node

function prime(n){
	if(n == 2) return true;
	if(n < 2) return false;
	if((n & 1) == 0) return 0;
	for(var i = 3; i < n; i += 2)
		if(n % i == 0)
			return false;
	return true;
}
function primes(n, buf){
	if(n <= 0) return;
	buf[0] = 2;
	var i = 1, j = 3;
	while(i < n){
		if(prime(j)){
			buf[i] = j;
			i++;
		}
		j += 2;
	}
}
function millis(){
	return new Date().getTime();
}

var amount = 1000;
process.argv.forEach(function(val, index, array) {
	if(val.match(/[0-9]+/))
		amount = val;
});
var buf = {};
var start = millis();
primes(amount, buf);
var took = millis() - start;
console.log("[NodeJS] Finding " + amount + " primes took " + took + "ms");
