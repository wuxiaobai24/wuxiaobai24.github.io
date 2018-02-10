---
title: Diameter of Binary Tree
date: 2017-11-24 08:58:25
categories: LeetCode
tags:
- LeetCode
- Tree
---

第58天。

今天的题目是[Diameter of Binary Tree](https://leetcode.com/problems/diameter-of-binary-tree/description/):

> Given a binary tree, you need to compute the length of the diameter of the tree. The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.
>
> Example:
> Given a binary tree 

          1
         / \
        2   3
       / \
      4   5

> Return 3, which is the length of the path [4,2,1,3] or [5,2,1,3].
>
> Note: The length of path between two nodes is represented by the number of edges between them.

很显然，题目已经给出提示了,这个path要么经过`root`要么不经过`root`.

如果经过`root`,那么就是左子树和右子树的高度之和加上2.
如果不经过`root`,就是左子树的`diameter`或者是右子树的`diameter`.

那么如何分辨是否经过`root`呢？

其实也很简单，反正就要求最大的嘛，我们就把两种情况都算一遍，然后求个`max`即可。大概可以写出一下递推式：

```c++
leftH = heightOfHeight(root->left)
rightH = heightOrHeight(root->right)
d = diameterOfBinaryTree(root->left) + diameterOfBinaryTree(root->right)
return max(d,leftH+rightH+2)
```

然后我们发现求高度也是类似的需要递归的方式，所以我们可以将他们合并起来：

```c++
int diameterOfBinaryTree(TreeNode* root) {
    int h;
    return diameterOfBinaryTree(root,h);
}
int diameterOfBinaryTree(TreeNode *root,int &height) {
    if (root == nullptr) {
        height = -1;
        return 0;
    }
    int leftH,rightH;
    int leftD = diameterOfBinaryTree(root->left,leftH);
    int rightD = diameterOfBinaryTree(root->right,rightH);

    height = max(leftH,rightH) + 1;
    return max(leftH + rightH + 2,max(leftD,rightD) );
}
```