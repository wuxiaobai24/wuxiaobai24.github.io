---
title: Find Eventual Safe States
date: 2019-12-20 12:53:23
tags:
- LeetCode
categories: LeetCode
---

> 第44天。

今天的题目是[Find Eventual Safe States](https://leetcode.com/problems/find-eventual-safe-states/):

最开始的想法是，从安全的节点开始在图中进行扩散，当一个节点所有边都指向一个安全的节点时，那它也是一个安全的节点，但是这样复杂度挺高的，所以虽然能过：

```c++
bool check(vector<vector<int>>& graph, vector<bool> &color, int i) {
    for(auto &j: graph[i]) {
        if (!color[j]) return false;
    }
    return true;
}
vector<int> eventualSafeNodes(vector<vector<int>>& graph) {
    int size = graph.size();
    vector<int> res;
    if (size == 0) return res;
    
    vector<bool> color(size, false);
    bool change = false;
    for(int i = 0;i < size; i++) 
        if (graph[i].size() == 0) {
            color[i] = true;
            change = true;
        }
    
    while(change) {
        change = false;
        for(int i = 0;i < size; i++) {
            if (color[i] == false && check(graph, color, i)) {
                color[i] = true;
                change = true;
            }
        }
    }
    
    for(int i = 0;i < size; i++) {
        if (color[i]) res.push_back(i);
    }
    return res;
}
```

后来发现好像可以用深度优先来做，主要的想法是，一个环中所有的节点都是不安全的，我们把不安全的节点都筛选出来，即可得到所有安全的节点。
因此就把问题变成了找到图中所有在环中的节点。在DFS时，维护一个状态，这个状态可能为：

- 0：未访问（初始状态）
- 1：访问中
- 2：访问完成（安全状态）
- 3：在环中（不安全状态）

先把所有节点的状态都初始化为`0`,当对第 i 个节点调用 dfs 时，则将其转换为`1`,然后遍历该节点所有能走的边，
如果下一个节点的状态为`0`，则对其调用dfs，如果下一个节点的状态为`1`或`2`，则该节点出现在环中，将状态转换为`3`，并直接返回为`3`。
当 i 节点对 j 节点调用 dfs 后，返回值如果为3的话，则 i 节点状态也变为 `3`, 并直接返回`3`。

如果第 `i` 个节点对所有路径都调用了 dfs 后，没有遇到返回值为 `3` 的情况，则该节点为安全的，所以将其状态转换为 `2`。

代码如下：

```c++
vector<int> eventualSafeNodes(vector<vector<int>>& graph) {
    int size = graph.size();
    vector<int> res;
    if (size == 0) return res;
    
    vector<int> color(size, 0); // 0 mean unvisit
    for(int i = 0;i < size; i++) {
        if (color[i] == 0) dfs(graph, color, i);
    }
    
    for(int i = 0;i < size; i++) {
        if (color[i] == 2) res.push_back(i);
    }
    return res;
    
}

int dfs(vector<vector<int>> &graph, vector<int> &color, int node) {
    // cout << "visit" << node << endl;
    color[node] = 1; // in dfs
    for(int j = 0;j < graph[node].size(); j++) {
        int i = graph[node][j];
        if ( (color[i] == 0 && dfs(graph, color, i) == 3) ||
            color[i] == 1 || color[i] == 3
            ) {
            color[node] = 3;
            return 3;
        }
    }
    color[node] = 2;// safe node
    return color[node];
}
```