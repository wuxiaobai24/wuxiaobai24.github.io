---
title: Valid-Triangle-Number
date: 2017-12-03 10:26:32
categories: LeetCode
tags:
- LeetCode
---

第67天。

今天的题目是[Valid Triangle Number](https://leetcode.com/problems/valid-triangle-number/description/):

> Given an array consists of non-negative integers, your task is to count the number of triplets chosen from the array that can make triangles if we take them as side lengths of a triangle.
> Example 1:
> Input: [2,2,3,4]
> Output: 3
> Explanation:
> Valid combinations are:
> 2,3,4 (using the first 2)
> 2,3,4 (using the second 2)
> 2,2,3
> Note:
> The length of the given array won't exceed 1000.
> The integers in the given array are in the range of [0, 1000].


莫名其妙的用一个`O(n^3)`的解法AC了:

```c++
int triangleNumber(vector<int>& nums) {
    sort(nums.begin(),nums.end());
    int ret = 0;
    for(int i = 0;i < nums.size();i++) {
        for(int j = i + 1;j < nums.size();j++) {
            //nums[i] + num[j] > a;
            for(int k = j+1;k < nums.size() && nums[i] + nums[j] > nums[k];k++)
                ret++;
        }
    }
    return ret;
}
```

然后是`dicuss`中的`O(n^2)`的解法：

```java
public static int triangleNumber(int[] A) {
    Arrays.sort(A);
    int count = 0, n = A.length;
    for (int i=n-1;i>=2;i--) {
        int l = 0, r = i-1;
        while (l < r) {
            if (A[l] + A[r] > A[i]) {
                count += r-l;
                r--;
            }
            else l++;
        }
    }
    return count;
}
```