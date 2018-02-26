---
title: Combination Sum II
date: 2018-02-26 14:22:23
tags:
- LeetCode
---

第107天。

虽然前几天都有刷题，但是没写blog。

题目是[Combination Sum II](https://leetcode.com/problems/combination-sum-ii/description/):

题目描述：


Given a collection of candidate numbers (C) and a target number (T), find all unique combinations in C where the candidate numbers sums to T.


Each number in C may only be used once in the combination.

Note:

All numbers (including target) will be positive integers.
The solution set must not contain duplicate combinations.




For example, given candidate set [10, 1, 2, 7, 6, 1, 5] and target 8, 
A solution set is: 

[
  [1, 7],
  [1, 2, 5],
  [2, 6],
  [1, 1, 6]
]



求解思路：

显然是用回溯法来做了（也就是穷举），都成套路了，有一个难点就是这里要求不能重复，可能可以用`set`来做，这里采取的方法是先排序再回溯的方法。

```cpp
class Solution {
public:
    vector<vector<int>> ret;
    vector<vector<int>> combinationSum2(vector<int>& candidates, int target) {
        sort(candidates.begin(), candidates.end(), [](int a, int b) {
            return a > b;
        });
        vector<int> temp;
        combinationSum2(candidates, 0, target, temp);
        return ret;
    }
    bool combinationSum2(vector<int>& candidates, int beg, int target, vector<int> temp) {
        if (target == 0) {
            // get a solution
            ret.push_back(temp);
            return true;
        }
        
        for(int i = beg; i < candidates.size() ; i++) {
            if (candidates[i] > target) continue;
            temp.push_back(candidates[i]);
            combinationSum2(candidates, i + 1, target - candidates[i], temp);
            while(i + 1 < candidates.size() && candidates[i] == candidates[i+1]) i++;
            temp.pop_back();
        }
        
        return false;
    }
};
```
