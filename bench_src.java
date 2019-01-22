public class bench_src{
	public static void main(String[] args){
		int amount = 1000;
		if(args.length >= 1)
			amount = Integer.parseInt(args[0]);
		int[] buf = new int[amount];
		long start = System.currentTimeMillis();
		primes(amount, buf);
		long time = System.currentTimeMillis() - start;
		System.out.printf("[Java]: Finding %d primes took %dms\n", amount, time);
	}

	public static boolean prime(int n){
		if(n == 2) return true;
		if(n < 2) return false;
		if((n & 1) == 0) return false;
		for(int i = 3; i < n; i += 2)
			if(n % i == 0)
				return false;
		return true;
	}
	public static void primes(int n, int[] buf){
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
}

