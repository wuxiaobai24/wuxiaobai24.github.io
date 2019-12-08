---
title: Rotate Function
date: 2019-12-08 11:04:58
tags:
- LeetCode
categories: LeetCode
---

> 第32天。

今天的题目是[Rotate Function](https://leetcode.com/problems/rotate-function/)。

这道题是一道数学题，直接求解的话显然复杂度很高，然后这道题也没法把大问题化简到小问题，所以用常规的分治、动规和贪心去想这道题的话，是没法找到答案的。

为了解决这道题，我们先把 $F(k)$ 的写出来：

$$
F(k) = 0 * B_k[0] + 1 * B_k[1] + ... + (n - 1) * B_k[n-1]
$$

然后我们通过题意可以知道 $B_k[i] = A[(i+k) \% n]$ ，所以：

$$
\begin{aligned}
F(k) &= 0 * B_k[0] + 1 * B_k[1] + ... + (n - 1) * B_k[n-1] \\
     &= 0 * A[(0+k) \% n] + A[(1+k) \% n] + ... + (n - 1) * A[(n-1+k) \% n] \\
     &= \sum_{i=0}^{n-1} i * A[(i+k) \% n]
\end{aligned}
$$

我们可以尝试把 $(i + k) \% n$ 中的 取模运算去掉：

$$

\begin{aligned}
F(k) &= \sum_{i=0}^{n-1} i * A[(i+k) \% n] \\
     &= \sum_{i=1}^{n-k-1} i * A[i+k] + \sum_{i=n-k}^{n-1} i * A[i + k -n] \\
\end{aligned}

$$

我们把 $j = i - k$ 代入 $\sum_{i=1}^{n-k-1} i * A[i+k]$ 和 $j = i + k -n$ 代入 $\sum_{i=n-k}^{n-1} i * A[i + k -n]$ :

$$
\begin{aligned}
F(k) &= \sum_{j=k}^{n-1} (j - k) * A[j] + \sum_{j=0}^{k-1} (j + n -k) * A[j] \\
     & = \sum_{j=0}^{n-1} j * A[j] + n * \sum_{j=0}^{k-1} A[j] - k * \sum_{j=0}^{n-1} A[j]
\end{aligned}
$$

上面的公式中 $\sum_{j=0}^{n-1} j * A[j]$ 和 $\sum_{j=0}^{n-1} A[j]$ 都是常数，因此我们可以可以用 $O(n)$ 的时间复杂度解决这道题：

```c++
int maxRotateFunction(vector<int>& A) {
    if (A.size() == 0) return 0;
    long long s1 = 0, s2 = 0;
    for(int i = 0, size = A.size(); i < size; i++) {
        s1 += A[i];
        s2 += i*A[i];
    }
    long long res = LONG_MIN;
    long long t = 0;
    for(int k = 0, n = A.size();k < n; k++) {
        t += A[k];
        res = max(res,n * t - (k+1) * s1);
    }
    return res + s2;
}
```