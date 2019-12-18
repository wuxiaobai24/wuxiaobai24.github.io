---
title: Find Largest Value in Each Tree Row
date: 2019-12-18 11:08:25
tags:
- LeetCode
categories: LeetCode
---

> 第42天。

今天的题目是[Find Largest Value in Each Tree Row](https://leetcode.com/problems/find-largest-value-in-each-tree-row/):

水题，用队列做树的层次遍历即可：

```c++
vector<int> largestValues(TreeNode* root) {
    vector<int> res;
    if (root == nullptr) return res;
    queue<TreeNode *> q;
    q.push(root);
    
    while(!q.empty()) {
        int max_v = INT_MIN;
        for(int i = 0, size = q.size(); i < size; i++) {
            root = q.front(); q.pop();
            max_v = max(max_v, root->val);
            if (root->left) q.push(root->left);
            if (root->right) q.push(root->right);
        }
        res.push_back(max_v);
    }
    
    return res;
}
```