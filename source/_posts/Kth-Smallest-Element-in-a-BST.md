---
title: Kth Smallest Element in a BST
date: 2019-11-21 09:28:38
tags:
- LeetCode
categories: LeetCode
---

> 第17天，又是一道之前没做出来的题目，然而好像并不难啊。

今天的题目是[ Kth Smallest Element in a BST ]( https://leetcode.com/problems/kth-smallest-element-in-a-bst/ ):

---

Given a binary search tree, write a function `kthSmallest` to find the **k**th smallest element in it.

**Note:**
You may assume k is always valid, 1 ≤ k ≤ BST's total elements.

**Example 1:**

```
Input: root = [3,1,4,null,2], k = 1
   3
  / \
 1   4
  \
   2
Output: 1
```

**Example 2:**

```
Input: root = [5,3,6,2,4,null,null,1], k = 3
       5
      / \
     3   6
    / \
   2   4
  /
 1
Output: 3
```

**Follow up:**
What if the BST is modified (insert/delete operations) often and you need to find the kth smallest frequently? How would you optimize the kthSmallest routine?

---

题意很简单就是求BST中第k小的数字，然后BST本身就包含一定的顺序信息，利用BST中序遍历是有序的性质，我们可以很快的把这道题写出来：

```c++
int res;
int kthSmallest(TreeNode* root, int k) {
    res = 0;
    kthSmallestR(root, k);
    return res;
}
bool kthSmallestR(TreeNode *root, int &k) {
    // cout << root << endl;
    if (root == nullptr) return false;

    if (kthSmallestR(root->left, k)) return true;
    // cout << root->val << endl;
    if ((--k) == 0) {
        res = root->val;
        return true;
    }
    return kthSmallestR(root->right, k);
}
```

然后我们可以写出非递归版本的：

```c++
int kthSmallest(TreeNode* root, int k) {
    stack<TreeNode *> st;

    while(root || !st.empty()) {
        while(root) {
            st.push(root);
            root = root->left;
        }
        if (st.empty()) break;
        root = st.top(); st.pop();
        if (--k == 0) break;
        root = root->right;
    }

    if(root) return root->val;
    else return -1;

}
```

BTW，这道题的测试有点不稳定，同一个代码会测试出不同的时间。