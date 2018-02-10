---
title: Find the Duplicate Number
date: 2017-11-21 13:17:18
categories: LeetCode
tags:
- LeetCode
---

第55天。

今天的题目是[Find the Duplicate Number](https://leetcode.com/problems/find-the-duplicate-number/description/):

> Given an array nums containing n + 1 integers where each integer is between 1 and n (inclusive), prove that at least one duplicate number must exist. Assume that there is only one duplicate number, find the duplicate one.
>
> Note:
> You must not modify the array (assume the array is read only).
> You must use only constant, O(1) extra space.
> Your runtime complexity should be less than O(n2).
> There is only one duplicate number in the array, but it could be repeated more than once.

一开始，没看到说要用`O(1)`的空间复杂度，就直接用计数的方法去写了：

```c++
int findDuplicate1(vector<int>& nums) {
    vector<int> count(nums.size(),0);
    for(auto i:nums) {
        count[i]++;
        if (count[i]>1) return i;
    }
    return -1;
}
```

然后是后来想了很久，想着利用异或的方法去做，就是先将`nums`中的数字进行异或，然后在对`[1,n]`的数字进行异或，然后就直接是答案了，但是这种问题要限定在重复数字只重复一次的情况下，即需要保证`[1:n]`的数字都存在：

```c++
int findDuplicate2(vector<int>& nums) {
    int t = 0;
    int n = nums.size() - 1;
    for(auto i:nums) {
        t ^= i;
    }
    for(int i = 1;i <= n;i++)
        t ^= i;
    return t;
}
```

最后。。。最后就实在想不出了，只好去看`dicuss`了：

他是用了一个`List Cycle`中找环点的方式，这里的链表中的`nxet`就是用nums的值来表示的。

```c++
int findDuplicate(vector<int>& nums) {
    int n = nums.size();
    int slow = n;
    int fast = n;
    do {
        slow = nums[slow-1];
        fast = nums[nums[fast-1]-1];
    }while(slow != fast);
    slow = n;
    while(slow != fast) {
        slow = nums[slow - 1];
        fast = nums[fast - 1];
    }
    return slow;
}
```


