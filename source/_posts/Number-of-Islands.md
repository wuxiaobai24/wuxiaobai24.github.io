---
title: Number of Islands
date: 2017-11-01 10:25:07
categories: LeetCode
tags:
- LeetCode
---

第37天。

今天的题目[Number of Islands](https://leetcode.com/problems/number-of-islands/description/)比较简单，而且感觉好像做过的样子：

> Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.
>
> Example 1:
>
> 11110
> 11010
> 11000
> 00000
> Answer: 1
>
> Example 2:
>
> 11000
> 11000
> 00100
> 00011
> Answer: 3

解法相当简单，只要遍历所有点，然后如何当前点是`1`,就将计数加一，然后进行扩展，所谓的扩展就是将当前点的值至为`0`,然后向上下左右进行查找，如果还是`1`就递归调用扩展。

```c++
    int numIslands(vector<vector<char>>& grid) {
        if (grid.size() == 0 || grid[0].size() == 0) return 0;
        int count = 0;

        for(int i = 0;i < grid.size();i++) {
            for(int j = 0;j < grid[0].size();j++) {
                if (grid[i][j] == '1') {
                    cout << "(" << i << "," << j << ")\n";
                    count++;
                    expend(grid,i,j);
                }
            }
        }
        return count;
    }
    void expend(vector<vector<char> > &grid,int x,int y) {
        if ( x < 0 || y < 0 ||
            x >= grid.size() || y >= grid[0].size() ||
           grid[x][y] == '0' ) return;
        //cout << x << " " << y << endl;
        grid[x][y] = '0';
        expend(grid,x-1,y);
        expend(grid,x+1,y);
        expend(grid,x,y-1);
        expend(grid,x,y+1);
    }
``

因为`dicuss`中的做法都是一样的，所以就不贴`dicuss`的代码了。