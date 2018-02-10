---
title: Merge Two Binary Trees
date: 2017-11-25 11:20:57
categories: LeetCode
tags:
- LeetCode
- Tree
---

第59天。

今天早上vpn挂了，然后好像学校IP有出现了点问题（貌似被人列入黑名单了）然后就一直出现`One more step`进行验证，最烦的是这个验证需要翻个墙，然后我就用手机开的wifi来写的题。

今天的题目是[Merge Two Binary Trees](https://leetcode.com/problems/merge-two-binary-trees/description/):

> Given two binary trees and imagine that when you put one of them to cover the other, some nodes of the two trees are overlapped while the others are not.
>
> You need to merge them into a new binary tree. The merge rule is that if two nodes overlap, then sum node values up as the new value of the merged node. Otherwise, the NOT null node will be used as the node of new tree.
>
> Example 1:
> Input: 

    Tree 1                     Tree 2
          1                         2
         / \                       / \
        3   2                     1   3
       /                           \   \
      5                             4   7

> Output:
> Merged tree:

          3
         / \
        4   5
        / \   \
       5   4   7

> Note: The merging process must start from the root nodes of both trees.

挺简单的问题，对于两个`root`,大致可以分为4种情况：

1. t1 = nullptr and t2 == nullptr: 直接返回nullptr
1. t1 == nullptr and t2 != nullptr:
    - new 一个新的节点ret
    - ret->val = t2->val
    - ret->left = mergeTrees(t1,t2->left)
    - ret->right = mergeTree(t1,t2->right)
1. t1 != nullptr and t2 == nullptr: 与上面类似
1. t1 != nullptr and t2 != nullptr:
    - new 一个新的节点ret
    - ret->val = t1->val + t1->val
    - ret->left = mergeTrees(t1->left,t2->left)
    - ret->right = mergeTrees(t1->right,t2->right)

```c++
TreeNode* mergeTrees(TreeNode* t1, TreeNode* t2) {
    if (!t1 && !t2) return nullptr;
    TreeNode * ret = new TreeNode(0);
    ret->val = ((t2)?t2->val:0) + ((t1)?t1->val:0);
    ret->left = mergeTrees((t1)?t1->left:t1
                            ,(t2)?t2->left:t2);
    ret->right = mergeTrees((t1)?t1->right:t1
                            ,(t2)?t2->right:t2);
    return ret;
}
```

如果可以不管使用t1和t2的空间的话，可以更简单一点：

```c++
TreeNode* mergeTrees(TreeNode* t1, TreeNode* t2) {
    if (!t1) return t2;
    if (!t2) return t1;
    TreeNode *ret = new TreeNode(t1->val + t2->val);
    ret->left = mergeTrees(t1->left,t2->left);
    ret->right = mergeTrees(t1->right,t2->right);
    return ret;
}
```