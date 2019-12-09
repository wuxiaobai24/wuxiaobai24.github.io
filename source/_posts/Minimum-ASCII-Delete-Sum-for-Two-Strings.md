---
title: Minimum ASCII Delete Sum for Two Strings
date: 2019-12-09 17:17:49
tags:
- LeetCode
categories: LeetCode
---

> 第33天。

今天的题目是[Minimum ASCII Delete Sum for Two Strings](https://leetcode.com/problems/minimum-ascii-delete-sum-for-two-strings/):

一道动态规划的问题，而且挺常规的。这道题的动规方程如下：

$$
dp[i, j] = \left\{
\begin{aligned}
    \sum_{k=0}^{j} s2[k] & ,& i == 0 \\
    \sum_{k=0}^{i} s1[k] & ,& j == 0 \\
    dp[i-1, j-1] & ,& s1[i] == s2[j] \\
    min\{dp[i-1][j] + s1[i], dp[i][j-1] + s2[j]  \} & ,& s1[i] == s2[j] 
\end{aligned}
\right.
$$

其中`d[i, j]`表示字符串`s1[0, i)`和字符串`s2[0, j)`的最小删除ASCII之和。根据动规方程可以写出如下代码：

```c++
int minimumDeleteSum(string s1, string s2) {

    vector<int> dp(s2.size() + 1);
    dp[0] = 0;
    for(int i = 1;i < dp.size(); i++) {
        dp[i] = dp[i-1] + s2[i-1];
    }
    
    int prev;
    for(int i = 0;i < s1.size(); i++) {
        prev = dp[0];
        dp[0] += s1[i];
        for(int j = 1;j <= s2.size(); j++) {
            if (s1[i] == s2[j-1]) {
                swap(prev, dp[j]);
            } else {
                prev = dp[j];
                dp[j] = min(dp[j] + s1[i], dp[j-1] + s2[j-1]);
            }
        }
    }
    
    return dp[s2.size()];
}
```