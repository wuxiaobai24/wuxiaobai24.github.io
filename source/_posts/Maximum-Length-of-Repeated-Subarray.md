---
title: Maximum Length of Repeated Subarray & Edit Distance
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

来多一道[Edit Distance](https://leetcode.com/problems/edit-distance/):

一道hard的题目，一次直接AC了。也是DP的题目，这道题让人觉得麻烦的是，它支持三种操作：

- 插入
- 删除
- 替换

一开始会觉得，插入和删除有点难区分，后来想了想，好像他们的代价是一样的，所以我们可以只用删除，不用插入，所以我们可以来解决这个问题：

`dp[i, j]`为`word1[0..i]`和`word2[0..j]`的编辑距离：

- 如果`word1[i] == word2[j]`的话，`dp[i,j] = dp[i-1, j-1]`，即不需要做任何编辑
- 如果`word1[i] != word2[j]`的话，我们可以尝试删除或替换两种操作
    - 删除`word1[i]`
    - 删除`word2[i]`
    - 替换`word1[i]`或`word2[i]`

则`dp[i, j] = min(dp[i-1, j], dp[i, j-1], dp[i-1, j-1])`

边界条件就是，当`i==0`时，`dp[i, j] = j`,当`j==0`时，`dp[i, j] = i`。

所以我们可以写出动规方程：


$$
dp[i, j] = \left\{
    \begin{aligned}
        i &, & i = 0 \\
        j &, & j = 0 \\
        dp[i-1, j-1] &, & word1[i] = word2[j] \\
        min(dp[i-1, j], dp[i, j-1], dp[i-1, j-1]) &, & A[i] \neq B[i]
    \end{aligned}
\right.
$$

因此，代码如下：

```c++
int minDistance(string word1, string word2) {
    int n1 = word1.size(), n2 = word2.size();
    vector<int> dp(n2 + 1);
    for(int j = 0;j <= n2; j++) {
        dp[j] = j;
    }
    int prev;
    for(int i = 1; i <= n1; i++) {
        prev = dp[0];
        dp[0] = i;
        for(int j = 1;j <= n2; j++) {
            swap(dp[j], prev);
            if (word1[i-1] != word2[j-1]) {
                dp[j] = min(min(dp[j-1], dp[j]), prev) + 1;
            }
        }
    }
    return dp[n2];
}
```