---
title: Binary Tree Pruning
date: 2019-12-11 10:47:58
tags:
- LeetCode
categories: LeetCode
---

> 第35天。

今天的题目是[Binary Tree Pruning](https://leetcode.com/problems/binary-tree-pruning/):

简单题，用先序遍历做就好了，而且不需要使用`flag`或`count`等额外的变量来判断是否要删除当前节点。

大概逻辑如下：

先序遍历时，用`left = pruneTree(left)`的方式去调用，在遍历完子树后，当前节点的子树都是只包含`1`的树了，我们可以通过判断指针是否为空来确定子树中是否有`1`，进而判断出是否要删除当前节点，所以我们不需要维护额外的变量来判断。

```c++
TreeNode* pruneTree(TreeNode* root) {
    if (root == nullptr) return nullptr;
    root->left = pruneTree(root->left);
    root->right = pruneTree(root->right);
    if (root->left || root->right || root->val == 1) return root;
    delete root;
    return nullptr;
}
```