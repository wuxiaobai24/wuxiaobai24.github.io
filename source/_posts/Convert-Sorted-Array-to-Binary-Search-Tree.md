---
title: Convert Sorted Array to Binary Search Tree
date: 2017-11-30 18:08:21
categories: LeetCode
tags:
- LeetCode
---

第64天。

要死了，天天晚睡早起的，今天一定要早睡晚起（或者等下就睡睡先）

今天的题目是[Convert Sorted Array to Binary Search Tree](https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/description/):

> Given an array where elements are sorted in ascending order, convert it to a height balanced BST.

这道题其实一开始没有思路的，感觉很难搞的样子，但是今天数据结构课上讲二分查找时提到了二分查找树（好像是这个名字），然后就觉得好像它就是一个`height balanced BST`.

然后就仿照二分查找的递归算法解出了这道题，其实就是二分查找的逆过程：

```c++
TreeNode* sortedArrayToBST(vector<int>& nums) {
    return sortedArrayToBST(nums,0,nums.size() - 1);
}
TreeNode *sortedArrayToBST(vector<int> &nums,int low,int high) {
    if (low > high) return nullptr;
    int mid = (low + high)/2;
    TreeNode *root = new TreeNode(nums[mid]);
    root->left = sortedArrayToBST(nums,low,mid-1);
    root->right = sortedArrayToBST(nums,mid+1,high);
    return root;
}
```