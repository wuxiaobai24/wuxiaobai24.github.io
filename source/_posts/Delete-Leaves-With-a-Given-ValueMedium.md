---
title: Delete Leaves With a Given Value Medium
date: 2020-02-02 15:03:20
tags:
- LeetCode
categories: LeetCode
---

> 第63天。

水题。

今天的题目是[Delete Leaves With a Given Value Medium](https://leetcode.com/problems/delete-leaves-with-a-given-value/):

太水了，不解释了。

```c++
TreeNode* removeLeafNodes(TreeNode* root, int target) {
	if (root == nullptr) return nullptr;
	root->left = removeLeafNodes(root->left, target);
	root->right = removeLeafNodes(root->right, target);
	if (!root->left && !root->right && target == root->val)
		return nullptr;
	else 
		return root;
}
```