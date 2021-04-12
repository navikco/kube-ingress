package net.kube.land.accounts.leetcode;

import net.kube.land.accounts.datastructures.Tree;

import java.util.ArrayList;
import java.util.List;

public class TreePlay {

    public static void main(String[] args) {

        TreePlay depthFirstSearch = new TreePlay();

        Tree.Node node = new Tree.Node(6);
        node.insert(8);
        node.insert(3);
        node.insert(2);
        node.insert(4);
        node.insert(7);
        node.insert(9);
        node.insert(5);

        depthFirstSearch.longestPath(node);
        System.out.println("Tree:Diameter[6, 8, 3, 2, 4, 7, 9] :::>>> " + depthFirstSearch.diameter);

        System.out.println("Tree:Count :::>>> " + node.count());
        List<Integer> sums = new ArrayList<>();
        depthFirstSearch.findSumByLevel(sums, node, 0);
        System.out.println("Tree:Sum by Level :::>>> ");
        sums.stream().forEach(sum -> System.out.print(sum + " "));
        depthFirstSearch.findAverageByLevel(sums);
        System.out.println("");
        System.out.println("Tree:Average by Level :::>>> ");
        sums.stream().forEach(sum -> System.out.print(sum + " "));

        Tree.Node tree1 = new Tree.Node(6);
        tree1.insert(8);
        tree1.insert(3);
        tree1.insert(2);
        tree1.insert(4);
        tree1.insert(7);
        tree1.insert(9);

        Tree.Node tree2 = new Tree.Node(6);
        tree2.insert(8);
        tree2.insert(3);
        tree2.insert(2);
        tree2.insert(4);
        tree2.insert(7);
        tree2.insert(9);

        System.out.println("Are the Trees Same? :::>>> " + depthFirstSearch.areSame(tree1, tree2, true));

        System.out.println("Are the Trees[1 & 2] Symmetric? :::>>> " + depthFirstSearch.areSymmetric(tree1.getLeft(), tree2.getRight(), true));

        System.out.println("Find Closest Value on Tree[8, 3, 2, 4, 7, 9] From 1.4925699  :::>>> " + depthFirstSearch.closestValue(tree1, 1.4925699));
        System.out.println("Find Closest Value on Tree[8, 3, 2, 4, 7, 9] From 4.8925699  :::>>> " + depthFirstSearch.closestValue(tree1, 4.8925699));
        System.out.println("Find Closest Value on Tree[8, 3, 2, 4, 7, 9] From 6.600099  :::>>> " + depthFirstSearch.closestValue(tree1, 6.600099));

        Tree.Node tree3 = new Tree.Node(1);
        tree3.insert(2);
        tree3.insert(2);
        tree3.insert(3);
        tree3.insert(3);
        tree3.insert(4);
        tree3.insert(4);
        System.out.println("Balanced Tree[1,2,2,3,3,null,null,4,4] :::>>> " + depthFirstSearch.isBalanced(tree3));

        List<String> paths = new ArrayList<>();
        Tree.Node tree4 = new Tree.Node(6);
        tree4.insert(3);
        tree4.insert(8);
        tree4.insert(4);
        tree4.insert(2);
        tree4.insert(7);
        depthFirstSearch.tracePaths(tree4, tree4, 0, tree4.getData() + "", paths);
        paths.stream().forEach(path -> System.out.print(path + " "));
    }

    public void findSumByLevel(List<Integer> averages, Tree.Node node, int i) {

        if (node == null) {
            return;
        } else {
            if (averages.size() > i) {
                averages.set(i, averages.get(i) + node.getData());
            } else {

                averages.add(i, node.getData());
            }
            i++;
        }
        findSumByLevel(averages, node.getLeft(), i);
        findSumByLevel(averages, node.getRight(), i);
    }

    private void findAverageByLevel(List<Integer> sums) {

        for (int i = 0; i < sums.size(); i++) {

            sums.set(i, sums.get(i) / 2);
        }
    }

    private boolean areSame(Tree.Node left, Tree.Node right, boolean isSame) {

        if(!isSame) {
            return isSame;
        }
        if (left != null && right != null && left.getData() == right.getData()) {
            isSame = areSame(left.getLeft(), right.getLeft(), isSame);
            isSame = areSame(left.getRight(), right.getRight(), isSame);
        } else if (left == null && right == null) {
            return isSame;
        } else {
            return false;
        }
        return isSame;
    }

    private boolean areSymmetric(Tree.Node tree1, Tree.Node tree2, boolean areEqual) {
        if(!areEqual) {
            return areEqual;
        }
        if (tree1 != null && tree2 != null && tree1.getData() == tree2.getData()) {
            areEqual = areSymmetric(tree1.getLeft(), tree2.getRight(), areEqual);
            areEqual = areSymmetric(tree1.getRight(), tree2.getLeft(), areEqual);
        } else if (tree1 == null && tree2 == null) {
            return true;
        } else {
            return false;
        }
        return areEqual;
    }

    public int closestValue(Tree.Node root, double target) {

        return findClosestValue(root, 0, target, Double.MAX_VALUE);
    }

    private int findClosestValue(Tree.Node node, int closestNode, double target, double diff) {
        if (node == null) {
            return closestNode;
        } else if (node.getData() == target) {
            closestNode = node.getData();
            return closestNode;
        } else {
            if (Math.abs(node.getData() - target) < diff) {
                diff = Math.abs(node.getData() - target);
                closestNode = node.getData();
            }
            int leftClosestNode = findClosestValue(node.getLeft(), closestNode, target, diff);
            int rightClosestNode = findClosestValue(node.getRight(), closestNode, target, diff);
            return (Math.abs(leftClosestNode - target) < Math.abs(rightClosestNode - target)) ? leftClosestNode : rightClosestNode;
        }
    }
    public boolean isBalanced(Tree.Node root) {

        return countNodes(root) != -1;
    }

    private int countNodes(Tree.Node node) {

        if (node == null) {
            return 0;
        }
        int leftCount = countNodes(node.getLeft());
        int rightCount = countNodes(node.getRight());
        if (leftCount == -1 || rightCount == -1 || Math.abs(leftCount - rightCount) > 1) {
            return -1;
        }
        return Math.max(leftCount, rightCount) + 1;
    }

    private void tracePaths(Tree.Node root, Tree.Node node, int index, String path, List<String> paths) {

        if (node.getLeft() == null && node.getRight() == null) {
            paths.add(path);
        }
        if (node.getLeft() != null) {
            String leftPath = path + "->" + node.getLeft().getData();
            tracePaths(root, node.getLeft(), index, leftPath, paths);
        }
        if (node.getRight() != null) {
            String rightPath = path + "->" + node.getRight().getData();
            tracePaths(root, node.getRight(), index, rightPath, paths);
        }
    }

    int diameter = 0;

    public int diameterOfBinaryTree(Tree.Node root) {

        longestPath(root);
        return diameter;
    }

    private int longestPath(Tree.Node node) {

        if (node == null) {
            return 0;
        }
        int leftPath = longestPath(node.getLeft());
        int rightPath = longestPath(node.getRight());

        diameter = Math.max(diameter, leftPath + rightPath);
        return Math.max(leftPath, rightPath) + 1;
    }
}