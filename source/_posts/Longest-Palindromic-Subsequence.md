---
title: Longest Palindromic Subsequence
date: 2019-12-03 12:12:04
tags:
- LeetCode
categories: LeetCode
---


> 第27天。

今天的题目是[Longest Palindromic Subsequence](https://leetcode.com/problems/longest-palindromic-subsequence/)：

一道动态规划的问题，我们假定`dp[i, j]`是字符串`S[i:j]`最长回文串的长度。那么我们可以写出如下动规方程：

$$
dp[i, j] = \left\{
\begin{aligned}
dp[i-1, j-1] + 2 & &,s[i] = s[j] \\
max\{d[i-1,j], dp[i, j-1]\} & &,s[i] \neq s[j] 
\end{aligned}
\right.
$$

有了动规方程后，这个问题就简单多了：

```c++
int longestPalindromeSubseq1(string s) {
    int size = s.size();
    vector<vector<int>> dp(size, vector<int>(size, 0));
    for(int i = size - 1;i >= 0; i--) {
        dp[i][i] = 1;
        for(int j = i + 1;j < size;j++) {
            if (s[i] == s[j]) {
                dp[i][j] = dp[i+1][j-1] + 2;
            } else {
                dp[i][j] = max(dp[i+1][j], dp[i][j-1]);
            }
        }
    }
    return dp[0][size-1];
}
```

为了减少空间复杂度，我们可以这样优化：

```c++
int longestPalindromeSubseq(string s) {
    int size = s.size();
    
    vector<int> dp1(size, 0), dp2(size, 0);
    for(int i = size - 1;i >= 0; i--) {
        dp2[i] = 1;
        dp1[i] = 0;
        for(int j = i + 1;j < size;j++) {
            if (s[i] == s[j]) {
                // dp[i][j] = dp[i+1][j-1] + 2;
                dp2[j] = dp1[j-1] + 2;
            } else {
                // dp[i][j] = max(dp[i+1][j], dp[i][j-1]);
                dp2[j] = max(dp1[j], dp2[j-1]);
            }
        }
        
        swap(dp1, dp2);
    }
    return dp1[size-1];
}
```