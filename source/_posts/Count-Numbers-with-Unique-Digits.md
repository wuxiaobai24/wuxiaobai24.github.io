---
title: Count-Numbers-with-Unique-Digits
date: 2017-12-06 11:14:01
categories: LeetCode
tags:
- LeetCode
- DP
---

第70天。

今天的题目是[Count Numbers with Unique Digits](https://leetcode.com/problems/count-numbers-with-unique-digits/description/):

> Given a non-negative integer n, count all numbers with unique digits, x, where 0 ≤ x < 10^n.
>
> Example:
> Given n = 2, return 91. (The answer should be the total numbers in the range of 0 ≤ x < 100, excluding [11,22,33,44,55,66,77,88,99])

先解释一下题目，所谓的`unique digits`就是这个数字中不包含相同的数字。

理解到这个的话，我们就从`n=2`开始考虑。

其实只需要一点排列组合的知识就可以发现如果它是个2位数,那么就会有`9*9`,第一个之所以是9，是因为，`0`不能出现在最高位，后面的那个是就是因为他不能和前面那个数字相同。如果是个3位数，那就是`9*9*8`,那个8是因为不能和前面两位出现的数字。

然后其实我们这里只得出来n位数的情况，但是它要的范围是`0 < x < 10^n`。这样的话，如果`n=3`,我们就需要求出1位数的个数、2位数的个数、3位数的个数，然后他们的和就是答案了。

我们可以写成动态规划的形式：

```c++
int countNumbersWithUniqueDigits(int n) {
    int *dp = new int[n+1];
    dp[0] = 1;
    int k = 9;
    int a = 9;
    for(int i = 1;i <= n && a > 0;i++) {
        dp[i] = k + dp[i-1];
        k *= a;
        a--;
    }
    int ret = dp[n];
    delete dp;
    return ret;
}
```