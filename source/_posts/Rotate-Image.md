---
title: Rotate-Image
date: 2018-01-23 12:28:20
categories: LeetCode
tags:
- LeetCode
---

第92天。

今天的题目是[Rotate Image](https://leetcode.com/problems/rotate-image/description/):

> You are given an n x n 2D matrix representing an image.
>
> Rotate the image by 90 degrees (clockwise).
>
> Note:
> You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.
>
> Example 1:

```python
Given input matrix = 
[
  [1,2,3],
  [4,5,6],
  [7,8,9]
],

rotate the input matrix in-place such that it becomes:
[
  [7,4,1],
  [8,5,2],
  [9,6,3]
]
```

> Example 2:

```python
Given input matrix =
[
  [ 5, 1, 9,11],
  [ 2, 4, 8,10],
  [13, 3, 6, 7],
  [15,14,12,16]
], 

rotate the input matrix in-place such that it becomes:
[
  [15,13, 2, 5],
  [14, 3, 4, 1],
  [12, 6, 8, 9],
  [16, 7,10,11]
]
```

虽然是一道`Medium`的题目，但是还是比较简单的。

主要的思路是一圈一圈的进行旋转，不断缩减，直到不需要旋转的时候：

```c++
void rotate(vector<vector<int>>& matrix) {
    int beg = 0, end = matrix.size() - 1;
    int temp;
    while(beg < end) {
        int size = end - beg;
        for(int i = 0;i < size;i++) {
            temp = matrix[beg+i][beg];
            matrix[beg+i][beg] = matrix[end][beg+i];
            matrix[end][beg+i] = matrix[end-i][end];
            matrix[end-i][end] = matrix[beg][end-i];
            matrix[beg][end-i] = temp;
        }
        beg++; end--;
    }
}
```