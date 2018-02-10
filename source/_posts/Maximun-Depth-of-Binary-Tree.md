---
title: Maximum Depth of Binary Tree
date: 2017-11-11 08:25:23
categories: LeetCode
tags:
- LeetCode
- Tree
---

第46天。

今天出游，挑到水题[Maximum Depth of Binary Tree](https://leetcode.com/problems/maximum-depth-of-binary-tree/discuss/):

> Given a binary tree, find its maximum depth.
>
> The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

说是水题，就不讲怎么做了，直接上代码吧:

```c++
int maxDepth(TreeNode* root) {
    return maxDepth(root,0);
}
int maxDepth(TreeNode *root,int depth) {
    if (root == nullptr) return depth;
    return max(maxDepth(root->left,depth+1),maxDepth(root->right,depth+1));
}
```

恩，突然发现好像没必要写的那么长:

```c++
int maxDepth(TreeNode *root) {
    if (root == nullptr) return 0;
    return max(maxDepth(root->left),maxDepth(root->right))+1;
}
```

恩，送上一个`dicuss`中BFS的解法：

```c++
int maxDepth(TreeNode *root)
{
    if(root == NULL)
        return 0;

    int res = 0;
    queue<TreeNode *> q;
    q.push(root);
    while(!q.empty())
    {
        ++ res;
        for(int i = 0, n = q.size(); i < n; ++ i)
        {
            TreeNode *p = q.front();
            q.pop();

            if(p -> left != NULL)
                q.push(p -> left);
            if(p -> right != NULL)
                q.push(p -> right);
        }
    }

    return res;
}
```