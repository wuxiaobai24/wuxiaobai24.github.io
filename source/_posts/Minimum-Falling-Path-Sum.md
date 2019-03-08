---
title: Minimum Falling Path Sum
date: 2019-03-04 08:32:48
tags:
- LeetCode
- 动态规划
categories:
- LeetCode
---

> 第5天，早起刷题的一天。

今天的题目是[Minimum Falling Path Sum](https://leetcode.com/problems/minimum-falling-path-sum/)

一道典型的动态规划题，动态规划的题目一般都可以分为多步走，一旦执行完一步，走下一步时可以利用之前几步的结果来快速的选择下一步要怎么走。

关键就是要找出怎么利用之前几步的结果。

如这里的，我们要知道走到最后一行的最短路径，那么如果我们已经知道了走到倒数第二行（即上一行）的最短路径，我们就可以很快的算出走到最后一行的最短路径，即：

`dp[i][j] = min(dp[i-1][j-1], dp[i][j], dp[i][j+1]) + A[i][j]`

然后很顺手的我们可以用两个数组来优化代码的空间复杂度，即把二维数组转成两个一维数组。

因此代码如下:

```c++
class Solution {
public:
    int minFallingPathSum(vector<vector<int>>& A) {
        int h = A.size(), w;
        if (h == 0) return 0;
        w = A[0].size();
        
        vector<int> dp0 = A[0];
        vector<int> dp1(w, INT_MAX);
        
        for(int i = 1; i < h; i++) {
            for(int j = 0;j < w; j++) {
                dp1[j] = INT_MAX;
                if (j > 0) dp1[j] = min(dp0[j-1], dp1[j]);
                dp1[j] = min(dp0[j], dp1[j]);
                if (j + 1 < w) dp1[j] = min(dp0[j+1], dp1[j]);
                dp1[j] += A[i][j];
                
            }
            swap(dp1, dp0);
        }
        
        int res = INT_MAX;
        for(auto &i: dp0) res = min(res, i);
        return res;
    }
};
```