---
title: Lowest Common Ancestor of a Binary Tree
date: 2017-11-07 10:22:40
categories: LeetCode
tags:
- LeetCode
- Tree
---

第42天。

今天的题目是[Lowest Common Ancestor of a Binary Tree](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/description/):

> Given a binary tree, find the lowest common ancestor (LCA) of two given nodes in the tree.
>
> According to [the definition of LCA on Wikipedia](https://en.wikipedia.org/wiki/Lowest_common_ancestor): “The lowest common ancestor is defined between two nodes v and w as the lowest node in T that has both v and w as descendants (where we allow a node to be a descendant of itself).”

```python
        _______3______
       /              \
    ___5__          ___1__
   /      \        /      \
   6      _2       0       8
         /  \
         7   4
```

> For example, the lowest common ancestor (LCA) of nodes 5 and 1 is 3. Another example is LCA of nodes 5 and 4 is 5, since a node can be a descendant of itself according to the LCA definition.

额，怎么说呢。好久没有在上课前就AC掉了呢。

恩，题目的意思是，找最近的公共祖先。

考虑根节点，如果不考虑特殊的情况（比如说只用一个节点或干脆就没有节点），那么如果我们对其左子树和右子树递归的调用`lowestCommonAncestor`，那么其返回值就有以下几种情况:

* `left`和`right`都非空，那么说明`root`节点就是`lowestCommonAncestor`，那我们就返回`root`
* 只有`left`非空，那么说明`lowestCommonAncestor`在左子树中,那么我们就返回`left`
* 只有`right`非空，与上面类似，我们就直接返回`right`
* 两个都是空，说明`p`和`q`都不在这棵子树中，那其`lowestCommonAncestor`就是`nullptr`.

然后我们再考虑一下特殊情况：

* `root`是`nullptr`,那么就说明到了最底部了，直接返回`nullptr`即可
* `root`和`p`或`q`相等,说明我们找到了其一个祖先，则返回`p`或`q`.

然后将上面的思路写出来就是:

```c++
TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
    if (root == nullptr || root == p || root == q) return root;

    TreeNode *left = lowestCommonAncestor(root->left,p,q);
    TreeNode *right = lowestCommonAncestor(root->right,p,q);

    if (left && right) return root;
    else if (left) return left;
    else if (right) return right;
    else return nullptr;

}
```

其实上面有一个问题没考虑到，要是只有`p`在这棵子树中，而`q`不在，那怎么办。

emmmm，但是上面的解法是过了测试的。

如果要考虑这个问题的话，上面就有一些假设就是错的了，因为在`lowestCommonAncestor`在某些情况返回非空只是说明，这棵子树中有一个节点是与`p`和`q`相同的。