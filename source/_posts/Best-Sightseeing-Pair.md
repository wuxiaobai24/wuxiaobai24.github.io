---
title: Best Sightseeing Pair
date: 2019-12-04 18:58:44
tags:
- LeetCode
categories: LeetCode
---

> 第28天。

今天的题目是[Best Sightseeing Pair](https://leetcode.com/problems/best-sightseeing-pair/):

这道题的关键就是什么时候移动 i 这个下标，我们观察一下这个公式：`A[i] + A[j] + i - j`，转化一下就成了`(A[i] + i) + (A[j] - j)`，因此如果存在两个`i`，即`i1`和`i2`的话，当`A[i1] + i1 > A[i2] + i2`成立时，我们就可以用 `i2`去替代原来的`i1`。至于`j`的话，我们只需要从头到尾遍历一遍即可，同时在穷举`j`的时候，可以顺便穷举出`i`：

```c++
int maxScoreSightseeingPair(vector<int>& A) {
    int size =  A.size();
    int res = 0;
    if (size == 0) return res;
    
    for(int i = 0, j = 1;j < size; j++) {
        res = max(res, A[i] + A[j] + i - j);
        if (A[j] + j > A[i] + i) i = j;
    }
    
    return res;
}
```

我们把式子重写成`A[j] + (A[i] + i - j)`，随着`j++`，`i - j`会减一，如果不改变 `i`的话，`(A[i] + i - j)`相比于之前就只是减一而已，如果要改变的话，`A[i] + i - j = A[j] - 1`,则我们可以将循环简化成：

```c+=
int maxScoreSightseeingPair(vector<int>& A) {
    int size =  A.size();
    int res = 0;
    if (size == 0) return res;
    int cur = 0;
    for(int j = 0;j < size; j++) {
        res = max(res, cur + A[j]);
        cur = max(cur, A[j]) - 1;
    }
    
    return res;
}
```