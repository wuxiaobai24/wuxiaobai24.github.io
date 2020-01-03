---
title: All Elements in Two Binary Search Trees
date: 2020-01-03 11:17:32
tags:
- LeetCode
categories: LeetCode
---

> 第54天。

今天的题目是[All Elements in Two Binary Search Trees](https://leetcode.com/problems/all-elements-in-two-binary-search-trees/):

先用先序遍历拿到每棵树上的值，因为是二叉搜索树，所以先序得到的就是有序的值，所以做一次归并即可：

```c++
vector<int> getAllElements(TreeNode* root1, TreeNode* root2) {
    vector<int> left;
    vector<int> right;
    getAllElements(root1, left);
    getAllElements(root2, right);
    
    int len = left.size() + right.size();
    if (len == 0) return vector<int>();
    vector<int> vec(len);
    
    int i = 0, j = 0, k = 0;
    while(i < left.size() && j < right.size()) {
        if (left[i] < right[j]) vec[k++] = left[i++];
        else vec[k++] = right[j++];
    }
    while(i < left.size()) vec[k++] = left[i++];
    while(j < right.size()) vec[k++] = right[j++];
    return vec;
    
}


void getAllElements(TreeNode *root, vector<int> &vec) {
    if (root == nullptr) return ;
    stack<TreeNode *> st;
    while(root || !st.empty()) {
        while(root) {
            st.push(root);
            root = root->left;
        }
        if (!st.empty()) {
            root = st.top(); st.pop();
            vec.push_back(root->val);
            root = root->right;
        }
    }
}
```