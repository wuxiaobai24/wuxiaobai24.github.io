---
title: Same-Tree
date: 2018-01-26 11:44:17
categories: LeetCode
tags:
- LeetCode
---

第95天。

今天的题目比较水。

今天的题目是[Same Tree](https://leetcode.com/problems/same-tree/description/):

> Given two binary trees, write a function to check if they are the same or not.

> Two binary trees are considered the same if they are structurally identical and the nodes have the same value.

太简单了，不做太多解释了:

```c++
bool isSameTree(TreeNode* p, TreeNode* q) {
    if (p == nullptr && q == nullptr) return true;
    else if (p && q) {
        return q->val == p->val && isSameTree(p->left,q->left) && isSameTree(p->right,q->right);
    } else return false;
}
```