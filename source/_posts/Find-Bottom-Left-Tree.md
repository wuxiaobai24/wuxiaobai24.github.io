---
title: Find-Bottom-Left-Tree
date: 2017-12-07 09:01:56
categories: LeetCode
tags:
- LeetCode
---

第71天。

今天的题目是[Find Bottom Left Tree Value](https://leetcode.com/problems/find-bottom-left-tree-value/description/):

> Given a binary tree, find the leftmost value in the last row of the tree.
>
> Example 1:
> Input:

    2
   / \
  1   3

> Output:
> 1
> Example 2:
> Input:

        1
       / \
      2   3
     /   / \
    4   5   6
       /
      7

> Output:
> 7
> Note: You may assume the tree (i.e., the given root node) is not NULL.

显然这可以用带高度的深度优先去做：

```c++
int findBottomLeftValue(TreeNode *root,int &height) {
    if (root == nullptr) {
        height = -1;
        return -1;
    }
    if (root->left == nullptr && root->right == nullptr)
        return root->val;
    int lefth,righth;
    lefth = righth = height + 1;
    int left = findBottomLeftValue(root->left,lefth);
    int right = findBottomLeftValue(root->right,righth);
    if (lefth >= righth) {
        height = lefth;
        return left;
    } else{
        height = righth;
        return right;
    }
}
int findBottomLeftValue(TreeNode* root) {
    int h = 0;
    return findBottomLeftValue(root,h);
}
```

看起来就不优雅，而且很繁琐的样子,下面是`dicuss`中用广度优先去做的：

```java
public int findLeftMostNode(TreeNode root) {
    Queue<TreeNode> queue = new LinkedList<>();
    queue.add(root);
    while (!queue.isEmpty()) {
        root = queue.poll();
        if (root.right != null)
            queue.add(root.right);
        if (root.left != null)
            queue.add(root.left);
    }
    return root.val;
}
```

以及`python`版本：

```python
def findLeftMostNode(self, root):
    queue = [root]
    for node in queue:
        queue += filter(None, (node.right, node.left))
    return node.val
```