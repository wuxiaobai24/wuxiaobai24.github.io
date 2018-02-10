---
title: Subsets
date: 2017-10-20 09:28:46
categories: LeetCode
tags:
- LeetCode
---

第27天

今天的题目是[Subsets](https://leetcode.com/problems/subsets/description/):

> Given a set of distinct integers, nums, return all possible subsets.
>
> Note: The solution set must not contain duplicate subsets.
>
> For example,
> If nums = [1,2,3], a solution is:

```python
[
  [3],
  [1],
  [2],
  [1,2,3],
  [1,3],
  [2,3],
  [1,2],
  []
]
```

我的做法是用递归的方法去做:

```c++
vector<vector<int>> subsets(vector<int>& nums) {
    vector< vector<int> > ret;
    vector<int> vec;
    ret.push_back(vec);
    subsetsIter(ret,nums,vec,0);
    return ret;
}

void subsetsIter(vector< vector<int> > &ret,vector<int> &nums,vector<int> now,int beg) {
    //if (now.size() == nums.size()) return ;
    now.push_back(-1);
    auto rbeg = now.rbegin();
    for(int i = beg;i < nums.size();i++) {
        *rbeg = nums[i];
        ret.push_back(now);
        subsetsIter(ret,nums,now,i+1);
    }
    now.pop_back();
}
```


然后是在`dicuss`中看到的迭代的方法和利用二进制的方法：

```c++
vector<vector<int>> subsets(vector<int>& nums) {
    sort(nums.begin(), nums.end());
    vector<vector<int>> subs(1, vector<int>());
    for (int i = 0; i < nums.size(); i++) {
        int n = subs.size();
        for (int j = 0; j < n; j++) {
            subs.push_back(subs[j]); 
            subs.back().push_back(nums[i]);
        }
    }
    return subs;
}
```

```c++
vector<vector<int>> subsets(vector<int>& nums) {
    sort(nums.begin(), nums.end());
    int num_subset = pow(2, nums.size()); 
    vector<vector<int> > res(num_subset, vector<int>());
    for (int i = 0; i < nums.size(); i++)
        for (int j = 0; j < num_subset; j++)
            if ((j >> i) & 1)
                res[j].push_back(nums[i]);
    return res;  
}
```