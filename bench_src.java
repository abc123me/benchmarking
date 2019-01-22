public class bench_src{
	public static void main(String[] args){
		int amount = 1000, benches = 1;
		if(args.length > 0)
			amount = Integer.parseInt(args[0]);
		if(args.length > 1)
			benches = Integer.parseInt(args[1]);
		if(benches <= 0) benches = 1;
		if(amount <= 0) amount = 1;
		int[] buf = new int[amount];
		long[] times = new long[benches];
		for(int b = 0; b < times.length; b++){
			long start = System.currentTimeMillis();
			primes(amount, buf);
			times[b] = System.currentTimeMillis() - start;
		}
		System.out.printf("[Java]: Finding %d primes took ", amount);
		if(times.length == 1) System.out.print(times[0] + "ms");
		else{
			System.out.print("[" + times[0]);
			for(int i = 1; i < times.length; i++)
				System.out.print(", " + times[i]);
			System.out.print("]");
		}
		System.out.println();
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

