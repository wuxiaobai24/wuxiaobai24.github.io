---
title: Is Graph Bipartite?
date: 2019-11-25 10:20:49
tags:
- LeetCode
categories:
- LeetCode
---

> 第21天。

今天的题目是[  Is Graph Bipartite? ]( https://leetcode.com/problems/is-graph-bipartite/ )：

---

Given an undirected `graph`, return `true` if and only if it is bipartite.

Recall that a graph is *bipartite* if we can split it's set of nodes into two independent subsets A and B such that every edge in the graph has one node in A and another node in B.

The graph is given in the following form: `graph[i]` is a list of indexes `j` for which the edge between nodes `i` and `j` exists. Each node is an integer between `0` and `graph.length - 1`. There are no self edges or parallel edges: `graph[i]` does not contain `i`, and it doesn't contain any element twice.

```
Example 1:
Input: [[1,3], [0,2], [1,3], [0,2]]
Output: true
Explanation: 
The graph looks like this:
0----1
|    |
|    |
3----2
We can divide the vertices into two groups: {0, 2} and {1, 3}.
Example 2:
Input: [[1,2,3], [0,2], [0,1,3], [0,2]]
Output: false
Explanation: 
The graph looks like this:
0----1
| \  |
|  \ |
3----2
We cannot find a way to divide the set of nodes into two independent subsets.
```

 

**Note:**

- `graph` will have length in range `[1, 100]`.
- `graph[i]` will contain integers in range `[0, graph.length - 1]`.
- `graph[i]` will not contain `i` or duplicate values.
- The graph is undirected: if any element `j` is in `graph[i]`, then `i` will be in `graph[j]`.

---

这是一道关于图的问题，题目的意思很简单，就是要判断一个图是不是一个二部图，所谓的二部图，就是一个图可以把所有节点划分到两个不相交的两个集合，这两个集合内部没有边相连。

我们可以对图进行一次遍历，遍历的时候对节点进行着色，着色的规律是这样的，当从一个节点跳到另一个节点的时候，我们就切换一次颜色（共有三种颜色，其中一种表示没有访问，即白色）。因为遍历完了之后，整个图的节点就被划分成两部分了，接下来我们只需要判断所有节点的邻居是否和它是不同色的即可。代码如下：

```c++
char color;
bool isBipartite(vector<vector<int>>& graph) {
    int size = graph.size();
    vector<char> flags(size, 'w');
    // w g b
    color = 'b';
    for(int i = 0;i < size;i++) {
        if (flags[i] == 'w') {
            dfs(graph, flags, i);
        }
    }

    for(int i = 0;i < size;i++) {
        for(auto j: graph[i]) {
            if (flags[i] == flags[j]) return false;
        }
    }
    return true;
}

void dfs(vector<vector<int>> &graph, vector<char> &flags, int index) {
    flags[index] = color;
    for(auto j: graph[index]) {
        if (flags[j] == 'w') {
            color = ~color;
            dfs(graph, flags, j);
            color = ~color;
        }
    }
}
```

