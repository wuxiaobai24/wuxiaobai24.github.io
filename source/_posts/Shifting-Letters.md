---
title: Shifting Letters
date: 2019-11-30 15:05:17
categories: LeetCode
tags:
- LeetCode
---


> 第25天。我决定以后不贴题目了。

今天的题目是[Shifting Letters](https://leetcode.com/problems/shifting-letters/)。


---


混进 Medium 的 Easy 题目，简单的取模和循环就能解决的问题。

代码如下：


```c++
string shiftingLetters(string S, vector<int>& shifts) {
    int temp = 0;
    for(int i = shifts.size() - 1 ; i >= 0; --i) {
        temp = (shifts[i] + temp) % 26;
        S[i] = ((S[i] - 'a') + temp) % 26 + 'a';
        // cout << shifts[i] << endl;
    }
    return S;
}
```
