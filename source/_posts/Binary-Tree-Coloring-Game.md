---
title: Binary Tree Coloring Game
date: 2019-12-27 17:02:35
tags:
- LeetCode
categories: LeetCode
---

> 第50天。

今天的题目是[Binary Tree Coloring Game](https://leetcode.com/problems/binary-tree-coloring-game/)

挺唬人的题目，搞清楚题意的话，还是挺简单的。

大概的意思是，现在有一个树，然后已经有个人将其中一个节点上色成红色，问你，现在按顺序涂颜色，最后你能不能赢。这个的规则有两个：

- 除了第一个颜色可以随便找节点上色外，其他的都只能对自己临近的节点上色。
- 有颜色的节点不能再次上色
- 所以节点上完色后，节点多的人获胜

![](https://assets.leetcode.com/uploads/2019/08/01/1480-binary-tree-coloring-game.png)

因为是在树上，所以给第二个以及之后的节点上色的话，只有三种选择，向父节点、向左节点、向右节点。

所以我们只要判断对手上色的第一个节点，三个方向中，是否存在一个方向的节点比剩余节点都要多。

```c++
bool btreeGameWinningMove(TreeNode* root, int n, int x) {
    if (!root) return false;
    TreeNode *node = search(root, x);
    
    int leftNum = getNodeNum(node->left);
    int rightNum = getNodeNum(node->right);
    int upNum = n - 1 - leftNum - rightNum;
    int maxNum = max(max(leftNum, rightNum), upNum);
    // cout << leftNum << endl;
    // cout << rightNum << endl;
    // cout << upNum << endl;
    // cout << maxNum << endl;
    return maxNum > (n - maxNum);

}

int getNodeNum(TreeNode *root) {
    if (!root) return 0;
    return 1 + getNodeNum(root->left) + getNodeNum(root->right);
}

TreeNode *search(TreeNode *root, int x) {
    if (!root || root->val == x) return root;
    TreeNode *node = search(root->left, x);
    if (node) return node;
    return search(root->right, x);
}
```

