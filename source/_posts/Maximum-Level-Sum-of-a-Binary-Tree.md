---
title: Maximum Level Sum of a Binary Tree
date: 2019-12-26 23:07:45
tags:
- LeetCode
categories: LeetCode
---

> 第49天。

今天的题目是[Maximum Level Sum of a Binary Tree](https://leetcode.com/problems/maximum-level-sum-of-a-binary-tree/):

送分题，直接用层次便利计算每一层的元素之和，然后去最大即可。

```c++
int maxLevelSum(TreeNode* root) {
    if (!root) return -1;
    
    int max_level = -1, max_sum = INT_MIN;
    
    queue<TreeNode *> q;
    q.push(root);
    
    int cur_level = 1, cur_sum;
    
    while(!q.empty()) {
        cur_sum = 0;
        for(int i = 0, size = q.size(); i < size; i++) {
            root = q.front(); q.pop();
            cur_sum += root->val;
            if (root->left) q.push(root->left);
            if (root->right) q.push(root->right);
        }
        if (cur_sum > max_sum) {
            max_sum = cur_sum;
            max_level = cur_level;
        }
        cur_level++;
    }
    
    return max_level;
}
```