---
title: Network Delay Time
date: 2019-12-16 14:22:11
tags:
- LeetCode
categories: LeetCode
---

> 第40天。

今天的题目是[Network Delay Time](https://leetcode.com/problems/network-delay-time/):

一道图的题目，比较常规，用Dijkstra求单源最短路，然后取距离最远的那个即可得到`Network Delay Time`:

```c++
int minDisNode(vector<bool> &visited, vector<int> &dis) {
    int min_v = INT_MAX, min_i = -1;;
    for(int j = 0;j < dis.size();j++) {
        if (!visited[j] && dis[j] < min_v) {
            min_v = dis[j];
            min_i = j;
        }
    }
    return min_i;
}
int networkDelayTime(vector<vector<int>>& times, int N, int K) {
    if (times.size() == 0 || N==0 || K <= 0) return -1; 
    //build graph;
    vector<vector<int>> graph(N, vector<int>(N, INT_MAX));
    for(auto &t: times) {
        graph[t[0]-1][t[1]-1] = t[2];
    }

    K--;
    vector<int> dis(N, INT_MAX);
    vector<bool> visited(N, false);
    visited[K] = true;
    for(int i = 0;i < dis.size(); i++) {
        dis[i] = graph[K][i];
    }
    dis[K] = 0;

    for(int i = 1;i < N; i++) {
        // find a unvisited node which dis is min
        int j = minDisNode(visited, dis);
        if (j == -1) return -1;
        
        visited[j] = true;
        for(int k = 0;k < dis.size(); k++) {
            if (graph[j][k] != INT_MAX) {
                dis[k] = min(dis[k], dis[j] + graph[j][k]);
            }
        }
    }
    
    int res = 0;
    for(int i = 0;i < N;i++) {
        if (dis[i] != INT_MAX)
            res = max(res, dis[i]);
    }
    return res;
}
```
