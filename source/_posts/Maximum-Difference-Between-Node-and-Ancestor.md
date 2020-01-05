---
title: Maximum Difference Between Node and Ancestor
date: 2020-01-04 21:04:02
tags:
- LeetCode
categories: LeetCode
---

> 第55天

今天的题目是[Maximum Difference Between Node and Ancestor](https://leetcode.com/problems/maximum-difference-between-node-and-ancestor/):

我们做一次后序遍历，维护一个子树的最大值和最小值，用当前节点的值与最大最小值求距离，并返回距离的最大值即可。

```c++
int maxAncestorDiff(TreeNode* root) {
    if (root == nullptr) return -1;
    int minVal, maxVal;
    return maxAncestorDiff(root, minVal, maxVal);
}
int maxAncestorDiff1(TreeNode *root, int &minVal, int &maxVal) {
    if (root == nullptr) return -1;
    minVal = maxVal = root->val;
    
    int d = -1, leftMin, leftMax, rightMin, rightMax;
    
    if (root->left) {
        int r = maxAncestorDiff(root->left, leftMin, leftMax);
        d = max(r, max(abs(root->val - leftMin), abs(root->val - leftMax)));
        minVal = min(minVal, leftMin);
        maxVal = max(maxVal, leftMax);
    }
    if (root->right) {
        int r = maxAncestorDiff(root->right, rightMin, rightMax);
        d = max(d,max(r, max(abs(root->val - rightMax), abs(root->val - rightMin))));
        minVal = min(minVal, rightMin);
        maxVal = max(maxVal, rightMax);
    }
    if (!root->left && !root->right) return -1;
    return d;
}
```

这样做可能有点过于复杂了，我们可以把后序遍历转成先序遍历来，同样也需要维护最大值和最小值，不过因为是先序遍历，所以比较简单

```c++
int maxAncestorDiff(TreeNode* root) {
    if (root == nullptr) return -1;
    int minVal, maxVal;
    minVal = maxVal = root->val;
    return maxAncestorDiff(root, minVal, maxVal);
}

int maxAncestorDiff(TreeNode *root, int maxVal, int minVal) {
    if (root == nullptr) return maxVal - minVal;
    maxVal = max(maxVal, root->val);
    minVal = min(minVal, root->val);
    // cout << maxVal << " " << minVal << endl;
    return max(maxAncestorDiff(root->left, maxVal, minVal),
                maxAncestorDiff(root->right, maxVal, minVal));
}
```