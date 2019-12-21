---
title: Binary Search Tree to Greater Sum Tree
date: 2019-12-21 10:26:41
tags:
- LeetCode
categories: LeetCode
---

> 第45天。

今天的题目是[Binary Search Tree to Greater Sum Tree](https://leetcode.com/problems/binary-search-tree-to-greater-sum-tree/):

感觉这道题的题意很奇怪，不清不楚的，不过看Example还是看的出他问的是什么的，挺简单的题目：

```c++
TreeNode* bstToGst(TreeNode* root) {
    if (root == nullptr) return root;
    int sum = 0;
    return bstToGst(root, sum);
}

TreeNode* bstToGst(TreeNode* root, int &sum) { 
    if (root == nullptr) return root;
    // TreeNode *node = new TreeNode(root->val);
    root->right = bstToGst(root->right, sum);
    root->val = sum = root->val + sum;
    root->left = bstToGst(root->left, sum);
    return root;
}
```
