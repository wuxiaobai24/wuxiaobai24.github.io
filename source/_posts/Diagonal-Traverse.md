---
title: Diagonal Traverse
date: 2019-11-16 10:16:52
tags:
- LeetCode
categories: LeetCode
---

> 第12天。

今天的题目是[Diagonal Traverse](https://leetcode.com/problems/diagonal-traverse/)：

---

Given a matrix of M x N elements (M rows, N columns), return all elements of the matrix in diagonal order as shown in the below image.

 

**Example:**

```
Input:
[
 [ 1, 2, 3 ],
 [ 4, 5, 6 ],
 [ 7, 8, 9 ]
]

Output:  [1,2,4,7,5,3,6,8,9]

Explanation:
```

 ![](https://assets.leetcode.com/uploads/2018/10/12/diagonal_traverse.png)

**Note:**

The total number of elements of the given matrix will not exceed 10,000.

---

这道题好像是之前没做出来的。

题意很好理解，这道题的关键就在于如何处理在边界时的移动。

首先，常规的移动就分为两种：

- 向右上移动
- 向左下移动

实现常规移动，这里就不赘述了。

然后就是在边界时如何移动了，经过观察移动的情况，我们可以总结出：

- 边界时，只有向右移动和向下移动两种情况
- 在向右上移动时遇到边界，优先向右移动
- 在向左下移动时遇到边界，优先向左移动

根据上面的结论，我们就可以写出代码了：

```c++
bool nextRightUp(int &i, int &j, int &m, int &n) {

    if (i - 1 >= 0 && j + 1 < n) { // move right up
        i--; j++; return true;
    } else if (j + 1 < n) { // move right
        j++; return false;
    } else if (i  + 1 < m){ // move down
        i++; return false;
    }
    return false; // mean in the last elem
}
bool nextLeftDown(int &i, int &j, int &m, int &n) {
    if (i + 1 < m && j -1 >= 0) { // move right up
        i++; j--; return true;
    } else if (i + 1 < m) { // move down 
        i++; return false;
    } else if (j + 1  < n) { // move right
        j++; return false;
    }
    return false; 
}
vector<int> findDiagonalOrder(vector<vector<int>>& matrix) {
    int m = matrix.size();
    vector<int> res;
    if (m == 0) return res;
    int n = matrix[0].size();
    int i = 0, j = 0;
    bool up = true;

    for(int k = 0;k < m*n;k++) {
        res.push_back(matrix[i][j]);
        if (up) {
            up = nextRightUp(i, j, m, n);
        } else {
            up = !nextLeftDown(i, j, m, n);
        }
    }

    return res;
}
```

