---
title: Decode String
tags:
  - LeetCode
categories:
  - LeetCode
originContent: ''
toc: false
date: 2019-11-08 20:55:51
---

> 第四天。

今天的题目是[Decode String](https://leetcode.com/problems/decode-string/)：

---

Given an encoded string, return its decoded string.

The encoding rule is: `k[encoded_string]`, where the *encoded_string* inside the square brackets is being repeated exactly *k* times. Note that *k* is guaranteed to be a positive integer.

You may assume that the input string is always valid; No extra white spaces, square brackets are well-formed, etc.

Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, *k*. For example, there won't be input like `3a` or `2[4]`.

**Examples:**

```
s = "3[a]2[bc]", return "aaabcbc".
s = "3[a2[c]]", return "accaccacc".
s = "2[abc]3[cd]ef", return "abcabccdcdcdef".
```

---

比较简单的一道题，先分析一下题目，首先输入的格式是`k[encoded_string]`，要将其扩展成k 个 encoded_string 组成的字符串，我们暂且先不考虑嵌套的情况，我们通过一个简单的状态机就可以解决这个问题：

![有限状态机](http://imagehosting.wuxiaobai24.fun/20191108204429.png)

这个代码写起来也很简单：

```c++
string decodeString(string s) {
    string res;
    string temp;
    int num = 0;
    for(int i = 0, size = s.size(); i < size; i++) {
        if (isdigit(s[i])) {
            num = num * 10 + s[i] - '0';
        } else if (s[i] == '[') {
           	temp = "";
        } else if (s[i] == ']') {
            for(int i = 0;i < num;i++)
            	res += temp;
        } else { // charar
            res.push_back(s[i]);
            num = 0;
        }
    }
    return res;
}
```

如果这道题不需要考虑嵌套问题的话，上面就是正确的答案了。虽然需要处理嵌套的问题，但是其实只需要用栈来模拟多个层次的嵌套即可：

```c++
string decodeString(string s) {
    int num = 0;

    stack<string> sst;
    stack<int> nst;
    nst.push(1);
    sst.push(string());

    for(int i = 0, size = s.size(); i < size; i++) {
        if (isdigit(s[i])) {
            num = num * 10 + s[i] - '0';
        } else if (s[i] == '[') {
            beg = end = i + 1;
            nst.push(num); num = 0;
            sst.push(string());
        } else if (s[i] == ']') {
            string s = sst.top(); sst.pop();
            int n = nst.top(); nst.pop();
            for(int j = 0;j < n;j++) sst.top() += s;
        } else { // char
            sst.top().push_back(s[i]);
        }
    }
    return sst.top();
}
```