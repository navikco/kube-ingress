package net.kube.land.accounts.algo;

import lombok.Getter;
import net.kube.land.accounts.datastructures.Tree;

import java.util.*;

public class BreadthFirstSearch {

    public static void main(String[] args) {

        BreadthFirstSearch breadthFirstSearch = new BreadthFirstSearch();

        Tree.Node node = new Tree.Node(6);
        node.insert(8);
        node.insert(3);
        node.insert(2);
        node.insert(4);
        node.insert(7);
        node.insert(9);

        List<Integer> sums = new ArrayList<>();
        breadthFirstSearch.findSumByLevel(sums, node);
        System.out.println("Tree:Sum by Level :::>>> ");
        sums.stream().forEach(sum -> System.out.print(sum + " "));
        breadthFirstSearch.findAverageByLevel(sums);
        System.out.println("");
        System.out.println("Tree:Average by Level :::>>> ");
        sums.stream().forEach(sum -> System.out.print(sum + " "));
    }

    @Getter
    class QueueNode {
        int index;
        Tree.Node node;

        public QueueNode(int index, Tree.Node node) {
            this.index = index;
            this.node = node;
        }
    }

    public void findSumByLevel(List<Integer> averages, Tree.Node node) {

        if (node == null) {
            return;
        }
        Queue<QueueNode> queue = new LinkedList();
        queue.add(new QueueNode(0, node));
        while (!queue.isEmpty()) {

            QueueNode queueNode = queue.remove();
            int queueData = queueNode.getNode().getData();
            int level = queueNode.index;
            if (averages.size() > level) {
                averages.set(level, averages.get(level) + queueData);
            } else {
                averages.add(level, queueData);
            }
            level++;
            if (queueNode.getNode().getLeft() != null) {
                queue.add(new QueueNode(level, queueNode.getNode().getLeft()));
            }
            if (queueNode.getNode().getRight() != null) {
                queue.add(new QueueNode(level, queueNode.getNode().getRight()));
            }
        }
    }

    private void findAverageByLevel(List<Integer> sums) {

        for (int i = 0; i < sums.size(); i++) {

            sums.set(i, sums.get(i) / 2);
        }
    }
}