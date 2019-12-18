---
title: Largest Sum of Averages
date: 2019-12-15 11:19:51
tags:
- LeetCode
categories: LeetCode
---

> 第39天。

今天的题目是[Largest Sum of Averages](https://leetcode.com/problems/largest-sum-of-averages/):

一道动态规划的题目，有点想切钢管的问题。

动规方程如下：

$$
dp[i, j] = \left\{
    \begin{aligned}
        \sum_{z=0}^j A[z] & & i = 1\\
        \underset{ {i-1 \leq t \leq n-1} }{max} \{ dp[i-1, t] + \frac {\sum_{z=t+1}^n A[z]} {n-t+1}  \} & & others
    \end{aligned}
\right.
$$

```c++
double largestSumOfAverages(vector<int>& A, int K) {
    // vector<vector<double>> dp(K + 1, vector<double>(A.size(), 0));
    vector<double> dp(A.size(), 0);
    double sum = 0;
    int count;
    for(int j = 0;j < A.size(); j++) {
        sum += A[j];
        dp[j] = sum / (j + 1);
    }
    for(int i = 1;i < K; i++) {
        for(int j = A.size() - 1;j >= i; j--) {
            sum = 0;
            count = 0;
            for(int t = j;t >= i; t--) {
                sum += A[t];
                count++;
                dp[j] = max(dp[j], dp[t-1] + sum/count);
            }
        }
    }
    return dp[A.size()-1];
}
```