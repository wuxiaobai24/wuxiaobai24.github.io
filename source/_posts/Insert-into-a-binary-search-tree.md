---
title: Insert into a binary search tree
date: 2019-12-01 10:41:18
tags:
- LeetCode
categories: LeetCode
---

> 第25天。

今天的题目是[Insert into a binary search tree](https://leetcode.com/problems/insert-into-a-binary-search-tree/submissions/):

看名字就知道是水题，就是在BST中插入一个节点罢了，所以只需要递归查找到插入的位置，然后 new 一个 TreeNode即可：

```c++
TreeNode* insertIntoBST(TreeNode* root, int val) {
    if (root == nullptr) {
        return new TreeNode(val);
    }
    else if (root->val > val) root->left = insertIntoBST(root->left, val);
    else if (root->val < val) root->right = insertIntoBST(root->right, val);
    return root;
}
```