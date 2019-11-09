---
title: Reverse Substrings Between Each Pair of Parentheses
date: 2019-11-09 11:03:51
tags:
- LeetCode
categories: LeetCode
---

> 第5天。

今天的题目是：[Reverse Substrings Between Each Pair of Parentheses](https://leetcode.com/problems/reverse-substrings-between-each-pair-of-parentheses/)：

---

You are given a string `s` that consists of lower case English letters and brackets. 

Reverse the strings in each pair of matching parentheses, starting from the innermost one.

Your result should **not** contain any brackets.

 

**Example 1:**

```
Input: s = "(abcd)"
Output: "dcba"
```

**Example 2:**

```
Input: s = "(u(love)i)"
Output: "iloveu"
Explanation: The substring "love" is reversed first, then the whole string is reversed.
```

**Example 3:**

```
Input: s = "(ed(et(oc))el)"
Output: "leetcode"
Explanation: First, we reverse the substring "oc", then "etco", and finally, the whole string.
```

**Example 4:**

```
Input: s = "a(bcdefghijkl(mno)p)q"
Output: "apmnolkjihgfedcbq"
```

 

**Constraints:**

- `0 <= s.length <= 2000`
- `s` only contains lower case English characters and parentheses.
- It's guaranteed that all parentheses are balanced.

---

很简单的一道题，和昨天那道差不多的思路，都是用栈来解决嵌套问题就好了，甚至比昨天那道题还要简单，所以直接放代码了：

```c++
string reverseParentheses(string s) {
    stack<string> st;
    st.push(string());
    for(int i = 0;i < s.size(); i++) {
        if (s[i] == '(') {
            st.push(string());
        } else if (s[i] == ')') {
            string s = st.top(); st.pop();
            st.top() += string(s.rbegin(), s.rend());
        } else {
            st.top().push_back(s[i]);
        }
    }
    return st.top();
}
```