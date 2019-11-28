---
title: Delete Node in a BST
date: 2019-11-28 10:06:14
tags:
- LeetCode
categories: LeetCode
---

> 第24天。

今天的题目是[ Delete Node in a BST ]( https://leetcode.com/problems/delete-node-in-a-bst/ ):

---

Given a root node reference of a BST and a key, delete the node with the given key in the BST. Return the root node reference (possibly updated) of the BST.

Basically, the deletion can be divided into two stages:

1. Search for a node to remove.
2. If the node is found, delete the node.



**Note:** Time complexity should be O(height of tree).

**Example:**

```
root = [5,3,6,2,4,null,7]
key = 3

    5
   / \
  3   6
 / \   \
2   4   7

Given key to delete is 3. So we find the node with value 3 and delete it.

One valid answer is [5,4,6,2,null,null,7], shown in the following BST.

    5
   / \
  4   6
 /     \
2       7

Another valid answer is [5,2,6,null,4,null,7].

    5
   / \
  2   6
   \   \
    4   7
```

---

水题，只要先在`BST`上做搜索，然后删除就好了，因为只是`BST`，所以可以不考虑平衡的问题：

- `left`和`right`都为空：直接删除，返回`nullptr`即可
- `left`和`right`都不为空：默认采用把右子树的节点拉上来的方式，即把左子树插入到右子树中，然后再返回`right`即可。
- `left`和`right`有一个不为空，则返回不为空的子树即可。

则代码如下：

```c++
    TreeNode* deleteNode(TreeNode *node) {
        auto left = node->left, right = node->right;
        delete node;
        if (left && right) {
            auto temp = right;
            while(temp->left) {
                temp = temp->left;
            }
            temp->left = left;
            return right;
        } 
        return (left ? left : (right ? right : nullptr));
    }
    TreeNode* deleteNode(TreeNode* root, int key) {
        if (root == nullptr) return nullptr;
        else if (root->val == key) {
            return deleteNode(root);
        } else if (key >  root->val) {
            root->right = deleteNode(root->right, key);    
        } else 
            root->left = deleteNode(root->left, key);
        
        return root;
    }
```

