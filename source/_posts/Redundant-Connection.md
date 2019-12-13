---
title: Redundant Connection
date: 2019-12-13 11:31:41
tags:
- LeetCode
categories: LeetCode
---

> 第37天。

今天的题目是[Redundant Connection](https://leetcode.com/problems/redundant-connection/):

这道题用并查集可以解决掉，具体思路如下：

首先初始化一个并查集，然后遍历输入`edges`，使用并查集查找两个节点所在的集合，如果两个节点在同一个节点中，那么往图里面加入这条边就会出现环，即无法构成树，因此这条边就是我们要求的边；如果不在集合，那么就将这条边插入到图中（即合并两个集合）。具体实现如下：

```c++
int root(vector<int> &ids, int i) {
    while(ids[i] != i) i = ids[i];
    return i;
}
vector<int> findRedundantConnection(vector<vector<int>>& edges) {
    if (edges.size() == 0) return vector<int>();
    vector<int> ids(edges.size());
    for(int i = 0;i < ids.size(); i++) ids[i] = i;
    
    for(auto &e: edges) {
        int n1 = root(ids, e[0]-1), n2 = root(ids, e[1]-1);
        if (n1 == n2) return e;
        ids[n1] = n2;
    }
    return *edges.rbegin();
}
```
