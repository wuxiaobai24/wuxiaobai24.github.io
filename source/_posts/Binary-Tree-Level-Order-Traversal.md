---
title: Binary Tree Level Order Traversal
date: 2017-10-24 10:29:00
categories: LeetCode
tags:
- LeetCode
- Tree
---

第31天。

今天的题目是之前好像就做过的了,[Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal/description/):

> Given a binary tree, return the level order traversal of its nodes' values. (ie, from left to right, level by level).
>
> For example:
> Given binary tree [3,9,20,null,null,15,7],

```python
    3
   / \
  9  20
    /  \
   15   7
```

> return its level order traversal as:

```python
[
  [3],
  [9,20],
  [15,7]
]
```

emmm，简单来讲就是层次遍历.

一般来说，层次遍历都是用队列来实现:

* 先让root入队，这时我们队列里面就有第一层的所有元素了
* 我们记录当前层次所拥有的元素的个数size，然后出队size个元素，对于每一个出队的元素，我们遍历它一次，然后将它的左右孩子入队。

```c++
vector<vector<int>> levelOrder(TreeNode* root) {
    vector<vector<int> > ret;
    if (root == NULL) return ret;
    queue<TreeNode *> q;
    q.push(root);
    int size = 0;
    int last = 0;
    while((size = q.size())) {
        ret.push_back(vector<int>());
        while(size--) {
            root = q.front();
            q.pop();
            ret[last].push_back(root->val);
            if (root->left) q.push(root->left);
            if (root->right) q.push(root->right);
        }
        last++;
    }
    return ret;
}
```

然后因为这里是返回`vector< vector<int> >`，而不是直接输出，所以我们可以取个巧，写出一个递归算法出来:

```c++
vector<vector<int> > ret;
vector<vector<int>> levelOrder(TreeNode* root) {
    leverlOrder(root,0);
    return ret;
}
void levelOrder(TreeNode* root,int level) {
    if (root==NULL)
        return;
    if (level >= ret.size() ) {
        ret.push_back(vector<int>());
    }
    ret[level].push_back(root->val);
    levelOrder(root->left,level+1);
    levelOrder(root->right,level+1);
}
```

这里其实是先序遍历，但是因为我们一直记录着层数，所以我们还是可以保证`vector<vector<int> >`的顺序是正确的。