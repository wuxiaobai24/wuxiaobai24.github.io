---
title: Sort Characters By Frequency
date: 2019-11-11 12:23:34
tags:
- LeetCode
categories: LeetCode
---


> 第7天了

今天的题目是[ Sort Characters By Frequency ]( https://leetcode.com/problems/sort-characters-by-frequency/ ):

---

Given a string, sort it in decreasing order based on the frequency of characters.

**Example 1:**

```
Input:
"tree"

Output:
"eert"

Explanation:
'e' appears twice while 'r' and 't' both appear once.
So 'e' must appear before both 'r' and 't'. Therefore "eetr" is also a valid answer.
```



**Example 2:**

```
Input:
"cccaaa"

Output:
"cccaaa"

Explanation:
Both 'c' and 'a' appear three times, so "aaaccc" is also a valid answer.
Note that "cacaca" is incorrect, as the same characters must be together.
```



**Example 3:**

```
Input:
"Aabb"

Output:
"bbAa"

Explanation:
"bbaA" is also a valid answer, but "Aabb" is incorrect.
Note that 'A' and 'a' are treated as two different characters.
```

---

比较简单的一道题，具体解法如下：

1. 计数算频率，用`unordered_map`就搞定了
2. 按频率排序，先把`unoredred_map`转成`vector`，然后再`sort`
3. 生成字符串。

具体代码如下：

```c++
string frequencySort(string s) {
    unordered_map<char, int> cmap;
    for(int i = 0;i < s.size(); i++) cmap[s[i]]++;
    vector<pair<char, int>> pvec(cmap.begin(), cmap.end());
    sort(pvec.begin(), pvec.end(), [](const pair<char, int> &p1, const pair<char, int> &p2) {
        return p1.second > p2.second; 
    });

    string res;
    for(auto it = pvec.begin(); it != pvec.end(); ++it) {
        res += string(it->second, it->first);
    }
    return res;
}
```

因为中途需要把`unordered_map`转成`vector`，所以使用的空间就有点多了（统计数据存了两份），所以我们尝试直接使用`vector`来统计。之所以能直接用`vector`来统计，是因为char类型总共就256个字符而已，所以我们用一个长度为`256`的`vector`即可完成，具体代码如下：

```c++
string frequencySort(string s) {
    vector<pair<char, int> > pvec(256);
    for(int i = 0;i < 256; i++) pvec[i] = make_pair(i, 0);
    for(int i = 0;i < s.size(); i++) {
        pvec[s[i]].second++;
    }

    string res;
    for(auto it = pvec.begin(); it != pvec.end() && it->second; ++it) {
        res += string(it->second, it->first);
    }
    return res;
}
```

