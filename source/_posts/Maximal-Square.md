---
title: Maximal-Square
date: 2017-11-16 19:48:47
categories: LeetCode
tags:
- DP
---

第50天。

恍恍惚惚，就50天了。

今天的题目是[Maximal Square](https://leetcode.com/problems/maximal-square/description/):

> Given a 2D binary matrix filled with 0's and 1's, find the largest square containing only 1's and return its area.
>
> For example, given the following matrix:
>

```python
1 0 1 0 0
1 0 1 1 1
1 1 1 1 1
1 0 0 1 0
```

> Return 4.

让人很意外，这是一道动态规划的题目。

先说说我的非动态规划的解法：

大概的想法是，做一次遍历，每次遇到`1`,就向下拓展，如果扩展，扩展的方法是就是只需要看当前正方形的外围是否都是`1`，如果都是`1`,那么我们就可以继续向下扩展，这样就可以遍历出一个正方形，然后我们在对`matrix`进行遍历的时候还可以通过当前的最大面积来提早结束遍历：

```python
def expend(self,matrix,i,j,ret):
    """
    :type matrix: List[List[str]]
    :type i: int
    :type j: int
    :type ret: int
    :rtype ret
    """
    if i >= len(matrix) or j >= len(matrix[0]):
        return ret
    for k in range(ret+1):
        if matrix[i][j - k] == '0' or matrix[i-k][j] == '0':
            return ret
    return self.expend(matrix,i+1,j+1,ret+1)

def maximalSquare1(self, matrix):
    """
    :type matrix: List[List[str]]
    :rtype: int
    """
    ret,i = 0,0
    while i + ret < len(matrix):
        j = 0
        while j + ret < len(matrix[0]):
            if matrix[i][j] == '1':
                ret = max(ret,self.expend(matrix,i+1,j+1,1))
            j += 1
        i += 1
    return ret*ret
```

挺暴力的方法，不知道是不是因为可以提前结束，所以这个方法也直接AC了。

然后是`DP`的解法。

在解决这个问题之前，我们先考虑如果求出以`matrix[i][j]`为右下角的正方形最大面积。

如果`matrix[i][j] = '0'`,那么显然`size[i][j] = 0`
如果`matrix[i][j] = '1'`,那么我们需要考虑其向上，向左，向左上的最大面积。

假设`size[i-1][j-1] = 2`,则我们至少可以知道：

```python
[
    [1,1,*]
    [1,1,*]
    [*,*,-]
]
```

如果`size[i][j-1] = 2`,我们至少知道：

```python
[
    [*,*,*]
    [1,1,*]
    [1,1,-]
]
```

如果`size[i-1][j] = 2`,我们至少知道：

```python
[
    [*,1,1]
    [*,1,1]
    [*,*,-]
]
```

从上面可以看出来，只有当`size[i-1][j-1] == 2 and size[i][j-1] == 2 and size[i-1][j-1] == 2`时，`size[i][j] == 3`,

则我们可以得出以下递推式：

`size[i][j] = min(size[i-1][j-1],size[i][j-1],size[i-1][j])+1 if matrix[i][j] == '1'`
`size[i][j] = 0 if matrix[i][j] == '0'`

然后我们还需要考虑一下边界条件，因为当`i=0`或`j=0`时，上面的递推式是没有考虑到的，我们再加上：

`size[i][j] = (matrix[i][j] == '1') where i == 0 or j == 0`

然后我们就可以写出以下解法：

```python
def maximalSquare(self,matrix):
    if len(matrix) == 0:
        return 0
    dp1 = []
    ret = 0
    for i in range(len(matrix[0])):
        t = int(matrix[0][i] == '1')
        dp1.append(t)
        ret = max(ret,t)
    for i in range(1,len(matrix)):
        dp2 = [ 0 for i in range(len(matrix[0])) ]
        dp2[0] = int(matrix[i][0] == '1')
        ret = max(dp2[0],ret)
        for j in range(1,len(matrix[0])):
            if matrix[i][j] == '1':
                dp2[j] = min(min(dp1[j-1],dp1[j]),dp2[j-1]) + 1
            ret = max(ret,dp2[j])
        dp1 = dp2
    return ret*ret
```
