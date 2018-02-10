---
title: 3Sum
date: 2017-09-20:12
categories: LeetCode
tags:
- LeetCode
---

# 3Sum

觉得立个`flag`：从今天开始每天在LeetCode刷一道题,今天的是[3Sum](https://leetcode.com/problems/3sum/description/)

题目：

> Given an array S of n integers, are there elements a, b, c in S such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.

> Note: The solution set must not contain duplicate triplets.

> For example, given array S = [-1, 0, 1, 2, -1, -4],

> A solution set is:
[
  [-1, 0, 1],
  [-1, -1, 2]
]

这个题的坑点有几个：

- 它要求的是不同的，但是如果处理的不好的话，是很容易出现相同的。
- 第二个是他很容易写出一个O(n^3)的算法，但是好像是跑不过去的。

接近的大概思路是：

- 先对数组进行排序，这样比较好解决第一个坑点
- 把他转换成2Sum去做

```c++
vector<vector<int>> threeSum(vector<int>& nums) {
        vector<vector<int> > ret;
        sort(nums.begin(),nums.end());      //先进行排序

        for(int i = 0; i < nums.size() - 2;i++) {
            int target = -nums[i];          //转换成求2Sum
            if (target < 0) break;
            int beg = i + 1;
            int end = nums.size() - 1;
            while(beg < end) {
                int sum = nums[beg] + nums[end];
                if (sum < target)
                    beg++;
                else if (sum > target)
                    end--;
                else {
                    int n1 = nums[beg];
                    int n2 = nums[end];
                    ret.push_back( {nums[i],nums[beg],nums[end]} );
                    //处理重复
                    while(beg < end && nums[beg] == n1) beg++;
                    while(beg < end && nums[end] == n2) end--;
                }
            }
            //处理重复
            while(i + 1 < nums.size()- 2 && nums[i + 1] == nums[i])
                i++;
        }

        return ret;
    }
```
