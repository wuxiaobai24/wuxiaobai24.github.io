---
title: Intersection-of-Two-Arrays
date: 2017-12-18 13:00:24
categories: LeetCode
tags:
- LeetCode
---

第82天。

今天的题目是[Intersection of Two Arrays](https://leetcode.com/problems/intersection-of-two-arrays/description/):

> Given two arrays, write a function to compute their intersection.
>
> Example:
> Given nums1 = [1, 2, 2, 1], nums2 = [2, 2], return [2].
>
> Note:
> Each element in the result must be unique.
> The result can be in any order.

可以用排序做，也可以用`hash`做：

排序的做法：

```c++
vector<int> intersection(vector<int>& nums1, vector<int>& nums2) {
    sort(nums1.begin(),nums1.end());
    sort(nums2.begin(),nums2.end());
    auto beg1 = nums1.begin();
    auto beg2 = nums2.begin();
    vector<int> ret;
    while(beg1 < nums1.end() && beg2 < nums2.end()) {
        if (*beg1 == *beg2) {
            int t  = *beg1;
            ret.push_back(t);
            while(beg1 < nums1.end() && *beg1 == t) beg1++;
            while(beg2 < nums2.end() && *beg2 == t) beg2++;
        } else if (*beg1 < *beg2) beg1++;
        else beg2++;
    }
    return ret;
}
```

`hash`的做法：

```c++
vector<int> intersection1(vector<int>& nums1, vector<int>& nums2) {
    unordered_map<int,int> m;
    vector<int> ret;
    for(auto i:nums1) m[i]++;
    for(auto i:nums2) 
        if (m.find(i) != m.end() && m[i]) {
            m[i] = 0;
            ret.push_back(i);
        }
    return ret;
}
```

`dicuss`还有用`set`做的:

```c++
vector<int> intersection(vector<int>& nums1, vector<int>& nums2) {
    set<int> s(nums1.begin(), nums1.end());
    vector<int> out;
    for (int x : nums2)
        if (s.erase(x))
            out.push_back(x);
    return out;
}
```