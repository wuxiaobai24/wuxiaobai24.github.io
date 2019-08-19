---
title: Stone Game
date: 2019-03-13 09:38:05
tags:
- LeetCode
categories:
- LeetCode
---

> 第13天，今天的题目有点有趣，也有点快。

今天的题目是[Stone Game](https://leetcode.com/problems/stone-game/)。

恩，这道题的答案是：

```c++
class Solution {
public:
    bool stoneGame(vector<int>& piles) {
        return true;
    }
};
```

解释如下：

假设有`2n`个石头。

因为`Alex`先选，那么`Alex`可以选第`1`或者`2n`个石头，如果选了`1`，那么`Lee`就只能选择`2`或者`2n`,`Lee`不管选哪个，`Alex`都可以选择一个奇数位的石头，如`3`或`2n-1`,即如果`Alex`先选了`1`,那么他可以让`Lee`一直选到的是偶数位的石头，反之亦然。因此`Alex`只要在开始选择的时候，计算所有石头奇数位之和以及偶数位之和，判断谁大就可以知道怎么选才能胜利了，因此，直接`return true`就好了。