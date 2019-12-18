---
title: Validate Stack Sequences
date: 2019-12-17 11:52:17
tags:
- LeetCode
categories: LeetCode
---

> 第41天。

今天的题目是[Validate Stack Sequences](https://leetcode.com/problems/validate-stack-sequences/):

简单题，直接模拟就好了：

```c++
bool validateStackSequences(vector<int>& pushed, vector<int>& popped) {
    stack<int> st;
    int i = 0;
    for(auto &t: popped) {
        if (!st.empty() && st.top() == t) {
            st.pop();
        } else {
            while(i < pushed.size() && pushed[i] != t) {
                st.push(pushed[i]);
                i++;
            }
            if (pushed.size() == i) return false;
            i++;
        }
    }
    return true;
}
```
