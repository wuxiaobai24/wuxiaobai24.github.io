---
title: Partition Labels
date: 2019-12-06 10:33:53
tags:
- LeetCode
categories: LeetCode
---

> 第30天，一个月了。

今天的题目是[Partition Labels](https://leetcode.com/problems/partition-labels/):

这道题的解法如下：

先遍历一次字符串统计字符出现的次数保存在`c1`上，然后在遍历一次字符串，这次遍历时同样进行统计字符出现次数保存在`c2`上，并维护一个变量`cnum`，这个变量`cnum`表示当前出现过但是未出现完全的字符的种类数。当出现`cnum`为 0 时，就表示完成了一次划分。代码如下：

```c++
vector<int> partitionLabels(string S) {
    vector<int> c1(26, 0);
    for(int i = 0, size = S.size(); i < size; i++) {
        c1[S[i] - 'a']++;
    }
    
    vector<int> c2(26, 0);
    vector<int> res;
    int temp = 1, cnum = 0;
    
    for(int i = 0, size = S.size(); i < size; i++, temp++) {
        int index = S[i] - 'a';
        if (c2[index] == 0) {
            cnum++;
        }
        if (++c2[index]== c1[index] && --cnum == 0) {
            res.push_back(temp); temp = 0;
        }
    }
    return res;
}
```