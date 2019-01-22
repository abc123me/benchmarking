#!/usr/bin/python3
def prime(n):
	if n == 2:
		return True
	if (n & 1) == 0 or n < 2:
		return False
	for i in range(3, n, 2):
		if n % i == 0:
			return False
	return True
def primes(buf):
	primes(buf, len(buf))
def primes(buf, n):
	if n < 1: return
	j = 1
	i = 1
	buf[0] = 2
	while i < n:
		if prime(j):
			buf[i] = j
			i = i + 1
		j = j + 2

if __name__ == "__main__":
	import time, sys
	amount = 1000
	benches = 1
	if len(sys.argv) > 1:
		amount = int(sys.argv[1])
	if len(sys.argv) > 2:
		benches = int(sys.argv[2])
	def millis():
		return int(time.time() * 1000.0)
	buf = [0] * amount
	times = [0] * benches
	for i in range(0, benches):
		start = millis()
		primes(buf, amount)
		times[i] = millis() - start
	if len(times) == 1:
		print("[Python] Finding %i primes took %ims" % (amount, times[i]))
	else:
		print("[Python] Finding %i primes took %s" % (amount, str(times)))
