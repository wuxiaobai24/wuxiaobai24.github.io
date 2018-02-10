---
title: Partition to K Equal Sum Subsets
date: 2017-10-29 11:16:55
categories: LeetCode
tags:
- LeetCode
- DP
---

第35天。

又一次一个早上没做出来，难道要跪在DP上了吗？

今天的题目是[Partition to K Equal Sum Subsets](https://leetcode.com/problems/partition-to-k-equal-sum-subsets/description/):

> Given an array of integers nums and a positive integer k, find whether it's possible to divide this array into k non-empty subsets whose sums are all equal.
>
> Example 1:
> Input: nums = [4, 3, 2, 3, 5, 2, 1], k = 4
> Output: True
> Explanation: It's possible to divide it into 4 subsets (5), (1, 4), (2,3), (2,3) with equal sums.
> Note:
>
> 1 <= k <= len(nums) <= 16.
> 0 < nums[i] < 10000.

虽然一开始思路是对的，但是就是没想出来做递归，先讲讲我想到的：

首先，他要我们分辨一组数字是否能被划分成K个相同的子集，我们可以对这个数组进行求和，如果和是K的倍数，那么这个倍数`a`就是每个子集的和，如果不是K的倍数，则肯定没法分成和相同的K个子集。

现在问题变成了，找出k个子集使得它的和为`a`.

然后，我就不会做了。

然后是在`dicuss`中看到的方法，前面的思路是完全一样的，所以这里只讲讲他是怎么做求出k个子集使得和为`a`的.

其实方法很简单，暴力搜而已。

我们用一个大小为k的`vector`来记录每个子集的和（或者还差多少），然后我们从后面向前搜索，每次尝试将一个元素放入第i个vector中，然后考虑下一个元素，emmm，其实不好讲出来，但是代码挺简单的。

btw,这里好像没有制表啊，然后我还一直想着要怎么制表。算了，明天还是按顺序直接刷吧。

```c++
bool canPartitionKSubsets(vector<int>& nums, int k) {
    if ( k <= 1 ) return true;
    //return canPartitionKSubsets(nums.begin(),k/2);

    sort(nums.begin(),nums.end());

    int sum = 0;
    for(auto i:nums) 
        sum +=i;
    if (sum % k != 0) return false;
    int a = sum / k;
    vector<int> kdq(k,a);
    return possible(nums,kdq,nums.size() - 1);
}
bool possible(vector<int> &nums,vector<int> &kdq,int index) {
    if (index < 0) {
        for(int i:kdq) if (i != 0) return false;
        return true;
    }
    int n = nums[index];
    for(auto &a:kdq) {
        if (a >= n) {
            a -= n;
            if (possible(nums,kdq,index-1)) return true;
            a += n;
        }
    }
    return false;
}
```