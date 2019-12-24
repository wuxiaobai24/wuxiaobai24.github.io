---
title: Maximum Length of Repeated Subarray
date: 2019-12-24 10:41:32
tags:
- LeetCode
categories: LeetCode
---

> 第48天。

今天的题目是[Maximum Length of Repeated Subarray](https://leetcode.com/problems/maximum-length-of-repeated-subarray/):

一道DP的题目，有点像LCS。

我们假定`dp[i, j]`为以`A[i]`结尾和以`B[j]`结尾的最长重合子数组的长度，则：

$$
dp[i, j] = \left\{
    \begin{aligned}
        0 &, & A[i] \neq B[i] \\
        dp[i-1, j-1] + 1 &, & A[i] = B[i]
    \end{aligned}
\right.
$$

然后我们只需要对`dp`求最大值即可得到最长重复子数组的长度：

```c++
int findLength(vector<int>& A, vector<int>& B) {
    int n = A.size();
    if (n == 0) return 0;
    
    vector<int> dp(n+1, 0);
    int res = 0;
    for(int i = 1;i <= n; i++) {
        for(int j = n;j >= 1; j--) {
            dp[j] = (A[i-1] == B[j-1]) ? (dp[j-1] + 1) : 0;
            res = max(dp[j], res);
        }
    }
    
    return res;
}
```