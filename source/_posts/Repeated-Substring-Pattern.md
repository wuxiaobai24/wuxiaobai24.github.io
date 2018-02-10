---
title: Repeated-Substring-Pattern
date: 2018-01-22 10:54:49
categories: LeetCode
tags:
- LeetCode
---

第91天。

今天的题目是[Repeated Substring Pattern](https://leetcode.com/problems/repeated-substring-pattern/description/):

> Given a non-empty string check if it can be constructed by taking a substring of it and appending multiple copies of the substring together. You may assume the given string consists of lowercase English letters only and its length will not exceed 10000.
> Example 1:
> Input: "abab"
>
> Output: True
>
> Explanation: It's the substring "ab" twice.
> Example 2:
> Input: "aba"
>
> Output: False
> Example 3:
> Input: "abcabcabcabc"
>
> Output: True
>
> Explanation: It's the substring "abc" four times. (And the substring "abcabc" twice.)

一开始没看清，以为只有重复一次的情况，后来发现还可以重复多次，这样的话就不得不多扫描几遍了,有点希尔排序的解法：

```c++
bool repeatedSubstringPattern1(string s) {
    for(int i = 1;i < s.size();i++)
        if (repeatedSubstringPattern(s,i)) return true;
    return false;
}
bool repeatedSubstringPattern(string &s,int p) {
    // cout << p << endl;
    int size = s.size();
    if (size % p) return false;
    for(int i = 0;i < p;i++) {
        for(int j = i+p;j < size;j += p) {
            //cout << s[i] << " " << s[j] << endl;
            if (s[i] != s[j]) return false;
        }
    }
    return true;
}
```

然后是在`dicuss`中的利用`kmp`的解法，但我还是没看懂为什么可以这样做。

```c++
bool repeatedSubstringPattern(string str) {
    int i = 1, j = 0, n = str.size();
    vector<int> dp(n+1,0);
    while( i < str.size() ){
        if( str[i] == str[j] ) dp[++i]=++j;
        else if( j == 0 ) i++;
        else j = dp[j];
    }
    return dp[n]&&dp[n]%(n-dp[n])==0;
}
```