---
title: House Robber
date: 2017-11-19 11:07:15
categories: LeetCode
tags:
- LeetCode
---

第53天。

今天的题目是[House Robber](https://leetcode.com/problems/house-robber/description/):

> You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security system connected and it will automatically contact the police if two adjacent houses were broken into on the same night.
>
> Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.

题目很长，大概的意思是给你一组非负数，代表每个房间中有的金额，你可以去任意一个房间取钱，但是不能在两个相邻的房间取，求出能取出的最大金额。

一开始想的很简单，直接在单数号的房间取或者在双数号的房间取，这样的话，我就取了最多次，只要遍历求个和即可，然而这样会有一个问题，例如序列是这样的`[2,1,1,2]`,这样的话，应该是取第一个房间和最后一个房间才对。

突然觉得好像很难求出来才是，因为可能性太多了，而且也不好构造这种可能性，突然想到这会不会是一道`dp`的题目，然后用`dp`的思路去想。

如果有k个房间可以取钱，那么是不是对于第k个房间就只有两种可能，即取或不取：

- 取，那么k-1我们就不能取了，我们只能取k-2个房间的钱，问题转换成求前k-2个房间能取多少
- 不取，那么问题变成了求前k-1个房间能不能取。

我们可以得到以下递推式：

> rob(nums,k) = max(rob(num,k-1),rob(nums,k-2) + nums[k])

这样我们就可以很轻松的写出：

```python
def rob1(self, nums):
    """
    :type nums: List[int]
    :rtype: int
    """
    dp = [0]*(len(nums)+2)
    for i in range(len(nums)):
        dp[i+2] = max(dp[i+1],dp[i]+nums[i])
    return dp[-1]
```

很显然我们可以将空间复杂度从`O(n)`降到`O(1)`:

```python
def rob2(self, nums):
    """
    :type nums: List[int]
    :rtype: int
    """
    #dp = [0]*(len(nums)+2)
    dp1,dp2,dp3 = 0,0,0
    for i in nums:
        dp3 = max(dp2,dp1+i)
        dp1,dp2 = dp2,dp3
    return dp3
```

我们还可以在减少一点，但是时间复杂度还是`O(1)`:

```python
def rob(self, nums):
    """
    :type nums: List[int]
    :rtype: int
    """
    #dp = [0]*(len(nums)+2)
    dp1,dp2 = 0,0
    for i in nums:
        dp1,dp2 = dp2,max(dp2,dp1+i)
    return dp2
```