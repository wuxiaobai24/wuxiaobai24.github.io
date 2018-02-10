---
title: Reverse-String
date: 2017-12-16 19:36:01
categories: LeetCode
tags:
- LeetCode
- String
---

第80天。


今天的题目是[Reverse String](https://leetcode.com/problems/reverse-string/description/):

> Write a function that takes a string as input and returns the string reversed.
>
> Example:
> Given s = "hello", return "olleh".

水的不能再水的题目.

```c++
string reverseString(string s) {
    int i = 0,j = s.size() - 1;
    while(i < j) {
        swap(s[i++],s[j--]);
    }
    return s;
}
```

如果用`python`话：

```python
def reverseString(self, s):
    """
    :type s: str
    :rtype: str
    """
    return s[::-1]
```