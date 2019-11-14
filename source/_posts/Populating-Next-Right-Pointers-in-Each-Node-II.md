---
title: Populating Next Right Pointers in Each Node II
date: 2019-11-14 22:53:14
tags:
- LeetCode
categories: LeetCode
---

> 第10天了。

今天的题目是[ 117. Populating Next Right Pointers in Each Node II ]( https://leetcode.com/problems/populating-next-right-pointers-in-each-node-ii/ )：

---

Given a binary tree

```
struct Node {
  int val;
  Node *left;
  Node *right;
  Node *next;
}
```

Populate each next pointer to point to its next right node. If there is no next right node, the next pointer should be set to `NULL`.

Initially, all next pointers are set to `NULL`.

![](https://assets.leetcode.com/uploads/2019/02/15/117_sample.png)

 **Example:** 

```
Input: {"$id":"1","left":{"$id":"2","left":{"$id":"3","left":null,"next":null,"right":null,"val":4},"next":null,"right":{"$id":"4","left":null,"next":null,"right":null,"val":5},"val":2},"next":null,"right":{"$id":"5","left":null,"next":null,"right":{"$id":"6","left":null,"next":null,"right":null,"val":7},"val":3},"val":1}

Output: {"$id":"1","left":{"$id":"2","left":{"$id":"3","left":null,"next":{"$id":"4","left":null,"next":{"$id":"5","left":null,"next":null,"right":null,"val":7},"right":null,"val":5},"right":null,"val":4},"next":{"$id":"6","left":null,"next":null,"right":{"$ref":"5"},"val":3},"right":{"$ref":"4"},"val":2},"next":null,"right":{"$ref":"6"},"val":1}

Explanation: Given the above binary tree (Figure A), your function should populate each next pointer to point to its next right node, just like in Figure B.
```

**Note:**

- You may only use constant extra space.
- Recursive approach is fine, implicit stack space does not count as extra space for this problem.

---

这是一道之前没做出来的问题，最开始想出来的解法也和之前差不多，大概的想法是递归求解时返回子树的最左和最右节点，然后通过一些判断来相连，但是这个问题主要是没法处理两个子树高度不一样的问题。

后面尝试用分治的方法来做，主要的想法是，假设我现在已经有了连接好的左子树和右子树，现在只需要将两个子树连接起来即可。而连接方法就是一层一层的去连接两个子树：

```c++
Node *nextLayer(Node *root) {
    while(root) {
        if (root->left) return root->left;
        if (root->right) return root->right;
        root = root->next;
    }
    return nullptr;
}
void connectLeftRight(Node *left, Node *right) {
    // level 1
    Node *pl, *pr;
    while(left && right) {
        pl = left;
        pr = right;

        // next layer
        left = nextLayer(left);
        right = nextLayer(right);

        // connect left and right tree in this layer
        while(pl->next) pl = pl->next;
        pl->next = pr;
    }
}

Node* connect1(Node* root) {
    if (root == nullptr) return nullptr;
    Node *left = connect1(root->left);
    Node *right = connect1(root->right);
    connectLeftRight(left, right);
    return root;
}
```

这个方法的时间复杂度大概是`O(h^2)`，其中`h`是树的高度。

后面又发现一种方法，这种方法大概的思路是连接孩子，然后在递归求解。这样会保证在求解到`root`节点时，`root`节点的`next`是已知的，同时在连接孩子时，需要利用到右子树的`next`指针，所以需要先求解右子树再求解左子树。

```c++
void connectChild(Node *root) {
    if (root == nullptr) return;

    if (root->left) {
        if (root->right) root->left->next = root->right;
        else root->left->next = helper(root->next);
    }
    if (root->right) {
        root->right->next = helper(root->next);
    }

}

Node *helper(Node *root) {
    if (root == nullptr) return nullptr;
    else if (root->left) return root->left;
    else if (root->right) return root->right;
    else return helper(root->next);
}

Node* connect2(Node* root) {
    if (root ==nullptr) return nullptr; 
    connectChild(root);
    // 先求右边的。
    connect2(root->right);
    connect3(root->left);
    return root;
}
```

