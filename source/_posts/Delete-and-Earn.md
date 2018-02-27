---
title: Delete and Earn
date: 2018-02-27 10:45:44
tags:
- LeetCode
---

题目是[Delete and Earn](https://leetcode.com/problems/delete-and-earn/description/):

题目描述：


Given an array nums of integers, you can perform operations on the array.

In each operation, you pick any nums[i] and delete it to earn nums[i] points.  After, you must delete every element equal to nums[i] - 1 or nums[i] + 1.

You start with 0 points.  Return the maximum number of points you can earn by applying such operations.


Example 1:

Input: nums = [3, 4, 2]
Output: 6
Explanation: 
Delete 4 to earn 4 points, consequently 3 is also deleted.
Then, delete 2 to earn 2 points. 6 total points are earned.



Example 2:

Input: nums = [2, 2, 3, 3, 3, 4]
Output: 9
Explanation: 
Delete 3 to earn 3 points, deleting both 2's and the 4.
Then, delete 3 again to earn 3 points, and 3 again to earn 3 points.
9 total points are earned.



Note:
The length of nums is at most 20000.
Each element nums[i] is an integer in the range [1, 10000].


求解思路：

一道动态规划的题目，动态规划的题目做多了之后感觉都有套路了，这道题算是比较简单的套路吧。

先对输入进行一下收集（其实只做排序也应该可以，但是感觉会比较复杂一点），然后对于一个数来说他有两种可能，一种是`delete`，一种是不`delete`，然后根据不同的状态来计算即可。

感觉可以用四个int来进行空间上的优化，但我没试

```cpp
class Solution {
public:
    int deleteAndEarn(vector<int>& nums) {
        if (nums.size() == 0) return 0;
        
        unordered_map<int, int> m;
        for(auto &i:nums) m[i]++;
        
        vector<pair<int, int> > helper(m.begin(), m.end());
        
        sort(helper.begin(), helper.end(), [](pair<int, int> &p1,pair<int, int> &p2) {
            return p1.first < p2.first;
        });
        
        //for(int i = 0;i < helper.size(); i++) {
        //    cout << helper[i].first << helper[i].second << endl;
        //}
        
        vector<int> d(helper.size()+1, 0); //delete
        vector<int> nd(helper.size()+1, 0); // no delete
        d[1] = helper[0].first;
        
        for(int i = 1;i < helper.size()+1;i++) {
            // set d
            /* if (helper[i-1].first-1 == helper[i-2].first) {
                d[i] = helper[i-1].first * helper[i-1].second + max(d[i-2], nd[i-2]);
            } else 
                d[i] = helper[i-1].first * helper[i-1].second + max(d[i-1], nd[i-1]);
            */
            d[i] = helper[i-1].first * helper[i-1].second +
                ( (helper[i-1].first-1 == helper[i-2].first)?max(d[i-2], nd[i-2]):max(d[i-1], nd[i-1]) );
            
            // set nd
            nd[i] = max(d[i-1], nd[i-1]);
        }
        
        
        return max(d[helper.size()], nd[helper.size()]);
    }
};
```
