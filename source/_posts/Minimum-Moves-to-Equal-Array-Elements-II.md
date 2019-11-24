---
title: Minimum Moves to Equal Array Elements II
date: 2019-11-24 10:53:34
tags:
- LeetCode
categories: LeetCode
---

> 第20天。

今天的题目是[ Minimum Moves to Equal Array Elements II ]( https://leetcode.com/problems/minimum-moves-to-equal-array-elements-ii/ )：

---

Given a **non-empty** integer array, find the minimum number of moves required to make all array elements equal, where a move is incrementing a selected element by 1 or decrementing a selected element by 1.

You may assume the array's length is at most 10,000.

**Example:**

```
Input:
[1,2,3]

Output:
2

Explanation:
Only two moves are needed (remember each move increments or decrements one element):

[1,2,3]  =>  [2,2,3]  =>  [2,2,2]
```

---

这道题需要一些数学推导，它的目标就是：

$$
min_k \{ \sum_{i=1}^n |n_i - n_k| \}
$$
其中 $n_i$ 表示数组排序后中第 $i$ 个元素。

我们将式子展开可以得到：
$$
min_k \{ \sum_{i=1}^n |n_i - n_k| \} = 

min_k \{ \sum_{i=1}^k (n_k-n_i) + \sum_{i=k+1}^n(n_i-n_k) \} \\

= min_k \{ \sum_{i=1}^k n_k - \sum_{i=1}^k n_i + \sum_{i=k+1}^n n_i - \sum_{i=k+1}^n n_k  \} \\

= min_k \{ \sum_{i=k+1}^n n_i - \sum_{i=1}^k n_i + (2k - n)n_k  \}
$$
因此，我们可以写出如下代码：

```c++
int minMoves2(vector<int>& nums) {
    long long res = LONG_MAX;
    sort(nums.begin(), nums.end());
    long long rightSum = 0;
    for(auto i: nums) rightSum += i;
    long long leftSum = 0;
    int n = nums.size();

    for(int i = 0;i < n; ++i) {
        res = min(res, rightSum - leftSum + (2*i - n) * (long long)nums[i]);
        rightSum -= nums[i];
        leftSum += nums[i];
        // cout << res << endl;
    }

    return res;
}
```

这样还不是最优解，然而最优解我没看懂（捂脸），为什么用中位数求就是对的呢？：

```c++
    int minMoves2(vector<int>& nums) {
                
        sort(nums.begin(), nums.end());
        
        int mid;
        
        if (nums.size() % 2 == 0){
            
            mid = (nums[nums.size()/2] + nums[(nums.size()/2) - 1])/2;
            
        }else{
            
            mid = nums[nums.size()/2];
            
        }
        
        int result = 0;
        
        for (int i = 0; i < nums.size(); i++){
            
            result += abs(nums[i] - mid);
            
        }
        
        return result;
        
    }
```

