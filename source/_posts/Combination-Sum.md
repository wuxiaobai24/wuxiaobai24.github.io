---
title: Combination-Sum
date: 2017-10-12 11:24:59
categories: LeetCode
tags:
- LeetCode
---

第19天

这道题是在起床到去上课前AC出来的，emmm，大概就10多分钟的样子。。。

虽然后来尝试优化了一下，但是感觉效果都不怎么好。。

题目描述：

> Given a set of candidate numbers (C) (without duplicates) and a target number (T), find all unique combinations in C where the candidate numbers sums to T.
>
> The same repeated number may be chosen from C unlimited number of times.
>
> Note:
> * All numbers (including target) will be positive integers.
> * The solution set must not contain duplicate combinations.
> 
> For example, given candidate set [2, 3, 6, 7] and target 7,A solution set is: 

```python
[
  [7],
  [2, 2, 3]
]
```

其实想法很简单，我既然想求`combinationSum(7)`，通过遍历数组，我们现在有了一个`[2]`，我只需要在求`combinatiomSum(7-2)`即可，然后组合起来：

```c++
vector<int> cand;
vector<vector<int> > ret;
vector<vector<int>> combinationSum(vector<int>& candidates, int target) {
    cand = candidates;
    sort(cand.begin(),cand.end());
    vector<int> now;
    combinationSumIter(now,0,target);
    return ret;
}
void combinationSumIter(vector<int> &now,int beg,int target){
    //cout << "target" << target << endl;
    for(int i = beg;i < cand.size();++i) {
        if (target < cand[i])
            break;
        else if (target == cand[i]) {
            vector<int> vec = now;
            vec.push_back(cand[i]);
            ret.push_back(vec);
        } else if (target - cand[i] >= cand[0] ){
            vector<int> vec = now;
            vec.push_back(cand[i]);
            combinationSumIter(vec,i,target-cand[i]);
        }
    }
}
```

然后在`dicuss`中看到的也是类似的想法：

```c++
class Solution {
public:
    std::vector<std::vector<int> > combinationSum(std::vector<int> &candidates, int target) {
        std::sort(candidates.begin(), candidates.end());
        std::vector<std::vector<int> > res;
        std::vector<int> combination;
        combinationSum(candidates, target, res, combination, 0);
        return res;
    }
private:
    void combinationSum(std::vector<int> &candidates, int target, std::vector<std::vector<int> > &res, std::vector<int> &combination, int begin) {
        if (!target) {
            res.push_back(combination);
            return;
        }
        for (int i = begin; i != candidates.size() && target >= candidates[i]; ++i) {
            combination.push_back(candidates[i]);
            combinationSum(candidates, target - candidates[i], res, combination, i);
            combination.pop_back();
        }
    }
};
```