---
title: Longest-Continuous-Increasing-Subsqeuence
date: 2017-12-04 13:19:31
categories: LeetCode
tags:
- LeetCode
---

第68天。

今天的题目是[Longest Continuous Increasing Subsequence](https://leetcode.com/problems/longest-continuous-increasing-subsequence/description/):

> Given an unsorted array of integers, find the length of longest continuous increasing subsequence (subarra y).
>
> Example 1:
> Input: [1,3,5,4,7]
> Output: 3
> Explanation: The longest continuous increasing subsequence is [1,3,5], its length is 3.
> Even though [1,3,5,7] is also an increasing subsequence, it's not a continuous one where 5 and 7 are separated by 4. 
> Example 2:
> Input: [2,2,2,2,2]
> Output: 1
> Explanation: The longest continuous increasing subsequence is [2], its length is 1.
> Note: Length of the array will not exceed 10,000.

题目比较简单，只需要遍历一遍所有元素，然后每次都比较它和它前面一个元素的大小即可：

```c++
int findLengthOfLCIS(vector<int>& nums) {
    if (nums.size() == 0) return 0;
    int ret = 0;
    int a = 1;
    for(int i = 0;i + 1 < nums.size();i++)
        if (nums[i] < nums[i+1]) a++;
        else {
            ret = max(a,ret);
            a = 1;
        }
    return max(a,ret);
}
```