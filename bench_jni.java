public class bench_jni{
	public static void main(String[] args){
		System.loadLibrary(args[0]);
		int amount = 1000;
		if(args.length >= 2)
			amount = Integer.parseInt(args[1]);
		int[] buf = new int[amount];
		long start = System.currentTimeMillis();
		primes(amount, buf);
		long time = System.currentTimeMillis() - start;
		System.out.printf("[Java w/ JNI (" + getName() + ")]: Finding %d primes took %dms\n", amount, time);
	}

	public static native void primes(int n, int[] buf);
	public static native boolean prime(int n);
	public static native String getName();
}

