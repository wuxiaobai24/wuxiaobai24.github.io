---
title: Palindromic-SubStrings
date: 2018-03-05 09:51:59
tags:
- LeetCode
---

今天的题目是[Palindromic Substrings](https://leetcode.com/problems/palindromic-substrings/description/):

Given a string, your task is to count how many palindromic substrings in this string.

The substrings with different start indexes or end indexes are counted as different substrings even they consist of same characters.

Example 1:
Input: "abc"
Output: 3
Explanation: Three palindromic strings: "a", "b", "c".
Example 2:
Input: "aaa"
Output: 6
Explanation: Six palindromic strings: "a", "a", "a", "aa", "aa", "aaa".
Note:
The input string length won't exceed 1000.

主要思路：

很敏感的想到了动态规划，比如说我们现在想要知道`aabaa`是不是回文，如果我们已经求出来`aba`是回文，那么我就可以之间判断第一个字符和最后一个字符是否相等即可，还有一点就是如果要判断的字符串的长度为1或0，显然就可以之间返回为是字符串啦。

所以我们可以写出动规方程：

dp[first][last] = (dp[first+1][last-1] || last-first-2 <= 0) && s[first] == s[last];

```c++
class Solution {
public:
    int countSubstrings(string s) {
        int size = s.size();
        vector<vector<bool>> dp(size,vector<bool>(size,false));
        int res = 0;
        for(int i = size-1; i >= 0; i--) {
            for(int j = i;j < size;j++) {
                dp[i][j] = s[i] == s[j] && (j-i-2 <= 0 || dp[i+1][j-1]);
                res += dp[i][j];
            }
        }
        return res;
    }
};
```