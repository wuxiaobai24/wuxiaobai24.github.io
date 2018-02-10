---
title: Remove-Element
date: 2017-12-17 10:54:14
categories: LeetCode
tags:
- LeetCode
---

第81天。

今天的题目是[Remove Element](https://leetcode.com/problems/remove-element/description/):

> Given an array and a value, remove all instances of that value in-place and return the new length.
>
> Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.
>
> The order of elements can be changed. It doesn't matter what you leave beyond the new length.
>
> Example:
>
> Given nums = [3,2,2,3], val = 3,
>
> Your function should return length = 2, with the first two elements of nums being 2.

简单的我们可以遍历数组，然后找到和`val`相同的元素，然后删除，但是这样对于多个相同的元素效率不高，所以我们先不删除元素，而是把他移动到最后面去，知道遍历完才删除。

```c++
int removeElement(vector<int>& nums, int val) {
    int last = nums.size();
    for(int i = 0;i < last;i++) {
        if (nums[i] == val) swap(nums[--last],nums[i--]);
    }
    nums.erase(nums.begin() + last,nums.end());
    return nums.size();
}
```

`dicuss`中另一个方法也很精妙：

```c
int removeElement(int A[], int n, int elem) {
    int begin=0;
    for(int i=0;i<n;i++) if(A[i]!=elem) A[begin++]=A[i];
    return begin;
}
```