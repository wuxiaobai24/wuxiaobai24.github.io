---
title: Invert Binary Tree
date: 2017-11-05 09:18:33
categories: LeetCode
tags:
- LeetCode
- Tree
---

第41天。

今天的题目是[Invert Binary Tree](https://leetcode.com/problems/invert-binary-tree/discuss/):

>Invert a binary tree.

```python
     4
   /   \
  2     7
 / \   / \
1   3 6   9
```

> to

```python
     4
   /   \
  7     2
 / \   / \
9   6 3   1
```

> Google: 90% of our engineers use the software you wrote (Homebrew), but you can’t invert a binary tree on a whiteboard so fuck off.

emmmm，挺出名的一道题目。

其实挺简单：

```c++
TreeNode* invertTre1e(TreeNode* root) {
    if (root == nullptr) return root;
    TreeNode *left = invertTree(root->right);
    TreeNode *right = invertTree(root->left);
    root->left = left;
    root->right = right;
    return root;
}
```

然后是迭代的方法:

```c++
TreeNode* invertTree(TreeNode *root) {
    stack<TreeNode *> st;
    st.push(root);
    TreeNode *ret =root;
    while(!st.empty()) {
        root = st.top();
        st.pop();
        if (root) {
            st.push(root->left);
            st.push(root->right);
            TreeNode *t = root->left;
            root->left = root->right;
            root->right = t;
        }
    }
    return ret;
}
```