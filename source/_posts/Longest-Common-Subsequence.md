---
title: Longest Common Subsequence
date: 2019-11-27 22:57:33
tags:
- LeetCode
categories: LeetCode
---

> 第23天。

今天的题目是[ Longest Common Subsequence ]( https://leetcode.com/problems/longest-common-subsequence/ ):

---

Given two strings `text1` and `text2`, return the length of their longest common subsequence.

A *subsequence* of a string is a new string generated from the original string with some characters(can be none) deleted without changing the relative order of the remaining characters. (eg, "ace" is a subsequence of "abcde" while "aec" is not). A *common subsequence* of two strings is a subsequence that is common to both strings.

 

If there is no common subsequence, return 0.

 

**Example 1:**

```
Input: text1 = "abcde", text2 = "ace" 
Output: 3  
Explanation: The longest common subsequence is "ace" and its length is 3.
```

**Example 2:**

```
Input: text1 = "abc", text2 = "abc"
Output: 3
Explanation: The longest common subsequence is "abc" and its length is 3.
```

**Example 3:**

```
Input: text1 = "abc", text2 = "def"
Output: 0
Explanation: There is no such common subsequence, so the result is 0.
```

 

**Constraints:**

- `1 <= text1.length <= 1000`
- `1 <= text2.length <= 1000`
- The input strings consist of lowercase English characters only.

---

这是一道比较经典的动态规划问题吧，它的动规方程为：
$$
\begin{equation}
LCS(i,j) = \left\{
\begin{array}{rcl}

 & LCS[i-1, j-1] + 1 & ,{s1[i] = s2[j]} \\
& max(LCS[i, j-1], LCS[i-1, j]) & ,{s1[i] \neq s2[j]}

\end{array}
\right.
\end{equation}
$$
根据动规方程我们可以写出如下代码：

```c++
int longestCommonSubsequence(string text1, string text2) {
    vector<vector<int>> dp(text1.size() + 1, vector<int>(text2.size() + 1, 0));
    for(int i = 1;i < dp.size(); i++) {
        for(int j = 1;j < dp[0].size(); j++) {
            if (text1[i-1] == text2[j-1]) {
                dp[i][j] = dp[i-1][j-1] + 1;
            } else {
                dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
            }
        }
    }
    return dp[text1.size()][text2.size()];
}
```

这里的空间复杂度可以继续进行优化，因为`LCS[i,j]`只与当前行和上一行有关系，所以可以优化成两个数组来做：

```c++
int longestCommonSubsequence(string text1, string text2) {

    int n = text1.size() + 1, m = text2.size() + 1;
    vector<int> dp1(m, 0);
    vector<int> dp2(m);

    for(int i = 1;i < n; i++) {
        dp1[0] = 0;
        for(int j = 1;j < m; j++) {
            if (text1[i-1] == text2[j-1]) {
                dp2[j] = dp1[j-1] + 1;
            } else {
                dp2[j] = max(dp1[j], dp2[j-1]);
            }
        }
        swap(dp1, dp2);
    }
    return dp1[m-1];
}
```

再进一步的话，我们可以发现`dp[i][j]`只与 `dp[i-1][j-1]`，`dp[i-1][j]`，`dp[i][j-1]` 相关，如果我们只用一个数组的话，`dp[i][j]`与`dp[i-1][j]`其实存在同一个位置，而`dp[i][j-1]`是在同一行，所以我们只需要维护一个`prev`变量来保存`dp[i-1][j-1]`的值即可：

```c++
int longestCommonSubsequence(string text1, string text2) {
    int n = text1.size(), m = text2.size() + 1;
    vector<int> dp(m, 0);
    
    for(int i = 0;i < n; i++) {
        int prev = 0;
        for(int j = 1;j < m; j++) {
            int temp = prev;
            prev = dp[j];
            dp[j] = (text1[i] == text2[j-1]) ? (temp + 1) : (max(dp[j], dp[j-1]));
        }
    }
    return dp[m-1];
}
```

