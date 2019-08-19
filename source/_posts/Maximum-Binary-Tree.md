---
title: Maximum Binary Tree
date: 2019-03-21 11:31:43
tags:
- LeetCode
- Tree
categories:
- LeetCode
---

> 第15天。

今天的题目是[Maximum Binary Tree](https://leetcode.com/problems/maximum-binary-tree/)。

并不难的一道题，而且不同寻常的是用栈去做比用递归去做要方便一点。

我这里的想法是，从左向右一直插入就好了，例如输入是`[3, 2, 1, 6, 0, 5]`

先插入 3 ，然后插入下一个元素时进行讨论：

- 如果比上一次插入的元素要小，我就直接插入到上一次插入节点的右孩子处就好了。
- 如果比上一次插入的元素要大，我就用栈回溯到上上次插入节点的位置，进行判断，以此类推。
	- 如果在栈中找到了，我就将新元素插入到该节点的右孩子处，并把原来的右子树当成是新元素的左子树。
	- 如果没在栈中找到，我就把新元素当成新的根节点，并把原来的数当成新元素的左子树。

代码如下：

```c++
TreeNode* constructMaximumBinaryTree1(vector<int>& nums) {
	if (nums.size() == 0) return nullptr;
	
	stack<TreeNode*> st;
	
	auto end = nums.end();
	
	TreeNode *root = new TreeNode(nums[0]);
	TreeNode *p = root;
	
	st.push(root);
	
	for(auto it = nums.begin() + 1; it != end; ++it) {
		int val = *it;
		TreeNode *t = new TreeNode(val);
		
		if (val < p->val) {
			p->right = t;
		} else {
			while(!st.empty() && val > st.top()->val) st.pop();
			if (!st.empty()) {
				p = st.top();
				t->left = p->right;
				p->right = t;
			} else {
				t->left = root;
				root = t;
			}
		}
		p = t;
		st.push(p);
	}
	
	return root;
}
```