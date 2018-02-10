---
title: Remove-Duplicates-from-Sorted-Array
date: 2018-01-15 11:10:38
categories: LeetCode
tags:
- LeetCode
---

第84天。

All right,最终还是在期末考的时候断了。

今天的题目是[Remove Duplicates from Sorted Array](https://leetcode.com/problems/remove-duplicates-from-sorted-array/description/):

> Given a sorted array, remove the duplicates in-place such that each element appear only once and return the new length.
>
> Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.
>
> Example:
>
> Given nums = [1,1,2],
>
> Your function should return length = 2, with the first two elements of nums being 1 and 2 respectively. It doesn't matter what you leave beyond the new length.


明明是道水题，但是还是做了挺久的，而且效率也不高：

```c++
int removeDuplicates1(vector<int>& nums) {
    int size = nums.size();
    for(int i = size - 1;i >= 1;i--) {
        if (nums[i] == nums[i-1]) {
            swap(nums[i],nums[--size]);
        }
    }
    sort(nums.begin(),nums.begin() + size);
    return size;
}
```

说他效率不高的原因就在于最后要做一次排序。

然后是`dicuss`中给出的`O(n)`的解法：

```c++
int removeDuplicates(vector<int>& nums) {
    if (nums.size() <= 1) return nums.size();
    int end = 1;
    for(int i = 1;i < nums.size();i++) {
        if (nums[i] != nums[i-1]) nums[end++] = nums[i];
    }
    return end;
}
```