---
title: Matchsticks to Square
date: 2019-03-08 11:10:39
tags:
- LeetCode
categories:
- LeetCode
---

> 第9天，恩，忘记洗衣服了，写完就去洗。

今天的题目是[Matchsticks to Square](https://leetcode.com/problems/matchsticks-to-square/)。

没想到是一道暴搜的题。。。

既然是暴搜，那思路就比较简单了：

我们先计算出数组和，然后除以4就是每条边的长度了，然后用暴力搜索的方式看是否能连续四次移除长度之和为边长的火柴。

暴搜时可以用一些小技巧，比如先排序来保证先用掉比较长的火柴，这样一旦发现，剩下的火柴比需要的长度还长就可以直接判定失败了，减少搜索次数。

而且标记是否使用掉该火柴的`used`数组也可以省略掉，因为火柴长度一定大于0， 可以用其相反数来表示已经用掉了

```c++
class Solution {
public:
    bool makesquare(vector<int>& nums) {
        int len = nums.size();
        if (len == 0) return false;
        sort(nums.rbegin(), nums.rend());
        
        int sum = 0;
        for(auto &i: nums) sum+=i;
        
        if (sum % 4) return false;
        
        for(int i = 0;i < 4; i++) {
            if (dfs(nums, sum/4) == false) return false;
        }
        return true;
    }
    bool dfs(vector<int> &nums, int len) {
        if (len == 0) return true;
        else if (len < 0) return false;
        
        for(int i = 0;i < nums.size(); i++) {
            if (len < nums[i]) return false;
            if (nums[i] <= 0) continue;
            nums[i] = -nums[i];
            if (dfs(nums, len + nums[i])) return true; 
            nums[i] = -nums[i];
        }
        return false;
    }
};
```