---
title: Word Search
date: 2017-10-21 11:21:03
categories: LeetCode
tags:
- LeetCode
---

第28天。

今天的题目是[Word Search](https://leetcode.com/problems/word-search/description/)：

> Given a 2D board and a word, find if the word exists in the grid.
>
> The word can be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once.
>
> For example,
> Given board =

```python
[
  ['A','B','C','E'],
  ['S','F','C','S'],
  ['A','D','E','E']
]
```

> word = "ABCCED", -> returns true,
> word = "SEE", -> returns true,
> word = "ABCB", -> returns false.

这道题想起来不难，就是有点繁琐，有几个要点需要考虑：

* 每个元素只能用一次
* 字符只要求是临接的，即可能有四个方向需要考虑。


因为每个元素只能用一次，所以我们需要一个方式来记录这个位置是否被使用，简单的方法就是直接用一个二维数组来记录，然后我们需要考虑是否越过边界:

```c++
bool search(vector<vector<char> > &board,vector<vector<bool> > &used,string &word,int beg,int i,int j) {
    //找到了
    if (beg == word.size() ) return true;
    //边界检测
    if (i < 0 || j < 0 || i >= board.size() || j >= board[0].size() ) return false;
    //检测是否被使用了
    if (used[i][j]) return false;
    //检测是否是想要的字符
    if (word[beg] != board[i][j]) return false;
    //假设这就是正确的路径
    used[i][j] = true;
    //向四个方向查找
    if( search(board,used,word,beg+1,i-1,j) || search(board,used,word,beg+1,i+1,j)
        || search(board,used,word,beg+1,i,j-1) || search(board,used,word,beg+1,i,j+1)
        )
        return true;
    else {
        //如果四个方法都失败了，说明了这个路径是错的，所以回溯。
        used[i][j] =  false;
        return false;
    }
}
bool exist(vector<vector<char>>& board, string word) {
    //保证至少有一个元素
    if (board.size() == 0 || board[0].size() == 0) return false;
    //创建一个二维数组来记录是否字符是否被使用
    vector<bool> vec(board[0].size(),false);
    vector<vector<bool> > used ( board.size(),vec );

    //以每一个点为起点进行查找
    for(int i = 0;i < board.size();i++)
        for(int j = 0;j < board[0].size();j++) {
            if (word[0] == board[i][j] && search(board,used,word,0,i,j))
                return true;
        }
    return false;
}
```

上面的方法使用了一个二维数组来记录元素是否被使用,其实可以直接在`board`中记录是否被使用:

```c++
int m;
int n;
bool exist(vector<vector<char> > &board, string word) {
    m=board.size();
    n=board[0].size();
    for(int x=0;x<m;x++)
        for(int y=0;y<n;y++)
        {
            if(isFound(board,word.c_str(),x,y))
                return true;
        }
    return false;
}
bool isFound(vector<vector<char> > &board, const char* w, int x, int y)
{
    if(x<0||y<0||x>=m||y>=n||board[x][y]=='\0'||*w!=board[x][y])
        return false;
    if(*(w+1)=='\0')
        return true;
    char t=board[x][y];
    board[x][y]='\0';
    if(isFound(board,w+1,x-1,y)||isFound(board,w+1,x+1,y)||isFound(board,w+1,x,y-1)||isFound(board,w+1,x,y+1))
        return true; 
    board[x][y]=t;
    return false;
}
```