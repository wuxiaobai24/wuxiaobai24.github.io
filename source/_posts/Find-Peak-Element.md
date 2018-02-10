---
title: Find-Peak-Element
date: 2017-12-08 09:37:52
categories: LeetCode
tags:
- LeetCode
---

第72天。

今天的题目是[Find Peak Element](https://leetcode.com/problems/find-peak-element/description/):

> A peak element is an element that is greater than its neighbors.
>
> Given an input array where num[i] ≠ num[i+1], find a peak element and return its index.
>
> The array may contain multiple peaks, in that case return the index to any one of the peaks is fine.
>
> You may imagine that num[-1] = num[n] = -∞.
>
> For example, in array [1, 2, 3, 1], 3 is a peak element and your function should return the index number 2.

显然这道题写出一个`O(n)`的解法很简单。

这里的用二分法去求解，可以用`O(logn)`解出，`分`和`合`两个步骤都是`O(1)`的时间复杂度。

```c++
int findPeakElement(vector<int>& nums) {
    return findPeakElement(nums,0,nums.size() - 1);
}
int findPeakElement1(vector<int> &nums,int first,int last) {
    if (first > last) return -1;
    int mid = (first + last)/2;
    int a = 0;
    if ( (mid+1 == nums.size() || nums[mid] > nums[mid + 1]) &&
            (mid-1 < 0 || nums[mid] > nums[mid-1]) )
        return mid;
    int left = findPeakElement(nums,first,mid-1);
    if (left != -1) return left;
    return findPeakElement(nums,mid+1,last);
}
```

当然这不是最好的解法，这里其实是用二分查找去做的：

```c++
int findPeakElement(const vector<int> &num) {
    return Helper(num, 0, num.size()-1);
}
int Helper(const vector<int> &num, int low, int high){
    if(low == high)
        return low;
    else
    {
        int mid1 = (low+high)/2;
        int mid2 = mid1+1;
        if(num[mid1] > num[mid2])
            return Helper(num, low, mid1);
        else
            return Helper(num, mid2, high);
    }
}
```

或者

```c++
int findPeakElement(const vector<int> &num) 
{
    int low = 0;
    int high = num.size()-1;

    while(low < high)
    {
        int mid1 = (low+high)/2;
        int mid2 = mid1+1;
        if(num[mid1] < num[mid2])
            low = mid2;
        else
            high = mid1;
    }
    return low;
}
```