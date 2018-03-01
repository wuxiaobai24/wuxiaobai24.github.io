---
title: Coin Change 2
date: 2018-03-01 10:30:58
tags:
- LeetCode
---

题目是[Coin Change 2](https://leetcode.com/problems/coin-change-2/description/):

题目描述：


You are given coins of different denominations and a total amount of money. Write a function to compute the number of combinations that make up that amount. You may assume that you have infinite number of each kind of coin.


Note: 
You can assume that

 0 <= amount <= 5000
 1 <= coin <= 5000
 the number of coins is less than 500 
 the answer is guaranteed to fit into signed 32-bit integer



Example 1:

Input: amount = 5, coins = [1, 2, 5]
Output: 4
Explanation: there are four ways to make up the amount:
5=5
5=2+2+1
5=2+1+1+1
5=1+1+1+1+1


Example 2:

Input: amount = 3, coins = [2]
Output: 0
Explanation: the amount of 3 cannot be made up just with coins of 2.


Example 3:

Input: amount = 10, coins = [10] 
Output: 1



求解思路：

又是一道动态规划的题目，最近不知道为什么，老是把问题想的太过于复杂，比如`change1`中的解法，就是不好的方法，时间复杂度是`O(amount*amount*size)`.

然后看了一下`dicuss`才知道还有时间复杂度更小的解法（其实就是最内层的循环是没必要的），然后是对空间复杂度进行了一下优化。

```cpp
class Solution {
public:
    int change1(int amount, vector<int>& coins) {
        int size = coins.size();
        if (amount == 0) return 1;
        if (size == 0) return 0;
        
        vector<vector<int>> dp(size + 1, vector<int>(amount + 1, 0));
       
        dp[0][0] = 1;
        for(int i = 1;i <= size;i++) {
            dp[i][0] = 1;
            for(int j = 1;j <= amount;j++)
                for(int t = j;t >= 0;t-=coins[i-1])
                    dp[i][j] += dp[i-1][t];
        }

        return dp[size][amount];
    }
    
    int change2(int amount, vector<int>& coins) {
        int size = coins.size();
        if (amount == 0) return 1;
        if (size == 0) return 0;
        
        vector<vector<int>> dp(size + 1, vector<int>(amount + 1, 0));
       
        dp[0][0] = 1;
        for(int i = 1;i <= size;i++) {
            dp[i][0] = 1;
            for(int j = 1;j <= amount;j++) {
                dp[i][j] = dp[i-1][j];
                if (coins[i-1] <= j)
                    dp[i][j] += dp[i][j-coins[i-1]];
            }
            
        }

        return dp[size][amount];
    }
    
    int change(int amount, vector<int>& coins) {
        int size = coins.size();
        if (amount == 0) return 1;
        if (size == 0) return 0;
        
        vector<int> dp(amount + 1, 0);
        dp[0]  = 1;
        
        for(auto &coin:coins)
            for(int j = 1;j <= amount;j++)
                if (coin <= j)
                    dp[j] += dp[j-coin];
           

        return dp[amount];
    }
    
};
```
