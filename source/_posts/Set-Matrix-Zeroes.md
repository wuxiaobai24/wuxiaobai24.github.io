---
title: Set-Matrix-Zeroes
date: 2018-02-16 21:32:14
tags:
- LeetCode
---

第102天。

今天的题目是[Set Matrix Zeroes](https://leetcode.com/problems/set-matrix-zeroes/description/):

> Given a m x n matrix, if an element is 0, set its entire row and column to 0. Do it in place.

虽然题目看起来很简单，但是还是有一些坑点的，因为你一检测到一个`0`就马上把它所在的行和列置零，这样会影响到后面检测零的操作（因为无法区分是否被修改过），所以一般都是先记录下`0`的位置或者需要置零的行和列，然后在进行置零。

这题的时间复杂度基本都是`O(m*n)`,所以这里比较关注空间复杂度：

这里给出一个`O(m+n)`的解法：

```c++
void setZeroes1(vector<vector<int>>& matrix) {
    if (matrix.size() == 0) return ;
    
    //O(m + n)
    vector<bool> row(matrix.size(),false);
    vector<bool> col(matrix[0].size(), false);

    //记录哪几行和哪几列需要置零
    for(int i = 0;i < matrix.size();i++) 
        for(int j = 0;j < matrix[0].size(); j++)
            if (matrix[i][j] == 0) row[i] = col[j] = true;

    //进行置0
    
    for(int i = 0;i < matrix.size();i++)
        if (row[i]) {
            for(int j = 0;j < matrix[0].size(); j++) matrix[i][j] = 0;
        }
    
    for(int i = 0;i < matrix[0].size();i++)
        if (col[i]) {
            for(int j = 0;j < matrix.size(); j++) matrix[j][i] = 0;
        }
}
```


然后因为一行中只要有一个为`0`就可以直接对整行置零（还是先把整行扫描完的，不然某列本应该置零的却没有记录下来），所以我们可以在扫描一行的时候用一个flag来记录是否要置零，一旦扫完此行就马上置零，这样空间复杂度就减少成`O(n)`:

```c++
void setZeroes2(vector<vector<int>> &matrix) {
    //O(n)
    if (matrix.size() == 0) return ;
    bool setzero;
    vector<bool> col(matrix[0].size(), false);
    
    for(int i = 0;i < matrix.size();i++) {
        setzero = false;
        for(int j = 0;j < matrix[0].size();j++) {
            if (matrix[i][j] == 0) { 
                setzero = true;
                col[j] = true;
            }
        }
        for(int j = 0;setzero && j < matrix[0].size();j++) {
            matrix[i][j] = 0;
        }    
    }
    
    for(int i = 0;i < matrix[0].size();i++) {
        if (col[i] == false) continue;
        for(int j = 0;j < matrix.size(); j++)
            matrix[j][i] = 0;
    }
}
```

然后题目上提到可以用`O(1)`的空间复杂度来实现，然后就是需要重用空间啦，这里重用第一行来实现：

```c++
void setZeroes(vector<vector<int>> &matrix) {
    int m = matrix.size();
    if (m == 0) return ;
    int n = matrix[0].size();
    
    //重用第一行来去掉额外的空间
    bool setzero = false, raw0 = false;
    
    for(int i = 0;i < n;i++)
        if (matrix[0][i] == 0) { raw0 = true; break; }
    
    for(int i = 1;i < m;i++) {
        setzero = false;
        for(int j = 0;j < n;j++)
            if (matrix[i][j] == 0) {
                setzero = true;
                matrix[0][j] = 0;
            }
        for(int j = 0;setzero && j < n;j++) matrix[i][j] = 0;
    }
    
    for(int i = 0;i < n;i++) {
        for(int j = 0;j < m;j++) {
            if (matrix[0][i] == 0) matrix[j][i] = 0;
        }
        if (raw0) matrix[0][i] = 0;
    }
}
```