---
title: Binary-Tree-Zigzag-Level-Order-Traversal
date: 2018-02-11 22:45:59
tags: 
- LeetCode
- Tree
- Queues
- Stack
- BFS
categories: LeetCode
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
        root = q.front(); q.pop();
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

        cout << root->val << endl;
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

---

> Update as 2020-03-28

最近在总结 Stack Tag 的算法，然后发现这道题可以用双栈来解，和前面队列的做法有点类似，某种意义上也是在模拟层次遍历，但是因为栈后进先出的特性，所以很直接的实现了逆序的操作，不需要额外做`reverse`。

```c++
vector<vector<int>> zigzagLevelOrder(TreeNode* root) {
    vector<vector<int> > res;
    int level = 0;
    stack<TreeNode*> st_even, st_odd;
    if (root) st_even.push(root);
    while(!st_even.empty() || !st_odd.empty()) {
        stack<TreeNode*> &st1 = level % 2 == 0 ? st_even : st_odd;
        stack<TreeNode*> &st2 = level % 2 == 0 ? st_odd : st_even;
        vector<int> temp;
        for(int i = 0, size = st1.size(); i < size; i++) {
            root = st1.top(); st1.pop();
            temp.push_back(root->val);

            TreeNode *left = root->left, *right = root->right;
            if (level % 2) swap(left, right);
            
            if (left) st2.push(left);
            if (right) st2.push(right);
        }
        //cout << st1.size() << " " << st2.size() << endl;
        res.push_back(temp);
        level++;
    }
    return res;
}
```