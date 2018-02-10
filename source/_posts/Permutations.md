---
title: Permutations
date: 2017-10-13 09:17:05
categories: LeetCode
tags:
- LeetCode
---

第20天，第二次超级快的刷完了一道题。。。要不明天试试刷`hard`

今天的题目是[Permutations](https://leetcode.com/problems/permutations/description/),emmm,之前好像好几次都忘记加地址了。

> Given a collection of distinct numbers, return all possible permutations.
> For example,
> [1,2,3] have the following permutations:

```python
[
  [1,2,3],
  [1,3,2],
  [2,1,3],
  [2,3,1],
  [3,1,2],
  [3,2,1]
]
```

总感觉之前遇到过类似的题目，然后思路也是很简单的，直接递归的做就好了：

这里如果不算是`push_back`中的拷贝数组，应该已经是拷贝数组次数最少的了，做的时候以为`push_back`不会拷贝，不过在`dicuss`中看的做法是只在`push_back`中进行拷贝。

```c++
vector<vector<int> > ret;
vector<vector<int>> permute(vector<int>& nums) {
    //if (nums.size() == 0 || nums.size() == 1) return {nums};
    permute(nums,0);
    return ret;
}
void permute(vector<int> &nums,int beg) {
    if (nums.size() - beg <= 1) {
        ret.push_back(nums);
        return ;
    }
    permute(nums,beg+1);
    for(int i = beg+1;i<nums.size();i++) {
        vector<int> vec = nums;
        swap(vec[beg],vec[i]);
        permute(vec,beg+1);
    }
}
```

`dicuss`中的做法：

```c++
vector<vector<int> > permute(vector<int> &num) {
    vector<vector<int> > result;

    permuteRecursive(num, 0, result);
    return result;
}

// permute num[begin..end]
// invariant: num[0..begin-1] have been fixed/permuted
void permuteRecursive(vector<int> &num, int begin, vector<vector<int> > &result)	{
    if (begin >= num.size()) {
        // one permutation instance
        result.push_back(num);
        return;
    }

    for (int i = begin; i < num.size(); i++) {
        swap(num[begin], num[i]);
        permuteRecursive(num, begin + 1, result);
        // reset
        swap(num[begin], num[i]);
    }
}
```

他的做法和我一开始的时候类似，但是我没想到可以换回来。。。