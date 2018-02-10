---
title: Hamming Distance
date: 2017-11-22 19:38:40
categories: LeetCode
tags:
- LeetCode
---

第56天。

刷道水题[Hamming Distance](https://leetcode.com/problems/hamming-distance/description/):

> The Hamming distance between two integers is the number of positions at which the corresponding bits are different.
>
> Given two integers x and y, calculate the Hamming distance.
>
> Note:
> 0 ≤ x, y < 231.
>
> Example:
>
> Input: x = 1, y = 4
>
> Output: 2
>
> Explanation:
> 1   (0 0 0 1)
> 4   (0 1 0 0)
> _     ↑   ↑
> The above arrows point to positions where the corresponding bits are different.

所谓的`humming distance`就是两个数在bit位上不同的个数，就`int`来说，最多就是全部不相同，也就是每个bit位都不一样，即`humming distance`.

我们可以利用异或来很快的求出来，异或可以让bit位不相同时置1，相同时置0.则两数异或后所得到的数中有bit位中1的个数就是`humming distance`:

```c++
int hammingDistance(int x, int y) {
    int t = x^y;
    int ret = 0;
    while(t!=0) {
        ret += (t&1);
        t >>= 1;
    }
    return ret;
}
```