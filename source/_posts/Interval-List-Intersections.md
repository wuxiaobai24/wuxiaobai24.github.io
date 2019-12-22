---
title: Interval List Intersections
date: 2019-12-22 10:31:30
tags:
- LeetCode
categories: LeetCode
---

> 第46天。

今天的题目是[Interval List Intersections](https://leetcode.com/problems/interval-list-intersections/):

挺简单的题目，用两个指针控制就好了：

```c++
vector<vector<int>> intervalIntersection(vector<vector<int>>& A, vector<vector<int>>& B) {
    vector<vector<int>> res;
    int i = 0, j = 0;
    while(i < A.size() && j < B.size()) {
        // check A[i] and B[j]
        int left = max(A[i][0], B[j][0]), right = min(A[i][1], B[j][1]);
        if (left <= right) res.push_back({left, right});
        // update i and j
        if (A[i][1] > B[j][1]) j++;
        else if (A[i][1] < B[j][1]) i++;
        else {
            i++; j++;
        }
    }
    
    return res;
}
```