---
title: Flip Equivalent Binary Trees
date: 2020-01-05 21:16:03
tags:
- LeetCode
categories: LeetCode
---

> 第56天。

今天的题目是[Flip Equivalent Binary Trees](https://leetcode.com/problems/flip-equivalent-binary-trees/):

简单题，先序遍历判断当前节点的值是否相等，如果不相等则返回`false`，如果相等的话，判断两个子树是否`filpEquiv`：

```c++
bool flipEquiv(TreeNode* root1, TreeNode* root2) {
    if (!root1 && !root2) return true;
    else if (root1 && root2 && root1->val == root2->val) {
        return (flipEquiv(root1->left, root2->left) && flipEquiv(root1->right, root2->right))
                || (flipEquiv(root1->left, root2->right) && flipEquiv(root1->right, root2->left));    
    } else return false;
}
```