---
title: Evaluate Division
date: 2020-01-13 15:33:54
tags:
- LeetCode
categories: LeetCode
---

> 第59天，有好几天没做了，太咸鱼了我。

今天的题目是[Evaluate Division](https://leetcode.com/problems/evaluate-division/):

一道写起来比较麻烦，但是总体来看还是比较简单的。就是分为两步走即可：

1. 利用`equations`和`value`构造一个图
2. 然后通过在图上遍历的方式计算得到`queries`的值。

```c++
vector<double> calcEquation(vector<vector<string>>& equations, vector<double>& values, vector<vector<string>>& queries) {
    vector<double> res(queries.size());
    
    // calc elem set
    unordered_map<string, int> smap;
    int index = 0;
    for(auto &vec: equations) {
        auto it = smap.find(vec[0]);
        if (it == smap.end()) smap[vec[0]] = index++;
        it = smap.find(vec[1]);
        if (it == smap.end()) smap[vec[1]] = index++;
    }
    
    // for(auto p: smap) cout << p.second << endl;
    
    // build graph
    vector<vector<double>> graph(index, vector<double>(index, -1.0));
    for(int k = 0, size = equations.size(); k < size; k++) {
        int i = smap[equations[k][0]], j = smap[equations[k][1]];
        graph[i][j] = values[k];
        graph[j][i] = 1 / values[k];
    }

    for(int k = 0, size = queries.size(); k < size; k++) {
        auto it1 = smap.find(queries[k][0]);
        auto it2 = smap.find(queries[k][1]);
        if (it1 == smap.end() || it2 == smap.end()) {
            res[k] = -1.0;
            continue;
        }
            
        if (queries[k][0] == queries[k][1]) {
            res[k] = 1.0;
            continue;
        }
        
        int i = it1->second, j = it2->second;
        vector<bool> visited(index, false);
        if (dfs(graph, visited,i, j, res[k]) == false) {
            res[k] = -1.0;
        }
    }
    return res;
}

bool dfs(vector<vector<double>> &graph, vector<bool> &visited, int s, int e, double &res) {
    if (s == e) { res = 1.0; return true; }
    visited[s] = true;
    for(int i = 0;i < graph.size(); i++) {
        double temp;
        if (visited[i] == false && graph[s][i] > 0 && dfs(graph, visited, i, e, temp)) {
            res = temp * graph[s][i];
            return true;
        }
    }
    return false;
}
```