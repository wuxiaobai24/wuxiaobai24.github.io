---
title: Spiral Matrix
date: 2019-03-03 11:22:31
tags:
- LeetCode
- Array
categories:
- LeetCode
---

> 第四天，这又是一道之前没AC掉的题目。

今天的题目是[54. Spiral Matrix](https://leetcode.com/problems/spiral-matrix/)

题意比较好理解，写的时候注意一下下标变换即可，最好现在纸上把给出的测例手动跑一下。

个人觉得，最大的坑点在第二个测例中已经给出来了，如果遇到`[[1], [2]]`或`[[1, 2]]`这种长条的要怎么做。

其实我们把他当成特殊例子即可，当所给出的矩阵的行列长度不一样时，最后一定会遇到上面的情况，这样我们可以先把正常的搞定，然后在最后面处理这两种情况即可。

这道题的主要思路是，我们模拟螺旋式的走法移动下标，然后一圈一圈的去游走即可，这里的代码不难，想清楚下标变换即可，最后一圈需要处理，因为最后一圈可能是三种情况：

- 只有一个元素
- 多个元素排成一列
- 多个元素排成一行

对于上面的三种情况，如果用之前模拟螺旋的方法，很容易走多了几步，其实只要简单的用两重循环即可。

代码如下：

```c++
class Solution {
public:
    vector<int> spiralOrder(vector<vector<int>>& matrix) {
        vector<int> res;
        
        int istart = 0, iend = matrix.size()-1;
        if (iend == -1) return res;
        int jstart = 0, jend = matrix[0].size()-1;
        
        // printf("%d %d %d %d\n", istart, iend, jstart, jend);
        
        while(istart < iend && jstart < jend) {
            int i = istart, j = jstart;
            // ->
            for(;j <= jend; j++)
                res.push_back(matrix[i][j]);
            j--; i++;
            // |
            // V
            for(;i <= iend; i++)
                res.push_back(matrix[i][j]);
            i--; j--;;
            
            // <-
            for(;j >= jstart; j--)
                res.push_back(matrix[i][j]);
            j++; i--;
            // ^
            // |
            for(;i > istart; i--)
                res.push_back(matrix[i][j]);
            
            istart++; iend--;
            jstart++; jend--;
            // for(auto i: res) cout << i << " ";
            // cout << endl;
        }
        /// cout << "----" << endl;
        for(int i = istart; i <= iend;i++)
            for(int j = jstart; j <= jend; j++)
                res.push_back(matrix[i][j]);
        
        return res;
    }
};
```
