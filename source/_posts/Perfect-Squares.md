---
title: Perfect Squares
date: 2017-11-20 12:31:22
categories: LeetCode
tags:
- LeetCode
- DP
---

第54天。

今天的题目是[Perfect-Squares](https://leetcode.com/problems/perfect-squares/description/):

> Given a positive integer n, find the least number of perfect square numbers (for example, 1, 4, 9, 16, ...) which sum to n.
>
> For example, given n = 12, return 3 because 12 = 4 + 4 + 4; given n = 13, return 2 because 13 = 4 + 9.

这道题一开始看到还挺懵的，首先，它是需要用`square number`来做加法的，那我是不是要先判断一个数是不是一个`square number`,简单的思路就是将所有不大于n的`square number`生成出来，直接比较即可，假设我们就是用这样的方法，那么现在我们可能就有了所有不大于n的`square number`的序列。

然后继续回到原来的问题，我好像是不需要求出这个表达式是由什么数组成的，而是只需要求出这个表达式由多少个`Square number`组成的就好了，这有点像动态规划的问题，我们用动态规划的思路去想这个问题：

我们要求`numSquares(n)`，我们可以先尝试的假定这个表达式中有一个`1`,那么就可以写成`numSquares(n) = numSquares(n-1)+1`,那如果我们假定这个表达式中有一个`4`,那么就可以写成是`numSquares(n) = numSquares(n-4)+1`,我们可以按照这样思路写出这样的递推式：

> numSquares(n) = Min{numSquares(n-k) + 1 | k is square number and k <= n}

这样的话，我们就可以写出这样的表达式：

```python
def numSquares(self, n):
    """
    :type n: int
    :rtype: int
    """
    dp = [sys.maxsize]*(n+1)
    dp[0] = 0
    for i in range(1,n+1):
        j = 1
        t = j**2
        while t <= i:
            dp[i] = min(dp[i],dp[i-t]+1)
            j+=1
            t = j**2
    return dp[-1]
```

很不幸，这样的方法会在6000之后的数据中超时，然后想了一早上的方式去优化，后来用`c++`去实现了一遍，然后。。。就过来，花了那么久的时间竟然因为语言的问题而一直解决不了。。。算了，以后还是用`c++`写吧，反正有时候用`python`,写的也很乱，还不如`c++`简洁：

```c++
int numSquares(int n) {
    vector<int> dp(n+1,INT_MAX);
    dp[0] = 0;
    int t;
    for(int i = 1;i <= n;i++) {
        for(int j=1;(t = j*j) <= i;j++){
            dp[i] = min(dp[i],dp[i-t]+1);
        }
        //cout << dp[i] << endl;
    }
    return dp[n];
}
```