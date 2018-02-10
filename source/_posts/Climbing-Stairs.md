---
title: Climbing Stairs
date: 2017-11-12 16:22:52
categories: LeetCode
tags:
- LeetCode
---

第46天。

今天的题目是[Climbing Stairs](https://leetcode.com/problems/climbing-stairs/description/):

> You are climbing a stair case. It takes n steps to reach to the top.
>
> Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
>
> Note: Given n will be a positive integer.
>
>
> Example 1:
>
> Input: 2
> Output:  2
> Explanation:  There are two ways to climb to the top.
>
> 1. 1 step + 1 step
> 1. 2 steps
> Example 2:
>
> Input: 3
> Output:  3
> Explanation:  There are three ways to climb to the top.
>
> 1. 1 step + 1 step + 1 step
> 1. 1 step + 2 steps
> 1. 2 steps + 1 step

首先，要到达第n个台阶，我们需要先到n-1或n-2台阶，只要到达n-1和n-2台阶处，我们就能够通过一步到达第n个台阶，这时可以写出这样的递推式:

```c++
climbStairs(n) = climbStairs(n-1) + climbStairs(n-2);
climbStairs(0) = climbStairs(1) = 1;
```

熟悉的话，可以一眼看出这是斐波那契数列.

这样的话，我们可以很容易写出:

```c++
int climbStairs(int n) {
    if (n == 0 || n == 1) return 1;
    return climbStairs(n-1) + climbStairs(n-2);
}
```

但是这样会出现超时的情况，我们可以用一个数组来记录整个斐波那契数列，然后返回适当的值即可:

```c++
int climbStairs(int n) {
    vector<int> vec(n+1,1);
    for(int i = 2;i <= n;i++) {
        vec[i] = vec[i-1] + vec[i-2];
    }
    return vec[n];
}
```

这样的时间复杂度和空间复杂度都是`O(n)`.

我们可以把空间复杂度降到`O(1)`:

```c++
int climbStairs(int n) {
    int a = 0,b = 1,t;
    while(n--) {
        t = a+b;
        a = b;
        b = t;
    }
    return b;
}
```