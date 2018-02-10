---
title: Balanced Binary Tree
date: 2017-11-13 21:08:54
categories: LeetCode
tags:
- LeetCode
- Tree
---

第47天。

今天的题目是[Balanced Binary Tree](https://leetcode.com/problems/balanced-binary-tree/description/):

> Given a binary tree, determine if it is height-balanced.
>
> For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two subtrees of every node never differ by more than 1.

题目意思是对这个树的每个结点来说它左子树和右子树的高度差都不大于1,我们可以把它转换成一个求高度的问题：

```c++
bool isBalanced(TreeNode* root) {
    int h = 0;
    return isBalanced(root,h);
}
bool isBalanced(TreeNode *root,int &height) {
    if (root == nullptr) { height = 0; return true; }
    int left,right;
    if (!isBalanced(root->left,left) || !isBalanced(root->right,right))
        return false;

    if (abs(left - right) > 1) return false;

    height = max(left,right) + 1;
    return true;
}
```

准备把主力语言往`python`和`c`上靠，所以以后都会写多一个`python`的解法。

```python
class Solution:
    def isBalanced(self,root):
        """
        :type root: TreeNode
        :rtype: bool
        """
        res,height = self.isBalancedRec(root)
        return res

    def isBalancedRec(self, root):
        """
        :type root: TreeNode
        :rtype: bool,int
        """
        if root is None:
            return True,0

        leftRes,leftH = self.isBalancedRec(root.left)
        rightRes,rightH = self.isBalancedRec(root.right)

        if leftRes == False or rightRes == False:
            return False,max(leftH,rightH)
        else:
            return abs(leftH-rightH) <= 1,max(leftH,rightH)+1
```