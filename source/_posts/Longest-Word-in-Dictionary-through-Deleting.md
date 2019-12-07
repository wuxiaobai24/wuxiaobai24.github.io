---
title: Longest Word in Dictionary through Deleting
date: 2019-12-07 09:10:19
tags:
- LeetCode
categories: LeetCode
---

> 第31天。

今天的题目是[Longest Word in Dictionary through Deleting](https://leetcode.com/problems/longest-word-in-dictionary-through-deleting/):

很常规的题目。

因为题目要求返回的是最长的字符串，同时如果有多个解的话，就返回字典序最小的那个，所以我们先按要求进行一次排序。然后在 check 一下是否符合即可。代码如下：

```c++
bool check(const string &s, const string &t) {
    int index = 0, i;
    
    for(i = 0; i < t.size(); ++i) {
        while(index < s.size() && s[index] != t[i]) index++;
        if (index == s.size()) break;
        else index++;
    }
    
    return i == t.size();
}
string findLongestWord(string s, vector<string>& d) {
    sort(d.begin(), d.end(),[](const string &s1, const string &s2) {
        if (s1.size() != s2.size()) return s1.size() > s2.size();
        else return s1 < s2;
    });
    
    for(int i = 0;i < d.size(); i++) {
        if (check(s, d[i])) return d[i];
    }
    return "";
}
```