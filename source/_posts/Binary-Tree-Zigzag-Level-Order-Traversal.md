---
title: Binary-Tree-Zigzag-Level-Order-Traversal
date: 2018-02-11 22:45:59
tags: 
- LeetCode
- 二叉树
---

第97天。

今天的题目是[Binary Tree Zigzag Level Order Traversal](https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/description/):

> Given a binary tree, return the zigzag level order traversal of its nodes' values. (ie, from left to right, then right to left for the next level and alternate between).
>
> For example:
> Given binary tree [3,9,20,null,null,15,7],

```python
    3
   / \
  9  20
    /  \
   15   7
```

> return its zigzag level order traversal as:

```python
[
  [3],
  [20,9],
  [15,7]
]
```

首先想到的是用层次遍历的方式来实现。

简单的层次遍历：

```c++
void levelTra(TreeNode *root) {
    if (root == nullptr) return ;
    queue<TreeNode *> q;
    q.push(root);
    while(!q.empty()) {
        root = q.top(); q.pop();
        cout << root->val;
        if (root->left) q.push(root->left);
        if (root->right) q.push(root->right);
    }
}
```

但是上面的方法是没法区分层数的，我们通过`nullptr`来表示换行：

```c++
void levelTra(TreeNode *root) {
    if (root == nullptr) return ;
    queue<TreeNode *> q;
    q.push(root);
    q.push(nullptr);
    while(true) {
        root = q.top(); q.pop();

        if (root == nullptr) {
            cout << "new level" << endl;
            if (q.empty()) break;
            q.push(nullptr);
        }

        cout << root->val;
        if (root->left) q.push(root->left);
        if (root->right) q.push(root->right);
    }
}
```

```c++
vector<vector<int>> zigzagLevelOrder(TreeNode* root) {
    vector<vector<int> > ret;
    vector<int> tmp;
    if (root == nullptr) return ret;
    //level tra
    
    bool flag = true; //判断遍历方向
    
    queue<TreeNode *> q;
    q.push(root);
    q.push(nullptr);
    
    while(true) {
        root = q.front(); q.pop();
        if (root == nullptr)  {
            
            if (flag) ret.push_back(tmp);
            else ret.push_back(vector<int>(tmp.rbegin(), tmp.rend()));
            
            tmp.clear();
            flag = !flag;
            
            if (q.empty()) break;
            q.push(nullptr);
            continue;
        }
        
        
        tmp.push_back(root->val);
        if (root->left) q.push(root->left);
        if (root->right) q.push(root->right);
    }
    
    return ret;
}
```


然后是`dicuss`中的方法，简单的来说就是通过深度优先遍历来生成获取层次遍历的每层的数组（好像之前写过？），然后就会比前面用`queue`的方法快。

```c++
void travel(TreeNode *root, vector<vector<int> > &ret, int level) {
    if (root == nullptr) return ;
    if (level >= ret.size()) ret.push_back(vector<int>());
    
    ret[level].push_back(root->val);
    
    travel(root->left, ret, level + 1);
    travel(root->right, ret, level + 1);
}

vector<vector<int> > zigzagLevelOrder(TreeNode *root) {
    vector<vector<int>> ret;
    travel(root, ret, 0);
    
    for(int i = 0;i < ret.size();i++) {
        if (i % 2) reverse(ret[i].begin(), ret[i].end());
    }
    
    return ret;
}

```