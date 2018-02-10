---
title: Path-Sum
date: 2017-11-29 12:50:19
categories: LeetCode
tags:
- LeetCode
- Tree
---

第63天。

赶算法实验，再水一题。

今天的题目是[Path Sum](https://leetcode.com/problems/path-sum/description/):

> Given a binary tree and a sum, determine if the tree has a root-to-leaf path such that adding up all the values along the path equals the given sum.
>
> For example:
> Given the below binary tree and sum = 22,

              5
             / \
            4   8
           /   / \
          11  13  4
         /  \      \
        7    2      1

> return true, as there exist a root-to-leaf path 5->4->11->2 which sum is 22.

比较简单，但是有一些坑点。

* 它要求一定要到`left`.
* 然后空节点不能当成`0`.

然后是代码：

```c++
bool hasPathSum(TreeNode* root, int sum) {
    if (!root ) return false;
    if (!root->left && !root->right) return sum == root->val;
    if (!root->left) return hasPathSum(root->right,sum-root->val);
    if (!root->right) return hasPathSum(root->left,sum - root->val);
    return hasPathSum(root->left,sum - root->val) || hasPathSum(root->right,sum - root->val);
}
```

其实`dicuss`中的更精炼一点：

```c++
bool hasPathSum(TreeNode *root, int sum) {
    if (root == NULL) return false;
    if (root->val == sum && root->left ==  NULL && root->right == NULL) return true;
    return hasPathSum(root->left, sum-root->val) || hasPathSum(root->right, sum-root->val);
}
```
