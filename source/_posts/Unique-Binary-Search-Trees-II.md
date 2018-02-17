---
title: Unique-Binary-Search-Trees-II
date: 2018-02-17 20:52:51
tags: 
- LeetCode
- 二叉树
---

第103天。

今天的题目是[95. Unique Binary Search Trees II](https://leetcode.com/problems/unique-binary-search-trees-ii/description/):

> Given an integer n, generate all structurally unique BST's (binary search trees) that store values 1...n.

> For example,
> Given n = 3, your program should return all 5 unique BST's shown below.

```python
   1         3     3      2      1
    \       /     /      / \      \
     3     2     1      1   3      2
    /     /       \                 \
   2     1         2                 3
```

比较有趣的一道题目，主要是怎么穷举出所以的可能，一开始我是想着将问题从`n`减少到`n-1`这样来做，后来发现好像这样很难弄的样子，后来突然想到我们可以利用`BST`的性质，即对于当前节点来说，左子树的节点的值一定比当前节点的小，右子树的节点的值一定比当前节点的大，那么我们可以这样来做：

比如如果`n = 3`，那么这棵树就由`[1,2,3]`组成，那么先确定根节点的值，确定根节点后就可以确定左子树中可能出现的值，和右子树中可能出现的值，这样我们就能将问题简化并递归求解下去了：

看代码吧，其实这次代码比较简单：

```c++
vector<TreeNode*> generateTrees(int n) {    
    return generateTrees(1,n);
}
vector<TreeNode *> generateTrees(int beg, int end) {
    vector<TreeNode *> ret;
    if (beg > end) return ret;
    
    for(int i = beg;i <= end;i++) {
        vector<TreeNode *> left = generateTrees(beg, i-1);
        vector<TreeNode *> right = generateTrees(i+1, end);
        
        if (left.size() == 0) left.push_back(nullptr);
        if (right.size() == 0) right.push_back(nullptr);
        
        for(auto l:left)
            for(auto r:right) {
                auto p = new TreeNode(i);
                p->left = l;
                p->right = r;
                ret.push_back(p);
            }
    }
    return ret;
}
```