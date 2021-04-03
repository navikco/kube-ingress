package net.kube.land.accounts.algo;

import java.util.Arrays;

//TC - Linear - o(n)
//SC - Linear - o(n)
//Purpose - Remove Duplicate from sorted array and return new Length
public class DuplicateElements {

    public static void main(String[] args) {

        int index = 1;
        int[] array1 = {4, 4, 9, 13, 18, 23, 23, 31};

        for (int i = 0; i < array1.length - 1; i++) {

            if(array1[i] != array1[i + 1]) {
                System.out.println("Duplicate Element ::: " + array1[i] + " at array1[" + i + "] & [" + (i + 1) + "]");
                array1[index++] = array1[i + 1];
            }
        }
        System.out.println("Unique Array [" + index + "] ::: " + Arrays.toString(array1));
    }
}
