---
title: Sum Root to Leaf Numbers
date: 2019-03-06 08:43:17
tags:
- LeetCode
- Tree
categories:
- LeetCode
---

> 第7天，为什么今天随机到了一道水题。。。

今天的题目是[129. Sum Root to Leaf Numbers](https://leetcode.com/problems/sum-root-to-leaf-numbers/)

恩，这是一道打卡水题，明明是道`Easy`的题目，却混进了`Medium`中：

这道题有个比较容易想错的方法就是，用后序遍历做：

```c++
int sumNumbers(TreeNode* root) {
    if (root == nullptr) return 0;
    return sumNumbers(root->left) + sumNumbers(root->right) + 20 * root->val;
}
```

这个方法对满二叉树是没问题的，但是对于普通的二叉树就会有问题，如：

```
    1
  /  
 2 
```

也就是说，在两边高度不一样时，是会出问题的，为了解决这个问题，我们要把思路换过来，把`root`到当前节点的值计算出来，并传给子节点去计算：

```c++
class Solution {
public:
    int sumNumbers(TreeNode* root) {
        return sumNumbers(root, 0);
    }
    int sumNumbers(TreeNode* root, int v) {
        if (root == nullptr) return 0;
        
        v = v*10 + root->val;
        if (root->right == nullptr && root->left == nullptr) return v;
        
        return sumNumbers(root->left, v) + sumNumbers(root->right, v);
    }
};
```