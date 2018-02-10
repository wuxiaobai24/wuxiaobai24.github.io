---
title: Plus-One
date: 2017-11-28 22:52:56
categories: LeetCode
tags:
- LeetCode
---

第62天。

今天很不在状态啊，明明是课最少的一天，却把那么多事拖到了晚上。

今天的题目是[Plus One](https://leetcode.com/problems/plus-one/discuss/):

> Given a non-negative integer represented as a non-empty array of digits, plus one to the integer.
>
> You may assume the integer do not contain any leading zero, except the number 0 itself.
>
> The digits are stored such that the most significant digit is at the head of the list.

比较简单的一道的题目，就是给你一个数组来表示一个数字，而且又不没有负数什么的，只需要从后往前遍历一遍，对当前元素进行加一再模上10，如果变成了`0`,那么说明有进位，我们继续遍历，如果不是`0`,说明后面的元素都没有改变，直接返回即可。

然后需要考虑的就是`99`这种类型，因为他本来是用两个数字即可表示,但是加一后需要3个数字：

```c++
vector<int> plusOne(vector<int>& digits) {
    for(auto it = digits.rbegin();it != digits.rend();it++) {
        *it = (*it + 1) % 10;
        if (*it != 0) return digits;
    }
    if (*digits.begin() == 0) digits.insert(digits.begin(),1);
    return digits;
}
```