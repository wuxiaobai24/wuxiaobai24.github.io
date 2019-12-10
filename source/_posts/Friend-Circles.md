---
title: Friend Circles
date: 2019-12-10 13:34:41
tags:
- LeetCode
categories: LeetCode
---

> 第34天。

今天的题目是[Friend Circles](https://leetcode.com/problems/friend-circles/):

一道图论的题目，求连通分量的个数。这道题之前考研复试面试时遇到过。

用并查集去做会比较快，但是需要对并查集做一定修改。

简单来说，并查集的数组全初始化为0，然后在遍历到`M[i][j]==true`时进行`union`操作.

遍历完后，`arr`中值为`-1`的元素的个数就是连通分量的个数：

```c++
vector<int> arr;
int root(vector<int> &arr, int i) {
    int root = i;
    while(arr[root] != -1) root = arr[root];
    return root;
}
void unionFunc(int i, int j) {
    i = root(arr, i); 
    j = root(arr, j);
    if (i == j) return;
    arr[j] = i;
}
int findCircleNum(vector<vector<int>>& M) {
    if (M.size() == 0) return 0;
    
    int size = M.size();
    arr = vector<int>(size, -1);
    
    for(int i = 0;i < size; i++) {
        for(int j = i+1;j < size; j++) {
            if (M[i][j]) {
                unionFunc(i, j);
            }   
        }
    }
    
    int res = 0;
    for(int i = 0;i < size; i++) res += (arr[i] == -1);
    return res;
}
```
