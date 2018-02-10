---
title: Validate Binary Search Tree
date: 2017-10-23 08:39:55
categories: LeetCode
tags:
- LeetCode
---

第30天。

恍恍惚惚就一个月了。

今天的题目是[Validate Binary Search Tree](https://leetcode.com/problems/validate-binary-search-tree/description/):

> Given a binary tree, determine if it is a valid binary search tree (BST).
>
> Assume a BST is defined as follows:
>
> The left subtree of a node contains only nodes with keys less than the node's key.
> The right subtree of a node contains only nodes with keys greater than the node's key.
> Both the left and right subtrees must also be binary search trees.
>Example 1:

```python
    2
   / \
  1   3
```

> Binary tree [2,1,3], return true.
> Example 2:

```python
    1
   / \
  2   3
```

> Binary tree [1,2,3], return false.

昨天的题目也是和BST有关的，但是这里的定义和昨天有点不用，它这里要求左子树的所有节点都比根节点的值要小，右子树的所有的节点的值都比根节点的值大.

我们可以发现这样定义的BST的中序遍历一定是升序的，所以我们可以用先序遍历的方式来做:

```c++
 long long vmax = LLONG_MIN;
 bool isValidBST1(TreeNode* root) {
        if (root == NULL) return true;
        if ( !isValidBST(root->left) ) return false;
        if (root->val <= vmax) return false;
        vmax = root->val;
        return isValidBST(root->right);
    }
```

既然使用中序遍历做的，那么我们就可以用非递归版的先序遍历来加快:

```c++
long long vmax = LLONG_MIN;
bool isValidBST(TreeNode* root) {
    stack<TreeNode *> st;
    while(true) {
        while(root){
            st.push(root);
            root = root->left;
        }

        if (st.empty()) break;
        root = st.top();
        st.pop();

        if (vmax >= root->val) return false;
        vmax = root->val;

        root = root->right;
    }
    return true;
}
```

上面都是用`long long`来记录最大值，这时因为如果用`INT_MIN`来做的话，`[INT_MIN,INT_MIN]`这样的测例就会出错，我是用`long long`来解决这个问题的，但是`dicuss`中有一些其他方法:

```c++
bool isValidBST(TreeNode* root) {
    TreeNode* prev = NULL;
    return validate(root, prev);
}
bool validate(TreeNode* node, TreeNode* &prev) {
    if (node == NULL) return true;
    if (!validate(node->left, prev)) return false;
    if (prev != NULL && prev->val >= node->val) return false;
    prev = node;
    return validate(node->right, prev);
}
```

```c++
bool isValidBST(TreeNode* root) {
    return isValidBST(root, NULL, NULL);
}

bool isValidBST(TreeNode* root, TreeNode* minNode, TreeNode* maxNode) {
    if(!root) return true;
    if(minNode && root->val <= minNode->val || maxNode && root->val >= maxNode->val)
        return false;
    return isValidBST(root->left, minNode, root) && isValidBST(root->right, root, maxNode);
}
```