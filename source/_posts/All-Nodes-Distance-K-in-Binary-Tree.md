---
title: All Nodes Distance K in Binary Tree
date: 2019-03-07 10:07:50
tags:
- LeetCode
- Tree
categories:
- LeetCode
---

> 第8天，感觉快要把每天刷题的习惯找回来了。。。

今天的题目是[All Nodes Distance K in Binary Tree](https://leetcode.com/problems/all-nodes-distance-k-in-binary-tree/)

这道题可以分为几个部分来解决：

- 寻找`target`节点
- 向下寻找距离当前节点K步的节点
- 从`target`节点向前寻找

虽说是三部分，但是在实现“寻找target节点”的时候，我们需要考虑到如何向前寻找，我们先把“向下寻找距离当前节点K步的节点”实现了。

很容易发现，这是一个递归的过程，做遍历的时候维护好K值即可，然后加一些判断条件就能实现了。

如果忽略掉“从target节点向前寻找”这个要求，我们要怎么实现寻找target节点呢？

也是一个很简单的问题，就直接用递归形式的先序遍历即可，遍历时判断当前节点是否为target节点。

现在就剩下最后一部分了，也是这道题的难点所在。

要实现向前移动，我们可以利用“寻找target节点”的一些信息，通过一个返回值来确定，是否在某个子分支中找到 target 节点：

如果找到了，我们就可以从当前节点开始向另一个分支寻找了，因为需要计算到target节点的距离，所以我们干脆把返回值设置为还需要走多少步才能到达”距离target节点K步“的位置，故：

```c++
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    vector<int> distanceK(TreeNode* root, TreeNode* target, int K) {
        vector<int> res;
        if (root == nullptr || target == nullptr) return res;
        downSearch(res, target, K);
        findTarget(res, root, target, K);
        return res;
    }
    
    int findTarget(vector<int> &res, TreeNode *root, TreeNode *target, int K) {
        if (root == nullptr) return -1;
        if (root == target) return K - 1;
        
        // left
        int left_k = findTarget(res, root->left, target, K);
        if (left_k == 0) {
            res.push_back(root->val); return left_k - 1;
        } else if (left_k > 0) {
            downSearch(res, root->right, left_k-1);
            return left_k - 1;
        }
        
        int right_k = findTarget(res, root->right, target, K);
        if (right_k == 0) {
            res.push_back(root->val); return right_k - 1;
        } else if (right_k > 0) {
            downSearch(res, root->left, right_k-1);
            return right_k - 1;
        }
        return -1;
    }
    
    void downSearch(vector<int> &res, TreeNode* p, int K) {
        if (p == nullptr || K < 0) return ;
        if (K == 0) {
            res.push_back(p->val); return;
        }
        downSearch(res, p->left, K-1);
        downSearch(res, p->right, K-1);
    }
};
```