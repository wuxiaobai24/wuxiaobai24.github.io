---
title: Contains-Duplicate-II
date: 2017-12-10 11:22:34
categories: LeetCode
tags:
- LeetCode
- Hash
---

第74天。

今天的题目是[Contains Duplicate II](https://leetcode.com/problems/contains-duplicate-ii/description/):

> Given an array of integers and an integer k, find out whether there are two distinct indices i and j in the array such that nums[i] = nums[j] and the absolute difference between i and j is at most k.

显然这道题目可以用两个循环去实现，但是这样会超时，效率不高。

这里是用`Hash Table`去做的,`key`存储`nums[i]`,`value`存储`i`,这样我们用`O(n)`的时间就可以完成了。

```c++
bool containsNearbyDuplicate(vector<int>& nums, int k) {
    unordered_map<int,int> m;
    for(int i = 0;i < nums.size();i++) {
        if (m.find(nums[i]) != m.end() && m[nums[i]] + k >= i) return true;
        m[nums[i]] = i;
    }
    return false;
}
```

`dicuss`中的做法是用`unordered_set`去做的。

```c++
bool containsNearbyDuplicate(vector<int>& nums, int k)
{
    unordered_set<int> s;

    if (k <= 0) return false;
    if (k >= nums.size()) k = nums.size() - 1;

    for (int i = 0; i < nums.size(); i++)
    {
        if (i > k) s.erase(nums[i - k - 1]);
        if (s.find(nums[i]) != s.end()) return true;
        s.insert(nums[i]);
    }

    return false;
}
```