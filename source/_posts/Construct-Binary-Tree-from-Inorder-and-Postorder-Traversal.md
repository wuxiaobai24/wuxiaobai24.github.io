---
title: Construct Binary Tree from Inorder and Postorder Traversal
date: 2020-01-07 09:29:42
tags:
- LeetCode
categories: LeetCode
---

> 第58天。

今天的题目是[Construct Binary Tree from Inorder and Postorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-inorder-and-postorder-traversal/):

一道很久之前嫌麻烦没做的题目，因为之前做过从中序遍历和先序遍历中重构二叉树了，所以从中序遍历和后序遍历重构二叉树就之前换一下取值的位置而已：

```c++
TreeNode* buildTree(vector<int>& inorder, vector<int>& postorder) {
    return buildTree(inorder, postorder, 0, inorder.size() - 1, 0, postorder.size() - 1);
}
int search(vector<int> &inorder, int beg, int end, int val) {
    while(beg <= end && inorder[beg] != val) beg++;
    return beg;
}
TreeNode* buildTree(vector<int>& inorder, vector<int>& postorder, int ibeg, int iend, int pbeg, int pend) {
    if (ibeg > iend || pbeg > pend) return nullptr;
    if (ibeg == iend || pbeg == pend) return new TreeNode(postorder[pend]);
    int val = postorder[pend];
    int mid = search(inorder, ibeg, iend, val);
    TreeNode *node = new TreeNode(val);
    int leftsize = mid - ibeg;
    node->left = buildTree(inorder, postorder, ibeg, mid-1, pbeg, pbeg + leftsize-1);
    node->right = buildTree(inorder, postorder, mid + 1, iend, pbeg + leftsize, pend-1);
    return node;
}
```