---
title: Delete Operation for Two Strings
date: 2018-02-21 15:11:06
tags:
- LeetCode
---

第106天。

今天的题目是[Delete Operation for Two Strings](https://leetcode.com/problems/delete-operation-for-two-strings/description/):

题目描述：


Given two words word1 and word2, find the minimum number of steps required to make word1 and word2 the same, where in each step you can delete one character in either string.


Example 1:

Input: "sea", "eat"
Output: 2
Explanation: You need one step to make "sea" to "ea" and another step to make "eat" to "ea".



Note:

The length of given words won't exceed 500.
Characters in given words can only be lower-case letters.



求解思路：

这道题和数据结构的最后一道附加题有点像，好像是附加题的操作是改变，而这里的是删除，然后当时的解法在这道题上`AC`尴尬，果然当时最后一题还是写错了吗，我就说为什么没拿到`A+`嘛。

思路比较简单（毕竟是考试的时候都能想出来的方法），只要知道最长公共子串就好了。拿题目给出的例子来说`sea`和`eat`的`LCS`是`ea`这样只要删掉`s`和`t`即可达到相同，有趣的是`LSC`是算法课讲动态规划时讲的。


```cpp
class Solution {
public:
    int minDistance(string word1, string word2) {
        int l = LCS(word1, word2);
        return word1.size() + word2.size()  - l - l;
    }
    int LCS(string &s1, string &s2) {
        
        vector<vector<int>> dp(s1.size() + 1, vector<int>(s2.size() + 1, 0));
        
        for(int i = 1;i < dp.size();i++) {
            for(int j = 1;j < dp[0].size(); j++) {
                if (s1[i-1] == s2[j-1]) dp[i][j] = dp[i-1][j-1] + 1;
                else dp[i][j] = max(dp[i-1][j], dp[i][j-1]);
            }
        }
        
        return dp[s1.size()][s2.size()];
    }
};
```
