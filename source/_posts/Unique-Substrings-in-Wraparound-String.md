---
title: Unique Substrings in Wraparound String
date: 2019-12-14 10:53:43
tags:
- LeetCode
categories: LeetCode
---

> 第38天。

今天的题目是[Unique Substrings in Wraparound String](https://leetcode.com/problems/unique-substrings-in-wraparound-string/):

这道题麻烦的地方在于，子串需要去除重复。我们把问题转换一下，即以字符 c 结尾的子串的个数。不难发现，最长长度和子串个数是相同的。这样的话，我们可以在遍历时维护一个变量`len`来保存，以当前字符结尾的子串的长度，通过判断当前字符与上一个字符是否在`s`中相邻，来确定以当期字符结尾的子串的个数。同时，为了去除重复，我们可以用一个长度为26的字典来保存每个以字符 c 结尾的子串的最长长度。最后，我们只需要对字典进行一次求和即可。

```c++
int findSubstringInWraproundString(string p) {
    if (p.size() == 0) return 0;
    
    vector<int> dict(26, 0);
    int len = 1;
    int prev = p[0] - 'a';
    dict[prev] = 1;
    
    for(int i = 1;i < p.size();i++) {
        int temp = p[i] - 'a';
        if ((prev + 1) % 26 == temp) {
            dict[temp] = max(++len, dict[temp]);
        } else { len = 1; dict[temp] = max(dict[temp], 1); }
        prev = temp;
    }
    
    // sum
    int res = 0;
    for(auto i: dict) res += i;
    return res;
}
```
