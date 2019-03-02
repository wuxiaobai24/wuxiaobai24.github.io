---
title: String-to-Integer(atoi)
date: 2019-02-14 21:39:48
tags:
- Leetcode
categories:
- Leetcode
---

> hhh, 开始一天一道LeetCode吧, 恩, 忘记了之前算到第几天了, 那么从头开始吧, 今天是第一天.

今天的题目是(8. String to Integer (atoi))[https://leetcode.com/problems/string-to-integer-atoi/]

题目描述:

Implement atoi which converts a string to an integer.

The function first discards as many whitespace characters as necessary until the first non-whitespace character is found. Then, starting from this character, takes an optional initial plus or minus sign followed by as many numerical digits as possible, and interprets them as a numerical value.

The string can contain additional characters after those that form the integral number, which are ignored and have no effect on the behavior of this function.

If the first sequence of non-whitespace characters in str is not a valid integral number, or if no such sequence exists because either str is empty or it contains only whitespace characters, no conversion is performed.

If no valid conversion could be performed, a zero value is returned.

Note:

- Only the space character ' ' is considered as whitespace character.
- Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−2^31,  2^31 − 1]. If the numerical value is out of the range of representable values, INT_MAX (2^31 − 1) or INT_MIN (−2^31) is returned.

Example 1:

> Input: "42"
> Output: 42

Example 2:

> Input: "   -42"
> Output: -42
> Explanation: The first non-whitespace character is '-', which is the minus sign. Then take as many numerical digits as possible, which gets 42.

Example 3:

> Input: "4193 with words"
> Output: 4193
> Explanation: Conversion stops at digit '3' as the next character is not a numerical digit.

Example 4:

> Input: "words and 987"
> Output: 0
> Explanation: The first non-whitespace character is 'w', which is not a numerical digit or a +/- sign. Therefore no valid conversion could be performed.

Example 5:

> Input: "-91283472332"
> Output: -2147483648
> Explanation: The number "-91283472332" is out of the range of a 32-bit signed integer. Thefore INT_MIN (−231) is returned.

怎么说呢， 这是一道编程題， 而不是算法题， 事实上没用到什么算法， 把逻辑理清楚， 然后注意一下坑就好了。

我们现在来理一理`atoi()`的逻辑：

- 我们要跳过字符串开头的所有空格。
- 第一个非空格字符，只能是`+`, `-`以及`0`到`9`的所以数字。
- 如果第一个非空格字符是`-`， 我们就要返回一个负数。
- 解析字符串中的数字， 直到遇到第一个非数字就结束（或者遍历晚字符串）
- 然后如果在解析数字的时候发现， 如果溢出了， 就直接返回`INT_MAX`或`INT_MIN`(看前面是否有符号)

感觉整个逻辑还是比较好写的， 就只有一个麻烦点：`怎么判断是否溢出了？`

有两个方法：

- 方法一：

    因为`atoi()`只解析32位的有符号整数， 所以我们可以直接用64位的整数来计算结果，这样就可以直接判断是否超出32位的范围了，也就是用`long long`, 但是这样要计算64位的乘法和加法，会比较耗时。

- 方法二：

    直接用32位的整数来计算结果， 在解释这个方法前，我们先看下是如何解析数字的, 解析数字主要就是把单个字符转成数字， 然后通过以下等式来迭代计算结果`res = res * 10 + i;`。可以看到这里有一个乘10的计算，所以我们可以在计算这个等式之前， 用`INT_MAX/10`来判断是否溢出。



```cpp
int myAtoi(string str) {
    int res = 0;
    
    // clear space
    int beg = 0;
    while(beg < str.size()) {
        char c = str[beg];
        if (c == ' ') beg++;
        else if (c == '-' || c == '+'||(c <= '9' && c >= '0')) break;
        else return res;
    }
    
    int sign = 1;
    int max_num = INT_MAX;
    // if we have '+' or '-'
    if (str[beg] == '+') {
        beg++;
    } else if (str[beg] == '-') {
        beg++;
        sign = -1; max_num = INT_MIN;
    }
    
    const int c = INT_MAX/10;
    
    for(;beg < str.size() && str[beg] >= '0' && str[beg] <= '9'; beg++) {
        int i = str[beg]-'0';
        if (res > c || (res == c && i > 7)) return max_num;
        res = res * 10 + i;
    }
    
    return sign*res;
}
```