---
title: Single Number III
date: 2017-11-27 12:23:09
categories: LeetCode
tags:
- LeetCode
- Bit-Manipulation
---

第61天。

今天的题目是[Single Number III](https://leetcode.com/problems/single-number-iii/description/):

> Given an array of numbers nums, in which exactly two elements appear only once and all the other elements appear exactly twice. Find the two elements that appear only once.
>
> For example:
>
> Given nums = [1, 2, 1, 3, 2, 5], return [3, 5].
>
> Note:
> The order of the result is not important. So in the above example, [5, 3] is also correct.
> Your algorithm should run in linear runtime complexity. Could you implement it using only constant space complexity?

在求解这个问题之前，我们先考虑一下简化后的问题，如果只有一个Single Number的话，我们要怎么求解。

如果熟悉异或运算的话，就很快的想出解决办法，这里用到了三个性质：

* 0^a = a
* a^a = 0
* a^b^a = b

假设现在序列有个数，分别为`n1,n2,n2...nk`,我们将它们异或起来：
`t = n1^n2^n3^...^nk`,因为中间只有一个`single number`,所以t中只有一个数不能因为`a^a = 0`而消除掉。因此`t`就是这个序列中的`single number`.

这是只有一个`single number`的情况，如果我们用类似的方法去做这道题的话，我们会得到`t = a1^a2`,但是显然我们无法快速的将a1和a2分解出来，除非我们知道其中一个数。

那我们能不能把序列分成两部分来做，每部分都包含一个`single number`且其余的数都包含两个，我们可以从`bit`的角度来考虑，如果某个位（比如说最低位）为`1`,那我们就将它分到第一部分，否则我们就将它分到第二部分，这样的方法可以很好的区分除了`single number`之外的数（因为两个`single number`可能分到相同的部分）。现在的问题就是我们要怎么将两个`single number`分到不同部分。

现在我们已经有了`t = a1^a2`,异或的定义是不同的bit为`1`,相同的bit为`0`,所以说t中为`1`的bit位（总是可以找到）可以作为我们上面那个算法的区分点了。

然后现在就是找出`t`中一个为`1`的`bit`了，简单的可以遍历去做，比较只有32位，所以时间复杂度是`O(1)`的，但是我们有一个更快的方法：
`t & (t-1)`可以将第一个为`1`的bit位清0,然后我们再异或上原来的t,我们就可以得到对应的`mask`了。

```c++
vector<int> singleNumber(vector<int>& nums) {
    int t = 0;
    for(auto i:nums) t ^= i;
    int lastBit = (t & (t-1)) ^ t;
    int a = 0;
    for(auto i:nums) if (i&lastBit) a^=i;
    return {a,a^t};
}
```