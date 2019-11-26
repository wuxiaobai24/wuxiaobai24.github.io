---
title: Possible Bipartition
date: 2019-11-26 16:13:42
tags:
- LeetCode
categories: LeetCode
---

> 第22天

今天的题目是[ Possible Bipartition ]( https://leetcode.com/problems/possible-bipartition/ )：

---

Given a set of `N` people (numbered `1, 2, ..., N`), we would like to split everyone into two groups of **any** size.

Each person may dislike some other people, and they should not go into the same group. 

Formally, if `dislikes[i] = [a, b]`, it means it is not allowed to put the people numbered `a` and `b` into the same group.

Return `true` if and only if it is possible to split everyone into two groups in this way.

 

**Example 1:**

```
Input: N = 4, dislikes = [[1,2],[1,3],[2,4]]
Output: true
Explanation: group1 [1,4], group2 [2,3]
```

**Example 2:**

```
Input: N = 3, dislikes = [[1,2],[1,3],[2,3]]
Output: false
```

**Example 3:**

```
Input: N = 5, dislikes = [[1,2],[2,3],[3,4],[4,5],[1,5]]
Output: false
```

 

**Note:**

1. `1 <= N <= 2000`
2. `0 <= dislikes.length <= 10000`
3. `1 <= dislikes[i][j] <= N`
4. `dislikes[i][0] < dislikes[i][1]`
5. There does not exist `i != j` for which `dislikes[i] == dislikes[j]`.

---

又是一道图的题目，而且和昨天的题目思路是一样的，先遍历染色，然后再判断是否满足即可。

这里有些不同的是，这道题给出的输入是边的列表，然后我们需要手动建个图。同时，这道题还可以用在遍历时判断是否已经不符合了，进而可以提前退出。代码如下：

```c++
bool possibleBipartition(int N, vector<vector<int>>& dislikes) {
    vector<vector<int>> graph(N);
    for(int i = 0;i < dislikes.size(); i++) {
        graph[dislikes[i][0]-1].push_back(dislikes[i][1]-1);
        graph[dislikes[i][1]-1].push_back(dislikes[i][0]-1);
    }
    char color = 'b';
    vector<char> visited(N, 'w');
    for(int i = 0;i < N;i++) {
        if (visited[i] == 'w' && dfs(graph, visited ,i, color) == false) {
            return false;
        }
    }
    return true;
}

bool dfs(vector<vector<int>> &graph, vector<char> &visited, int index, char color) {
    visited[index] = color;

    for(int i = 0;i < graph[index].size(); i++) {
        int j = graph[index][i];
        if ((visited[j] == 'w' && !dfs(graph, visited, j, ~color)) || visited[j] == color){
            return false;
        }
    }

    return true;
}
```

