---
title: Jump-Game
date: 2017-10-16 09:27:29
categories: LeetCode
tags:
- LeetCode
---

第23天

又是周一，心塞，一周过去的真快。

今天的题目是[Jump Game](https://leetcode.com/problems/jump-game/description/).

> Given an array of non-negative integers, you are initially positioned at the first index of the array.
>
> Each element in the array represents your maximum jump length at that position.
>
> Determine if you are able to reach the last index.
>
> For example:
> A = [2,3,1,1,4], return true.
>
> A = [3,2,1,0,4], return false.

这道题，主要先理解到，他存放的是`maximum jump length`,也就是说，你可以跳小于这个值的步数。然后自然而然的就想到用递归去做啊：

* 从后向前考虑，用一个值来记录可以从最后一个位置回去的最小index.
* 在每一个index中，把当前的index当成是自己的要到达的点，再递归调用自己。

```c++
bool canJump1(vector<int>& nums) {
    return canJump1(nums,nums.size() - 1);
}
bool canJump1(vector<int> &nums,int last) {
    if (last == 0) return true;
    int k = 1;
    for(int i = last-1;i >= 0;i--,k++) {
        if (nums[i] >= k && canJump1(nums,i))
            return true;
    }
    return false;
}
```

然后，这个方法就超时了，做了很多重复的操作。

恩，再仔细看看题目的话，它其实只要求我们返回能否到达，不要求给出跳的方法，所以我们可以换一种思路来考虑，用一个`last`值来记录当前能到达的最远位置（初始值当然是0啦），然后遍历所有能到的点然后更新当前能到的最远点，如果当前能到的点已经大于`nums.size() - 1`了，那么说明我们可以到达，如果遍历完所有的点之后还没有大于，说明到不了：

```c++
bool canJump2(vector<int> &nums) {
    int last = 0;
    for(int i = 0;i <= last && i < nums.size();i++) {
        last = max(last,i+nums[i]);
        if (last >= nums.size()-1) return true;
    }
    return false;
}
```

这个的时间复杂度是`O(n)`,尝试过优化，但是没能成功。

最后是在`dicuss`中看到的方法，其实和上面的想法是一样的，只不过它是从后往前考虑:

```c++
bool canJump4(vector<int> &nums) {
    int last = nums.size() - 1;
    for(int i=nums.size() - 1;i >= 0;i--) {
        if (i + nums[i] >= last) {
            last = i;
        }
    }
    return last <= 0;
}
```