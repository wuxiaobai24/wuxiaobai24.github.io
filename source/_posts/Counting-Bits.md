---
title: Counting Bits
date: 2017-11-23 12:03:11
categories: LeetCode
tags:
- LeetCode
- DP
---

第57天。

今天的题目是[Counting Bits](https://leetcode.com/problems/counting-bits/description/):

> Given a non negative integer number num. For every numbers i in the range 0 ≤ i ≤ num calculate the number of 1's in their binary representation and return them as an array.
>
> Example:
> For num = 5 you should return [0,1,1,2,1,2].
>
> Follow up:
>
> It is very easy to come up with a solution with run time O(n*sizeof(integer)). But can you do it in linear time O(n) /possibly in a single pass?
> Space complexity should be O(n).
> Can you do it like a boss? Do it without using any builtin function like __builtin_popcount in c++ or in any other language.

和昨天的题目有点联系。

我们知道要求一个数的二进制表示中`1`的个数大概需要`O(1)`的时间，但这里的`O(1)`其实是`O(sizeof(integer))`.这里的题目上要求直接用`O(n)`的算法，而不是`O(n*sizeof(int))`的算法，这说明我们不能用昨天的算法来对每个数进行求解，我们必须找到一个规律来快速的算出来。

尝试把0~16二进制表示中`1`的个数算出来：

> 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
> 0 1 1 2 1 2 2 3 1 2 2  3  2  3  3  4  1

可以观察到0-1的值和2-3的值刚好差1，4-7的值和0-4的值刚好差1，同样的8-16的值和0-7的值刚好差。

因此，我们可以写出一下递推式：

`numCount[i] = numCount[i-k]` 其中`k`表示`i`只保留最高位的`1`时所代表的数。

比如说`i=20`时，20的二进制表示是`10100`,则`k`的二进制位`10000`,即`16`.

知道这个之后，我们就可以很容易的求解出来：

```c++
vector<int> countBits(int num) {
    vector<int> ret(num+1,0);
    int k = 1;
    for(int i = 1;i <= num;i++) {
        if (i == k<<1) k<<=1;
        ret[i] = ret[i - k] + 1;
    }
    return ret;
}
```

`dicuss`中有一些更精妙的递推式：

```c++
vector<int> countBits(int num) {
    vector<int> ret(num+1, 0);
    for (int i = 1; i <= num; ++i)
        ret[i] = ret[i&(i-1)] + 1;
    return ret;
}
```