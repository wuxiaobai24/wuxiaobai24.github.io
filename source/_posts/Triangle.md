---
title: Triangle
date: 2019-11-20 12:15:06
tags: 
- LeetCode
categories: LeetCode
---

> 第16天。

今天的题目是[ Triangle ]( https://leetcode.com/problems/triangle/ )：

---

Given a triangle, find the minimum path sum from top to bottom. Each step you may move to adjacent numbers on the row below.

For example, given the following triangle

```
[
     [2],
    [3,4],
   [6,5,7],
  [4,1,8,3]
]
```

The minimum path sum from top to bottom is `11` (i.e., **2** + **3** + **5** + **1** = 11).

**Note:**

Bonus point if you are able to do this using only *O*(*n*) extra space, where *n* is the total number of rows in the triangle.

---

一道很常规的动态规划问题。

虽然例子中画出来的数组看起来很难确定路径，但是如果把它规整一下就可以得到：

```
2
3 4
6 5 7
4 1 8 3
```

因此对于位置`(i,j)`来说，到达它的路径一定经过上一层的`(i-1, j)`和`(i-1,j-1)`（注意其实triangle中必须保证`0<=j<=i`，那个位置才会有值)。

所以我们可以写出动态规划方程：

$$
dp[i, j]=min\{dp[i-1, j], dp[i-1, j-1] \} + triangle[i][j]
$$

其中`dp[i,j]`表示从顶端出发到达第`i`层第`j`个位置的最短路径的距离。其中`dp[0,0]=triangle[0]`以及`dp[i,j]=INT_MAX,i<j`，根据动态规划方程我们可以很容易的写出代码，同时为了使得空间复杂度为`O(n)`，我们可以只使用一个长度为`n`的数组来保存，之所以能做到是因为`d[i, *]`只依赖于`d[i-1, *]`，进一步的说，它只依赖于`d[i-1, *-1]`和`d[i-1, *]`，所以可以很容易改成一个用一个一维数组实现：

```c++
int minimumTotal(vector<vector<int>>& triangle) {
    int n = triangle.size();
    if (n == 0) return 0;
    vector<int> dp(n, INT_MAX);
    dp[0] = triangle[0][0];
    for(int i = 1;i < n;i++) {
        for(int j = i;j >= 0;j--) {
            dp[j] = min(dp[j], j>0?dp[j-1]:INT_MAX) + triangle[i][j];
            // cout << dp[j] << " ";
        }
        // cout << endl;
    }

    int res = INT_MAX;
    for(int i = 0;i < n;i++) res = min(res, dp[i]);
    return res;
}
```

