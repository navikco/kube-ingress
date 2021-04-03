package net.kube.land.accounts.algo;

//TC - Recursion - o(2^k)
//SC - Linear - o(n)
//Purpose - Push Zeros to the End
public class Memoizer {

    public static void main(String[] args) {

        int[] memoizer = new int[Integer.parseInt(args[0])];
        System.out.println("Input ::: " + args.length + " ::: " + Integer.parseInt(args[0]) + " :>>> " + fab(Integer.parseInt(args[0]), memoizer));
    }

    private static int fab(int num, int []memoizer) {

        System.out.println("Recursion ::: " + num);

        if (num <= 1)
            return 1;

        if (memoizer[num - 1] == 0) {
//            System.out.println("Memoizer ::: " + (num - 1));
            memoizer[num - 1] = fab(num - 1, memoizer) + fab(num - 2, memoizer);
        }

        return memoizer[num - 1];
    }
}
