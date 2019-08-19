---
title: Array Nesting
date: 2019-03-12 09:55:49
tags:
- LeetCode
categories:
- LeetCode
---

> 第12天。

今天的题目是[565. Array Nesting](https://leetcode.com/problems/array-nesting/)

总感觉这道题是刷过的。这道题的输入是一个由0到 N-1 组成的数组，按照`S[i] = {A[i], A[A[i]], A[A[A[i]]], ... } `的规则，找到`S[i]`最长的长度。

显然按这种走法，这个数组会是由多个环组成的，也就是我们要找出最长那个环的长度，我们只需要简单的去寻找即可，而且一旦我们经过了某个元素，一定不会出现在其他人的环中了，所以我们可以将其赋值为-1表示已经使用过来。

这样，我们的算法就是`O(n)`的复杂度了：

```c++
class Solution {
public:
    int arrayNesting(vector<int>& nums) {
        
        int res = 0;
        for(int i = 0;i < nums.size(); i++) {
            if (nums[i] < 0) continue;
            res = max(res, helper(nums, i));
        }
        return res;
    }
    
    int helper(vector<int> &nums, int index) {
        int c = 0, j = nums[index];
        nums[index] = -1;
        while(j >= 0) {
            int t = nums[j];
            nums[j] = -1;
            j = t;
            c++;
        }
        return c;
    }
};
```