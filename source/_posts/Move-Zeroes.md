---
title: Move-Zeroes
date: 2017-11-09 08:07:21
categories: LeetCode
tags:
- LeetCode
---

第44天。

今天的题目是[Move Zeroes](https://leetcode.com/problems/move-zeroes/description/):

> Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.
>
> For example, given nums = [0, 1, 0, 3, 12], after calling your function, nums should be [1, 3, 12, 0, 0].
>
> Note:
> You must do this in-place without making a copy of the array.
> Minimize the total number of operations.

这道题目要求我们原地的移动元素，而且还要保持序列本身的顺序。

我们可以利用一下计数排序的思想，反正最后都是`0`,我只要算出有几个`0`要放在最后，我就可以很方便的产生后缀啦，所以这里先遍历一遍序列记录`0`的个数，然后我们发现其实每个元素向前移动多少格是和它前面有多少个`0`有关的,so ：


```c++
void moveZeroes(vector<int>& nums) {
    int zero = 0,size = nums.size(),i,j;
    for(i = 0;i < size;i++) {
        if (nums[i] == 0) zero++;
        else if (zero != 0) nums[i-zero] = nums[i];
    }
    j = size - 1;
    size -= zero;
    while(j >= size) nums[j--] = 0;
}
```

虽然写的不是很优雅的样子，但是这个思路是正确的，还有`dicuss`中的解法也是这个思路。

```c++
void moveZeroes(vector<int>& nums) {
    int j = 0;
    // move all the nonzero elements advance
    for (int i = 0; i < nums.size(); i++) {
        if (nums[i] != 0) {
            nums[j++] = nums[i];
        }
    }
    for (;j < nums.size(); j++) {
        nums[j] = 0;
    }
}
```