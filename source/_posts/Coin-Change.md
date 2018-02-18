---
title: Coin-Change
date: 2018-02-19 01:57:40
tags:
- LeetCode
- 动态规划
---

第104天。

熬夜写的一道题。。。

今天的题目是[Coin Change](https://leetcode.com/problems/coin-change/description/):

> You are given coins of different denominations and a total amount of money amount. Write a function to compute the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.
>
> Example 1:
> coins = [1, 2, 5], amount = 11
> return 3 (11 = 5 + 5 + 1)
>
> Example 2:
> coins = [2], amount = 3
> return -1.
>
> Note:
> You may assume that you have an infinite number of each kind of coin.

想到动态规划后就简单了,但是容易超时，超时的解法：

```c++
int coinChange(vector<int>& coins, int amount) {
    vector<int> dp(amount+1, INT_MAX);
    for(auto i:coins)
        if (i <= amount) dp[i] = 1;
    dp[0] = 0;
    
    for(int i = 1;i <= amount;i++) {
        for(int j = 0;j < i;j++) {
            if (dp[j] != INT_MAX && dp[i-j] != INT_MAX) 
                dp[i] = min(dp[i], dp[j] + dp[i-j]);
        }
    }
    
    return dp[amount] == INT_MAX?-1:dp[amount];
}
```

这里的复杂度是`O(amount^2)`，当`amount`比较大的时候就跑不动了，修改成`O(n*amount)`后就能`AC`掉了：

```c++
int coinChange(vector<int>& coins, int amount) {
    vector<int> dp(amount+1, INT_MAX);
    
    sort(coins.begin(), coins.end());
    
    for(auto i:coins)
        if (i <= amount) dp[i] = 1;
    dp[0] = 0;
    
    for(int i = 1;i <= amount;i++) {
        for(int j = 0;j < coins.size(); j++) {
            if (coins[j] > i || dp[i - coins[j]] == INT_MAX)
                continue;
            dp[i] = min(dp[i], dp[i - coins[j]] + 1);
        }
    }
    
    return dp[amount] == INT_MAX?-1:dp[amount];
}
```

`dicuss`中的解法类似，但是比较简洁：

```c++
int coinChange(vector<int>& coins, int amount) {
    int Max = amount + 1;
    vector<int> dp(amount + 1, Max);
    dp[0] = 0;
    for (int i = 1; i <= amount; i++) {
        for (int j = 0; j < coins.size(); j++) {
            if (coins[j] <= i) {
                dp[i] = min(dp[i], dp[i - coins[j]] + 1);
            }
        }
    }
    return dp[amount] > amount ? -1 : dp[amount];
}
```