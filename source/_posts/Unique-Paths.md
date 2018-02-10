---
title: Unique Paths
date: 2017-10-18 10:55:35
categories: LeetCode
tags:
- LeetCode
- 动态规划
---

第25天。

感冒真难受！

今天的题目是[Unique Paths](https://leetcode.com/problems/unique-paths/description/):

> A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).
>
>The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).
>
> How many possible unique paths are there?
> Note: m and n will be at most 100.

如果自己尝试几次去找的话，我们可以发现在`m=1`时或`n=1`时，只要一种可能，然后我们考虑我们现在位于`(m,n)`点`（m!=1,n!=1)`，现在要走向`(0,0)`,因为我们被限制到只能向下或下右走，即只能`n-1`或`m-1`，所以我们可以找到这样一个等式`uniquePaths(m,n) = uniquePaths(m-1,n) + uniquePaths(m,n-1)`，当`m!=1,n!=1`时，所以我们可以很快的写出下面的解决方案：

```c++
int uniquePaths(int m, int n) {
    if (m == 1 || n == 1) return 1;
    return uniquePaths(m-1,n) + uniquePaths(m,n-1);
}
```

但是这个会时间超限，因为我们做了很多重复的计算，因为我们计算`uniquePaths(3,2)`时需要计算`uniquePaths(2,2)`,而`uniquePaths(2,1)`也需要计算一遍，这就导致了很多重复计算。

我们考虑使用一个表来记录`uniquePaths`值，这样就可以减少每次计算的值了:

```c++
int uniquePaths(int m, int n) {
    int *p = new int[m*n];
    for(int i = 0;i < n;i++)
        p[i] = 1;
    for(int j = 0;j < m;j++)
        p[n*j] = 1;

    for(int i = 1;i < m;i++)
        for(int j = 1;j < n;j++)
            p[i*n+j] = p[ (i-1)*n +j ] + p[i*n + j - 1];

    return p[m*n-1];
    }
```

这样就不会时间超限了。

然后是在`dicuss`中看到的：

```c++
int uniquePaths(int m, int n) {
    vector<vector<int> > path(m, vector<int> (n, 1));
    for (int i = 1; i < m; i++)
        for (int j = 1; j < n; j++)
            path[i][j] = path[i - 1][j] + path[i][j - 1];
    return path[m - 1][n - 1];
}
```

(捂脸)我一直不知道怎么用`vector`来快速的构造二维数组。

上面的两个的空间复杂度都是`O(m*n)`，下面的方法可以降成`O(2*min(m,n))`，因为我们计算某一层的时候其实只需要前一行即可：

```c++
int uniquePaths(int m, int n) {
    if (m > n) return uniquePaths(n, m); 
    vector<int> pre(m, 1);
    vector<int> cur(m, 1);
    for (int j = 1; j < n; j++) {
        for (int i = 1; i < m; i++)
            cur[i] = cur[i - 1] + pre[i];
        swap(pre, cur);
    }
    return pre[m - 1];
}
```

然后其实还可以继续降低到`O(min(m,n))`,只需要一个一维数组即可:

```c++
int uniquePaths(int m, int n) {
    if (m > n) return uniquePaths(n, m);
    vector<int> cur(m, 1);
    for (int j = 1; j < n; j++)
        for (int i = 1; i < m; i++)
            cur[i] += cur[i - 1]; 
    return cur[m - 1];
}
```

