---
title: Longest String Chain
date: 2019-11-10 11:12:09
tags: 
- LeetCode
categories:
- LeetCode
---

> 第6天。

今天的题目是[Longest String Chain]( https://leetcode.com/problems/longest-string-chain/ )：

---

Given a list of words, each word consists of English lowercase letters.

Let's say `word1` is a predecessor of `word2` if and only if we can add exactly one letter anywhere in `word1` to make it equal to `word2`. For example, `"abc"` is a predecessor of `"abac"`.

A *word chain* is a sequence of words `[word_1, word_2, ..., word_k]` with `k >= 1`, where `word_1` is a predecessor of `word_2`, `word_2` is a predecessor of `word_3`, and so on.

Return the longest possible length of a word chain with words chosen from the given list of `words`.

 

**Example 1:**

```
Input: ["a","b","ba","bca","bda","bdca"]
Output: 4
Explanation: one of the longest word chain is "a","ba","bda","bdca".
```

 

**Note:**

1. `1 <= words.length <= 1000`
2. `1 <= words[i].length <= 16`
3. `words[i]` only consists of English lowercase letters.

---

看到这道题的时候，一开始以为要先转化成图来做，但是感觉好像有点复杂化这个问题了，尝试手动跑了一下样例，发现存在最优子结构，因此我们可以用动态规划来做。动规方程如下：

$$
dp[i] = max(\{dp[j] + 1 | isPredecessor(words[i], words[j]) == true \});
$$

简单解释一下这个方程（可能写的不是很规范），$dp[i]$ 表示以第i 个字符串为结尾的最长`String Chain`的长度。我们可以用第 i 个字符串的所有`Predecessor`的 dp 值最大值再加一得到。

同时，为了加速，我们可以先对原始的字符串序列做一次按长度的排序。这样就很容易找到和当前字符串长度相差1的字符串了，这样我们在找所有`Predecessor`的时候不需要遍历所有数组。

有了动规方程，我们写出这个代码就简单多了，只要按着类似的套路即可。

这样我们代码就只剩下如何判读一个字符串是否是另一个字符串的`Predecessor`，其实这个问题也挺简单的，只要两个循环即可。

```c++
bool isPredecessor(string &s1, string &s2) {
    // check s2 is s1's predecessor

    if (s1.size() != s2.size() + 1) return false;

    int i = 0;
    int len = s2.size();
    for(;i < len  && s1[i] == s2[i]; i++)
        /* pass */;
    for(;i < len && s1[i+1] == s2[i]; i++)
        /* pass */;

    return i == len;
}
int longestStrChain(vector<string>& words) {

    // sort by size
    sort(words.begin(), words.end(), [](const string &s1, const string &s2) {
        return s1.size() < s2.size();
    });

    vector<int> dp(words.size(), 1);
    int beg = 0;
    int res = 0;

    for(int i = 1;i < dp.size(); i++) {
        while(words[beg].size() + 1 < words[i].size()) beg++;

        for(int j = beg; j < i; j++) {
            if (isPredecessor(words[i], words[j])) dp[i] = max(dp[i], dp[j] + 1);
        }

        res = max(dp[i], res);
    }

    return res;
}
```

