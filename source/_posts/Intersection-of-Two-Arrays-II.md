---
title: Intersection-of-Two-Arrays-II
date: 2017-12-14 07:57:29
categories: LeetCode
tags:
- LeetCode
---

第78天。

又是`hash`,为什么每次都随机到`hash`.

今天的题目是[Intersection of Two Arrays II](https://leetcode.com/problems/intersection-of-two-arrays-ii/description/):

> Given two arrays, write a function to compute their intersection.
>
> Example:
> Given nums1 = [1, 2, 2, 1], nums2 = [2, 2], return [2, 2].
>
> Note:
> Each element in the result should appear as many times as it shows in both arrays.
> The result can be in any order.
> Follow up:
> What if the given array is already sorted? How would you optimize your algorithm?
> What if nums1's size is small compared to nums2's size? Which algorithm is better?
> What if elements of nums2 are stored on disk, and the memory is limited such that you cannot load all elements into the memory at once?

和昨天的解法有点想,先遍历一个数组，用`hash table`进行计数，然后再遍历第二个数组，然后实时的更新`hash table`就好了：

```c++
vector<int> intersec1t(vector<int>& nums1, vector<int>& nums2) {
    unordered_map<int,int> m;
    for(auto i:nums1) m[i]++;
    vector<int> ret;
    for(auto i:nums2) {
        if (m[i] != 0) {
            ret.push_back(i);
            m[i]--;
        }
    }
    return ret;
}
```

还有就是可以用`sort`来做：

```c++
vector<int> intersect(vector<int>& nums1, vector<int>& nums2) {
    sort(nums1.begin(),nums1.end());
    sort(nums2.begin(),nums2.end());
    int i1,i2;
    vector<int> ret;
    for(i1=0,i2=0;i1 < nums1.size() && i2 < nums2.size();) {
        if (nums1[i1] == nums2[i2]) {
            ret.push_back(nums1[i1]);
            i1++; i2++;
        } else if (nums1[i1] > nums2[i2]) i2++;
        else i1++;
    }
    return ret;
}
```