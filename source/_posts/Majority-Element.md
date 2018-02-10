---
title: Majority Element
date: 2017-11-10 08:33:00
categories: LeetCode
tags:
- LeetCode
---

第45天。

今天的题目是[Majority Element](https://leetcode.com/problems/majority-element/discuss/):

> Given an array of size n, find the majority element. The majority element is the element that appears more than ⌊ n/2 ⌋ times.
>
> You may assume that the array is non-empty and the majority element always exist in the array.

最简单的想法就是，遍历一遍序列，记录出现的次数，然后在遍历一遍刚才记录的次数，如果大于`k`就直接返回，这种时候一般会用到`hash table`，在`c++`中就是`unordered_map`:

```c++
int majorityElement(vector<int>& nums) {
    int size = nums.size();
    int k = size/2;
    unordered_map<int,int> map;
    for(auto i:nums) map[i]++;
    for(auto p:map) if (p.second > k) return p.first;
}
```

这种方法的时间复杂度是`O(n)`,空间复杂度也是`O(n)`.

虽然很简单，但是这道题目在`dicuss`中也有很多有趣的解法:

* 因为`Majority Element`在序列中存在`n/2`个，所以假如这个序列时有序的话，他一定会出现在中间:

```c++
int majorityElement(vector<int>& nums) {
    nth_element(nums.begin(), nums.begin() + nums.size() / 2, nums.end());
    return nums[nums.size() / 2];
}
```

很`nice`的学到了一个新的函数。

* 同样是因为出现了`k/2`次，所以我们如果随机选取一个元素的话，有一半的概率可以直接选到`Majority Element`:

```c++
int majorityElement(vector<int>& nums) {
    int n = nums.size();
    srand(unsigned(time(NULL)));
    while (true) {
        int idx = rand() % n;
        int candidate = nums[idx];
        int counts = 0;
        for (int i = 0; i < n; i++)
            if (nums[i] == candidate)
                counts++;
        if (counts > n / 2) return candidate;
    }
}
```

* `Moore Voting Algorithm`，这个方法的正确性我也不是很确定:

```c++
int majorityElement(vector<int>& nums) {
    int major, counts = 0, n = nums.size();
    for (int i = 0; i < n; i++) {
        if (!counts) {
            major = nums[i];
            counts = 1;
        }
        else counts += (nums[i] == major) ? 1 : -1;
    }
    return major;
}
```