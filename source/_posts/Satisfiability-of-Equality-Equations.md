---
title: Satisfiability of Equality Equations
date: 2019-12-28 17:04:19
tags:
- LeetCode
categories: LeetCode
---

> 第51天，考完期末了，hhh。
> 虽然还有一门恶心的Survey没写。

今天的题目是[Satisfiability of Equality Equations](https://leetcode.com/problems/satisfiability-of-equality-equations/):

一道并查集的题目，先遍历一次`==`的式子，建立并查集，然后再遍历一次`!=`的式子，判断`!=`两边的字符是否属于不同的两个集合即可。

```c++
bool equationsPossible(vector<string>& equations) {
    vector<int> imap(26);
    for(int i = 0;i < 26; i++) imap[i] = i;
    for(auto &e: equations) {
        if (e[1] == '!') continue;
        int i1 = e[0] - 'a', i2 = e[3] - 'a';
        while(imap[i1] != i1) i1 = imap[i1];
        while(imap[i2] != i2) i2 = imap[i2];
        imap[i1] = i2;
    }
    
    for(auto &e: equations) {
        if (e[1] == '=') continue;
        int i1 = e[0] - 'a', i2 = e[3] - 'a';
        while(imap[i1] != i1) i1 = imap[i1];
        while(imap[i2] != i2) i2 = imap[i2];
        if (i1 == i2) {
            return false;
        }
    }
    
    return true;
}
```