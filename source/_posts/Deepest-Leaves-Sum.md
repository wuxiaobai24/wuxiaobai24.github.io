---
title: Deepest Leaves Sum
date: 2020-01-31 17:08:45
tags:
- LeetCode
categories: LeetCode
---

> 第62天。

今天的题目是[Deepest Leaves Sum](https://leetcode.com/problems/deepest-leaves-sum/):

比较简单的题目，只要用层次遍历即可，计算每一层的和，然后把最后一层返回即可。也可以用后序遍历来完成，不过要维护每个子树的高度。

```c++
int deepestLeavesSum(TreeNode* root) {
	if (root == nullptr) return 0;
	queue<TreeNode *> q;
	q.push(root);
	int sum = 0;
	while(!q.empty()) {
		sum = 0;
		for(int i = 0, size = q.size(); i < size; i++) {
			root = q.front(); q.pop();
			sum += root->val;
			if (root->left) q.push(root->left);
			if (root->right) q.push(root->right);
		}
	}
	return sum;
}
```
