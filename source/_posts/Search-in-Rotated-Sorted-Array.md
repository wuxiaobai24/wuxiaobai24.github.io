---
title: Search-in-Rotated-Sorted-Array
date: 2017-10-09 20:47:01
categories: LeetCode
tags:
- LeetCode
- Search
---

打卡，第16天

失眠的感觉真难受。。。一天都想睡觉，但是却睡不着，sad。

> Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.
>
> (i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).
>
> You are given a target value to search. If found in the array return its index, otherwise return -1.
>
> You may assume no duplicate exists in the array.

在有序的数组中进行查找，显然第一个想到的就是二分查找啦，不过题目给的数组是多了一个限定条件，就是这个数组被`rotated`了，所以，显然直接用二分查找是不行的。

观察`4 5 6 7 0 1 2`，我们可以发现如果我们可以找到`7`这个位置，我们就可以得到两个有序数组，可以进行二分查找，所以一个简单直观的想法就是：

```c++
if (nums[first] > nums[last]) {
    while(last >= 0 && nums[first] > nums[last] && nums[last] < target)
        last--;
    while(first <= last &&  nums[first] > nums[last] && nums[first] > target)
        first++;
}
//binarySearch
```

但是这样的时间复杂度就是`O(n)`了，显然不是我们想要的结果，我们可以对这个转折点进行一次二分查找：

```c++
if(nums[first] > nums[last]) {
    int f= first,l = last;
    //找转折点
    while(f <= l) {
        mid = (f + l)/2;
        if (nums[mid] > nums[mid + 1]) break;
        else if (nums[mid] > nums[first]) f = mid + 1;
        else if (nums[mid] < nums[last]) l = mid;
    }
    if (target > nums[last]) last = mid;
    else if (target < nums[first]) first = mid + 1;
    else if (target == nums[first]) return first;
    else return last;
}
//binary Serarch
```

这样的时间复杂度就是`O(2*logn)`了。

完整代码：

```c++
int search(vector<int>& nums, int target) {
    int first = 0,last = nums.size() - 1;
    int mid;

    if (last < 0) return -1;

    if(nums[first] > nums[last]) {
        int f= first,l = last;
        //找转折点
        while(f <= l) {
            mid = (f + l)/2;
            if (nums[mid] > nums[mid + 1]) break;
            else if (nums[mid] > nums[first]) f = mid + 1;
            else if (nums[mid] < nums[last]) l = mid;
        }
        if (target > nums[last]) last = mid;
        else if (target < nums[first]) first = mid + 1;
        else if (target == nums[first]) return first;
        else return last;
    }
    cout << first << last;
    //binary search
    while(first <= last) {
        int mid = (first + last)/2;
        if (nums[mid] == target) return mid;
        else if (nums[mid] < target) first = mid + 1;
        else last = mid - 1;
    }
    return -1;
}
```

不过显然这不是最优的方法啦，毕竟要`O(2*logn)`,事实上只需要对二分查找进行修改，就可以直接运用了,恩，这是在`dicuss`中看到的方法：

```java
public int search(int[] A, int target) {
    int lo = 0;
    int hi = A.length - 1;
    while (lo < hi) {
        int mid = (lo + hi) / 2;
        if (A[mid] == target) return mid;

        if (A[lo] <= A[mid]) {
            if (target >= A[lo] && target < A[mid]) {
                hi = mid - 1;
            } else {
                lo = mid + 1;
            }
        } else {
            if (target > A[mid] && target <= A[hi]) {
                lo = mid + 1;
            } else {
                hi = mid - 1;
            }
        }
    }
    return A[lo] == target ? lo : -1;
}
```