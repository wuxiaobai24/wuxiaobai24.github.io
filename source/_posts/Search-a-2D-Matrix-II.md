---
title: Search-a-2D-Matrix-II
date: 2018-01-27 10:30:43
categories: LeetCode
tags:
- LeetCode
---

第96天。

今天的题目是[Search a 2D Matrix II](https://leetcode.com/problems/search-a-2d-matrix-ii/description/):

> Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:
>
> Integers in each row are sorted in ascending from left to right.
> Integers in each column are sorted in ascending from top to bottom.
> For example,
>
> Consider the following matrix:
>

```python
[
  [1,   4,  7, 11, 15],
  [2,   5,  8, 12, 19],
  [3,   6,  9, 16, 22],
  [10, 13, 14, 17, 24],
  [18, 21, 23, 26, 30]
]
```

> Given target = 5, return true.
>
> Given target = 20, return false.

以前好像看过这道题，但是应该嫌麻烦没做，今天做了一下，感觉好像也不是很难的样子，二分查找的升级版（在2维情况下）：

```c++
bool searchMatrix(vector<vector<int>>& matrix, int target) {
    int n = matrix.size();
    if (n == 0) return false;
    int m = matrix[0].size();
    return searchMatrix(matrix,0,n-1,0,m-1,target);
}

bool searchMatrix(vector<vector<int> > &matrix, int xlow, int xhigh, int ylow, int yhigh, int target) {

    //cout << xlow << " " << xhigh << endl
    //   << ylow << " " << yhigh << endl;

    if (xlow > xhigh || ylow > yhigh) return false;
    int xmid = (xlow + xhigh)/2, ymid = (ylow + yhigh)/2;
    if (matrix[xmid][ymid] == target) return true;
    else if (matrix[xmid][ymid] < target) 
        return searchMatrix(matrix,xmid + 1, xhigh, ylow, yhigh,target) ||
                searchMatrix(matrix,xlow, xhigh, ymid + 1, yhigh, target);
    else 
        return searchMatrix(matrix, xlow, xmid-1, ylow, yhigh,target) ||
                searchMatrix(matrix,xlow, xhigh, ylow, ymid-1, target);
}
```


为什么`dicuss`的解法大多都是:

```c++
bool searchMatrix(vector<vector<int>>& matrix, int target) {
    int i = 0;
    int j = matrix[0].size() - 1;

    while(i < matrix.size() && j >= 0) {
        if(matrix[i][j] == target)
            return true;

        if(matrix[i][j] < target)
            i++;
        else
            j--;
    }

    return false;
}
```