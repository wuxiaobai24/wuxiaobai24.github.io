---
title: Flipping an Image
date: 2019-12-23 09:52:11
tags:
- LeetCode
categories: LeetCode
---

> 第47天

今天的题目是[Flipping an Image](https://leetcode.com/problems/flipping-an-image/):

考试周，做一道`Easy`题。

```c++
vector<vector<int>> flipAndInvertImage(vector<vector<int>>& A) {
    int t;
    for(auto &v: A) {
        for(int i = 0, j = v.size() - 1;i <= j; i++, j--) {
            t = (v[j]==1) ? 0 : 1;
            v[j] = (v[i]==1) ? 0 : 1;
            v[i] = t;
        }
    }
    return A;
}
```