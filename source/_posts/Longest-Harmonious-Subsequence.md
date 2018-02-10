---
title: Longest-Harmonious-Subsequence
date: 2017-12-13 11:22:16
categories: LeetCode
tags:
- LeetCode
---

第77天。

今天的题目是[Longest Harmonious Subsequence](https://leetcode.com/problems/longest-harmonious-subsequence/description/):

> We define a harmonious array is an array where the difference between its maximum value and its minimum value is exactly 1.
>
> Now, given an integer array, you need to find the length of its longest harmonious subsequence among all its possible subsequences.
>
> Example 1:
> Input: [1,3,2,2,5,2,3,7]
> Output: 5
> Explanation: The longest harmonious subsequence is [3,2,2,2,3].
> Note: The length of the input array will not exceed 20,000.

好像有是一个用`hash`做的题目：

```c++
int findLHS(vector<int>& nums) {
    unordered_map<int,int> m;
    for(int i = 0;i < nums.size();i++)
        m[nums[i]]++;
    int len = 0;
    for(auto &p:m) {
        if (m.count(p.first + 1) > 0)
            len = max(len,p.second + m[p.first + 1]);
    }
    return len;
}
```

`dicuss`中有用`sort`做的：

```c++
int findLHS(vector<int>& nums) {
    sort(nums.begin(),nums.end());
    int len = 0;
    for(int i = 1, start = 0, new_start = 0; i<nums.size(); i++)
    {

        if (nums[i] - nums[start] > 1)
            start = new_start;
        if (nums[i] != nums[i-1])
            new_start = i;
        if(nums[i] - nums[start] == 1)
            len = max(len, i-start+1);
    }
    return len;
}
```