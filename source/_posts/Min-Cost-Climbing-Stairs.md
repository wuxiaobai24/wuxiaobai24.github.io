---
title: Min-Cost-Climbing-Stairs
date: 2018-01-18 09:47:16
categories: LeetCode
tags:
- LeetCode
- DP
---

第87天。

今天的题目是[Min Cost Climbing Stairs](https://leetcode.com/problems/min-cost-climbing-stairs/description/)：

> On a staircase, the i-th step has some non-negative cost cost[i] assigned (0 indexed).
>
> Once you pay the cost, you can either climb one or two steps. You need to find minimum cost to reach the top of the floor, and you can either start from the step with index 0, or the step with index 1.
>
> Example 1:
> Input: cost = [10, 15, 20]
> Output: 15
> Explanation: Cheapest is start on cost[1], pay that cost and go to the top.
> Example 2:
> Input: cost = [1, 100, 1, 1, 1, 100, 1, 1, 100, 1]
> Output: 6
> Explanation: Cheapest is start on cost[0], and only step on 1s, skipping cost[3].
> Note:
> cost will have a length in the range [2, 1000].
> Every cost[i] will be an integer in the range [0, 999].

比较简单的动态规划题，emmm，爬楼梯的升级：

```c++
int minCostClimbingStairs(vector<int>& cost) {
    cost.push_back(0);
    int n = cost.size();
    vector<int> dp(n+2,0);
    for(int i = 2;i < n+2;i++) {
        dp[i] = min(dp[i-1],dp[i-2]) + cost[i-2];
    }
    return dp[n+1];
}
```

可以做一些简化:

```c++
int minCostClimbingStairs(vector<int>& cost) {
    int n = cost.size();
    vector<int> dp(n,0);
    dp[0] = cost[0];
    dp[1] = cost[1];
    for(int i = 0;i < n;i++) {
        dp[i] = min(dp[i-1],dp[i-2]) + cost[i];
    }
    return min(dp[n-1],dp[n-2]);
}
```

甚至，如果cost可以修改的话，我们还可以把`dp`也省下来:

```c++
int minCostClimbingStairs(vector<int>& cost) {
    int n = cost.size();
    vector<int> &dp = cost;
    for(int i = 0;i < n;i++) {
        dp[i] = min(dp[i-1],dp[i-2]) + cost[i];
    }
    return min(dp[n-1],dp[n-2]);
}
```