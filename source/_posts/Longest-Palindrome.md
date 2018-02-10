---
title: Longest-Palindrome
date: 2018-01-16 09:28:28
categories: LeetCode
tags:
- LeetCode
---

第85天。

今天的题目是[Longest Palindrome](https://leetcode.com/problems/longest-palindrome/description/):

> Given a string which consists of lowercase or uppercase letters, find the length of the longest palindromes that can be built with those letters.
>
> This is case sensitive, for example "Aa" is not considered a palindrome here.
>
> Note:
> Assume the length of given string will not exceed 1,010.
>
> Example:
>
> Input:
> "abccccdd"
>
> Output:
> 7
>
> Explanation:
> One longest palindrome that can be built is "dccaccd", whose length is 7.

这里有一点比较好玩的就是，他问的是能用这里字母组成的最长回文，所以他给的字符串顺序是不重要的，我们可以先用`unordered_map`先统计各个字母的个数，然后利用这些个数来计算即可。

先考虑回文长度是偶数的情况，一个字母要出现在回文中，就必须保证偶数个字母一起出现，这样的话我们就可以这样来计算了：

```c++
for(auto &p:wcount) ret += (p.second / 2);
    ret *= 2;
```

然后考虑奇数的情况，从它给的示例中我们很容易的发现，奇数的情况就是偶数的情况加一，当然也可能不加一，因为可以字母不够用。所以我们可以写出以下解法：


```c++
int longestPalindrome(string s) {
    unordered_map<char,int> wcount;
    for(auto &c:s) wcount[c]++;
    int ret = 0;
    for(auto &p:wcount) ret += (p.second / 2);
    ret *= 2;
    return (ret < s.size())?ret+1:ret;
}
```

还可以更快一点，把除法和乘法去掉：

```c++
int longestPalindrome(string s) {
    unordered_map<char,int> wcount;
    for(auto &c:s) wcount[c]++;
    int ret = 0;
    for(auto &p:wcount) ret += ((p.second % 2)?p.second-1:p.second);
    return (ret < s.size())?ret+1:ret;
}
```

`dicuss`有一个解法比较有趣，他是通过数出现奇数次的字母来实现的：

```c++
int longestPalindrome(string s) {
    int odds = 0;
    for (char c='A'; c<='z'; c++)
        odds += count(s.begin(), s.end(), c) & 1;
    return s.size() - odds + (odds > 0);
}
```