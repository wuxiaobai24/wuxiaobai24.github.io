---
title: Path-Sum-II
date: 2018-02-15 20:40:34
tags:
- LeetCode
- 二叉树
---

第101天，新年快乐啊。

今天的题目是[Path Sum-II](https://leetcode.com/problems/path-sum-ii/description/):

> Given a binary tree and a sum, find all root-to-leaf paths where each path's sum equals the given sum.

> For example:
> Given the below binary tree and sum = 22,

```python
              5
             / \
            4   8
           /   / \
          11  13  4
         /  \    / \
        7    2  5   1
```

> return

```python
[
   [5,4,11,2],
   [5,8,4,5]
]
```

比较简单，只贴代码咯：

```c++
vector<vector<int>> ret;

vector<vector<int>> pathSum1(TreeNode* root, int sum) {
    vector<int> temp;
    pathSum(root, sum, temp);
    return ret;
}
void pathSum(TreeNode *root, int sum, vector<int> &temp) {
    if (root == nullptr) return ;
    //cout << root->val << endl;
    temp.push_back(root->val);
    if (root->left == nullptr && root->right == nullptr && sum == root->val) {
        ret.push_back(temp);
    }
    pathSum(root->left, sum - root->val, temp);
    pathSum(root->right, sum - root->val, temp);
    temp.pop_back();
}
```

