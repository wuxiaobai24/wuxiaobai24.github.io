---
title: Maximum Product Subarray
date: 2017-10-02 14:58:46
categories: LeetCode
tags:
- LeetCode
- 动态规划
---

打卡，第9天

今天这道题做了好久。。。

> Find the contiguous subarray within an array (containing at least one number) which has the largest product.
> 
> For example, given the array [2,3,-2,4],
> the contiguous subarray [2,3] has the largest product = 6.

看到这道题，就让我想起了昨天做得那道[Longest Substring Without Repeating Characters](https://wuxiaobai24.github.io/2017/10/01/LongestSubstringWithoutRepeatingCharacters/)。

看起来很像是同一类的题目，想着用同一种方法去做，然后就考虑了好多奇奇怪怪的情况，最后代码写的及其混乱。

```c++
int maxProduct(vector<int>& nums) {
    int i = 0,j = 0;
    int ret = INT_MIN;
    int now = 0;

    for(j = 0;j < nums.size();j++){
        if (nums[j] == 0){
            while(now < 0 && i < j -1)
                now /= nums[i++];
            ret = max(ret,now);
            if (ret < 0) ret = 0;
            now = 0;
            i = j+1;
        } else {
            now = (now)?now*nums[j]:nums[j];
            ret = max(ret,now);
        }
    }

    while(now < 0 && i < j - 1)
        now /= nums[i++];
    ret = max(ret,now);
    return ret;
}
```

这还是做完后进行了一些删减的答案，看起来很复杂，要我现在去解释它都有点困难。

先提提我的思路：

- 和昨天的一样，我用两个下标来标识当前`Subarray`,也就是说，然后让`j`不断向前去遍历。

- 我需要考虑的就是什么时候`i`向前，我的想法是：

    > 当我们遇到一个0时，我们需要把i改成j+1,因为正常情况下`Subarray`中如果有个`0`，那么`Subarray`的乘积就必定是0，为什么说是正常情况呢，因为如果当前最大乘积小于0的话，那么我们遇到一个`0`，要把最大乘积改成`0`.

- 但是如果我们遇到这样的数组`2 -1 4 0`,我们当前的策略的返回值是`2`，但真正应该是4，因此另一个`i`向前的情况是：

    > 遇到一个`0`或遍历完整个数组，我们需要让`i`向前移动，直到让当前乘积变成大于0，或者到达`j`。

最后将这一大段思路变成代码就成了我上面写的了，其实仔细想想，这些思路其实并不复杂，只是有点繁琐，如果心能静点的话，应该可以更快的AC掉这道题。

下面是`dicuss`中的方法：

```c++
int maxProduct(int A[], int n) {
    // store the result that is the max we have found so far
    int r = A[0];

    // imax/imin stores the max/min product of
    // subarray that ends with the current number A[i]
    for (int i = 1, imax = r, imin = r; i < n; i++) {
        // multiplied by a negative makes big number smaller, small number bigger
        // so we redefine the extremums by swapping them
        if (A[i] < 0)
            swap(imax, imin);

        // max/min product for the current number is either the current number itself
        // or the max/min by the previous number times the current one
        imax = max(A[i], imax * A[i]);
        imin = min(A[i], imin * A[i]);

        // the newly computed max value is a candidate for our global result
        r = max(r, imax);
    }
    return r;
}
```

把注释去掉话，其实没几句话，说实话，第一次看没看懂，分析一下他的思路：

- 同样是遍历，但是它维护的不是下标，而是在A[0:j]中的子数组的最大值imax和子数组最小值imin.

- 他用的是减治法，大概的想法是，我们知道A[0:n-1]imax和imin，我们如果求出A[0:n]的`imax,imin`。

    - 如果`A[n]>=0`,那么`imax = max(A[n],imax*A[n]);imin = min(A[n],imin*A[n])`
    - 如果`A[n] < 0`，那么`imin = min(A[n],imax*A[n]);imax = max(A[n],imin*A[n])`
