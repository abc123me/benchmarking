#!/usr/bin/nodejs

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
var benches = 1;
if(process.argv.length > 2)
	amount = process.argv[2];
if(process.argv.length > 3)
	benches = process.argv[3];

var buf = new Array(amount);
var times = new Array(benches);
for(var i = 0; i < benches - 1; i++){
	var start = millis();
	primes(amount, buf);
	times[i] = millis() - start;
}
var s = "";
if(benches == 1)
	s = times[0] + "ms";
else{
	s = "[" + times[0];
	for(var i = 0; i < times.length; i++)
		s += ", " + times[i];
	s += "]";
}
console.log("[NodeJS] Finding " + amount + " primes took " + s);
