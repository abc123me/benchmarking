public class bench_jni{
	public static void main(String[] args){
		int amount = 1000, benches = 1;
		System.loadLibrary(args[0]);
		if(args.length > 1)
			amount = Integer.parseInt(args[1]);
		if(args.length > 2)
			benches = Integer.parseInt(args[2]);
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
	public static native void primes(int n, int[] buf);
	public static native boolean prime(int n);
	public static native String getName();
}

