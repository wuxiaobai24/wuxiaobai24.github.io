---
title: Search for a Range
date: 2017-10-11 12:42:31
categories: LeetCode
tags:
- LeetCode
- 查找
---

第18天！！！

又是一道二分查找的题目：

> Given an array of integers sorted in ascending order, find the starting and ending position of a given target value.
>
> Your algorithm's runtime complexity must be in the order of O(log n).
>
> If the target is not found in the array, return [-1, -1].
>
> For example,
> Given [5, 7, 7, 8, 8, 10] and target value 8,
> return [3, 4].

时间复杂度要求为`O(logn)`,直接就暗示我们要用二分查找去做啊，但是这个又有限定条件，就是它需要求出范围，自然而然的就想到先用二分查找，然后从找到的点向两边去寻找边界。

相当简单的方法，但是如果遇到`1,2,2,2,2,2,2,2,3`这样的序列，就变成了`O(n)`的时间复杂度。

然后就可以自然而然的想到，做多两次二分查找,在序列`nums[0:mid]`中寻找左边界，`nums[mid:]`中寻找右边界，不然如果要是用二分查找的方法去做的话，就需要转换一下，我们找左边界的前一个元素，右边界的后一个元素，这样会方便一点。

```c++
vector<int> searchRange1(vector<int>& nums, int target) {
    int first = 0,last = nums.size() - 1,mid;
    vector<int> ret{-1,-1};
    while(first <= last) {
        mid = (first + last)/2;
        if (nums[mid] == target){
            break;
        } 
        else if (nums[mid] < target) first = mid+1;
        else last = mid - 1;
    }

    int l = mid,f = mid;
    ret[0] = first;
    ret[1] = last;

    while(first <= l) {
        int m = (first + l)/2;
        if (nums[m] == nums[mid])
            l = m - 1;
        else if (nums[m+1] != nums[mid]) first = m + 1;
        else {
            ret[0] = m+1;
            break;
        }
    }
    while(f <= last) {
        int m = (f + last)/2;
        if (nums[m] == nums[mid]) f = m + 1;
        else if (nums[m-1] != nums[mid]) last = m - 1;
        else {
            ret[1] = m - 1;
            break;
        }
    }

    return ret;
}
```

这个思路很简单，也很好实现，就是代码会复杂一点，三个循环其实长得差不多，但是你不能合并起来，所以换一种思路尝试一下：

我们找到一个与`target`相等的值`nums[mid]`，我们对`nums[0,mid-1]`再进行一次二分查找：

* 如果查找失败， 那么说明当前mid就是左边界
* 如果找到了，我们就更新mid，再对`nums[0:mid-1]`进行查找，直到查找失败。

对右边界做同样的事，我们就得到答案了。

```c++
vector<int> searchRange(vector<int>& nums, int target) {
    vector<int> ret{-1,-1};
    int mid = nums.size();
    while( (mid = searchRangeIter(nums,0,mid-1,target) ) != -1) 
        ret[0] = mid;
    //mid = -1;
    while( (mid = searchRangeIter(nums,mid+1,nums.size() - 1,target)) != -1)
        ret[1] = mid;
    return ret;
}
int searchRangeIter(vector<int> nums,int first,int last,int target) {
    while(first <= last) {
        int mid = (first + last)/2;
        if (nums[mid] == target){
            return mid;  
        } 
        else if (nums[mid] < target) first = mid+1;
        else last = mid - 1;
    }
    return -1;
}
```


在`dicuss`中看到一个更简洁的迭代的方法：

```c++
vector<int> searchRange(int A[], int n, int target) {
    int i = 0, j = n - 1;
    vector<int> ret(2, -1);
    // Search for the left one
    while (i < j)
    {
        int mid = (i + j) /2;
        if (A[mid] < target) i = mid + 1;
        else j = mid;
    }
    if (A[i]!=target) return ret;
    else ret[0] = i;

    // Search for the right one
    j = n-1;  // We don't have to set i to 0 the second time.
    while (i < j)
    {
        int mid = (i + j) /2 + 1;// Make mid biased to the right
        if (A[mid] > target) j = mid - 1;
        else i = mid;// So that this won't make the search range stuck.
    }
    ret[1] = j;
    return ret;
}
```