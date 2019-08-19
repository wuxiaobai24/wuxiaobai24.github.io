---
title: Bitwise ORs of Subarrays
date: 2019-03-11 10:22:12
tags:
- LeetCode
- 动态规划
categories:
- LeetCode
---

> 第11天，今天刷的是一道动态规划的题目。

今天的题目是[Bitwise ORs of Subarrays](https://leetcode.com/problems/bitwise-ors-of-subarrays/):

这道题的时间复杂度很高，我们用个例子来解释解法：

首先输入是`[1, 2, 4]`,我们先看下能不能用`[1, 2]`的答案来推出`[1, 2, 4]`的答案：

`[1, 2]`的答案是`1, 2, 3`如果都与`4`或一下的话，会得到的是`[5, 6, 7]`，而`[1, 2, 4]`的答案中应该是没有`5`的，那么问题出在哪里了呢？如果仔细想一下的话，会发现这里要求的是连续子数组，而以`4`为结尾的连续子数组只有：`[4], [2, 4], [1, 2, 4]`，对它们进行或也就是说其实`1`其实是不会和`4`进行或运算的。

那么要和`4`进行或运算的数组是什么呢？答案是一个空数组和所有以`2`结尾的连续子数组的或运算结果，而进行完或运算后得到的结果就是所有以`4`结尾的或运算结果。

这时候我们就很容易想到解法了：

用一个`set`保存所有以`A[i-1]`结尾的或运算结果，记为`set[i-1]`，然后分别与`A[i]`进行或运算插入到另一个`set`中，并在最后插入一个`A[i]`就可以得到`set[i]`。

故：

```c++
class Solution {
public:
    int subarrayBitwiseORs(vector<int>& A) {
        int len = A.size();
        if (len == 0) return 0;
        
        unordered_set<int> res, cur, cur2;
        for(auto &i: A) {
            cur2 = {i};
            for(auto &j : cur) cur2.insert(i | j);
            cur = cur2;
            for(auto &j: cur) res.insert(j);
        }
        return res.size();
    }
};
```
