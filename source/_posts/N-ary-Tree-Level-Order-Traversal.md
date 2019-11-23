---
title: N-ary Tree Level Order Traversal
date: 2019-11-23 10:09:08
tags:
- LeetCode
categories: LeetCode
---

> 第19天。

今天的题目是[ N-ary Tree Level Order Traversal ]( https://leetcode.com/problems/n-ary-tree-level-order-traversal/ ):

---

Given an n-ary tree, return the *level order* traversal of its nodes' values.

*Nary-Tree input serialization is represented in their level order traversal, each group of children is separated by the null value (See examples).*

 

**Example 1:**

![img](https://assets.leetcode.com/uploads/2018/10/12/narytreeexample.png)

```
Input: root = [1,null,3,2,4,null,5,6]
Output: [[1],[3,2,4],[5,6]]
```

**Example 2:**

![img](https://assets.leetcode.com/uploads/2019/11/08/sample_4_964.png)

```
Input: root = [1,null,2,3,4,5,null,null,6,7,null,8,null,9,10,null,null,11,null,12,null,13,null,null,14]
Output: [[1],[2,3,4,5],[6,7,8,9,10],[11,12,13],[14]]
```

 

**Constraints:**

- The height of the n-ary tree is less than or equal to `1000`
- The total number of nodes is between `[0, 10^4]`

---

一道水题，简单的`BFS`或`DFS`即可，除了是一个多叉树外，和另外一道题基本是一样的。

```c++
class Node {
public:
    int val;
    vector<Node*> children;

    Node() {}

    Node(int _val, vector<Node*> _children) {
        val = _val;
        children = _children;
    }
};
```

所以，我们既可以用队列去做层次遍历(BFS)，也可以用递归来实现DFS，然后按当前节点所在的高度插入到对于的数组即可：

1. DFS

```c++
vector<vector<int>> res;
vector<vector<int>> levelOrder(Node* root) {
    dfsWithHeight(root, 0);
    return res;
}
void dfsWithHeight(Node *root, int h) {
    if (root == nullptr) return;
    if (h == res.size()) res.push_back(vector<int>());
    res[h].push_back(root->val);
    for(int i = 0;i < root->children.size(); i++) {
        dfsWithHeight(root->children[i], h + 1);
    }
}
```

2. BFS

```c++
vector<vector<int>> levelOrder2(Node* root) {
    vector<vector<int>> res;
    if (root == nullptr) {
        return res;
    }
    vector<int> vec;
    queue<Node *> q;
    q.push(root);
    q.push(nullptr);
    while(q.size() != 1) {
        vec.clear();
        root = q.front();
        while(root) {
            q.pop();
            vec.push_back(root->val);
            // cout << root->val << endl;
            for(int i = 0;i < root->children.size(); i++) {
                q.push(root->children[i]);
            }
            root = q.front();
        }
        q.pop();
        q.push(nullptr);
        res.push_back(vec);
    }

    return res;
}

vector<vector<int>> levelOrder1(Node* root) {
    vector<vector<int>> res;
    if (root == nullptr) {
        return res;
    }
    vector<int> vec;
    vector<Node *> nodes;
    vector<Node *> nextLevelNodes;
    nodes.push_back(root);
    while(!nodes.empty()) {
        vec.clear();
        nextLevelNodes.clear();
        for(int i = 0;i < nodes.size(); i++) {
            vec.push_back(nodes[i]->val);
            for(int j = 0;j < nodes[i]->children.size(); j++) {
                nextLevelNodes.push_back(nodes[i]->children[j]);
            }
        }
        swap(nodes, nextLevelNodes);
        res.push_back(vec);
    }
    return res;
}
```

