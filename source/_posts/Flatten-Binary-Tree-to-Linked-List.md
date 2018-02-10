---
title: Flatten Binary Tree to Linked List
date: 2017-10-26 11:02:31
categories: LeetCode
tags:
- LeetCode
- Tree
---

第32天。

今天的题目是[Flatten Binary Tree to Linked List](https://leetcode.com/problems/flatten-binary-tree-to-linked-list/discuss/):

> Given a binary tree, flatten it to a linked list in-place.
>
> For example,
> Given

```python
        1
        / \
       2   5
      / \   \
     3   4   6
```

> The flattened tree should look like:

```python
   1
    \
     2
      \
       3
        \
         4
          \
           5
            \
             6
```


通过观察结果，我们可以发现它的顺序其实是一个先序遍历,那么我们可以先对树做一个先序遍历并记录节点指针，然后我们只需要将所有节点连接起来即可

```c++
void flatten2(TreeNode *root) {
    if (root == nullptr) return ;
    stack<TreeNode *> st;
    vector<TreeNode *> tvec;
    while(true) {
        while(root){
            st.push(root);
            tvec.push_back(root);
            root = root->left;
        }
        if (st.empty() ) break;
        root = st.top();
        st.pop();
        root = root->right;
    }
    int i;
    for(i = 0;i < tvec.size() - 1;i++) {
        tvec[i]->left = nullptr;
        tvec[i]->right = tvec[i+1];
    }
    tvec[i]->left = nullptr;
    tvec[i]->right = nullptr;
}
```

考虑一下递归的去完成整个问题，我们可以先对左孩子和右孩子做一次`flatten`,然后再讲他们按照适当的顺序连接起来:

```c++
void flatten(TreeNode* root) {
    if (root==NULL) return ;
    flatten(root->left);
    flatten(root->right);
    auto right = root->right;
    auto left = root->left;
    if (left){
        root->right = left;
        root->left = NULL;
        while(left->right)
            left = left->right;
        left->right = right;
    }
}
```

上面的做法由于每次都需要对左孩子有一个一直往右的遍历，所以耗时还是挺大的，可以加入一个last指针，去表示最后一个被访问的节点的位置,为了保证正确性，我们必须先对右孩子进行`flatten`再对左孩子进行`flatten`.

```c++
TreeNode *last;
void flatten(TreeNode* root) {
    if (root==NULL) return ;
    flatten(root->right);
    flatten(root->left);
    root->right = last;
    root->left = nullptr;
    last = root;
}
```

然后是在`dicuss`中看到的迭代算法：

```c++
void flatten(TreeNode *root) {
    while (root) {
        if (root->left && root->right) {
            TreeNode* t = root->left;
            while (t->right)
                t = t->right;
            t->right = root->right;
        }

        if(root->left)
            root->right = root->left;
        root->left = NULL;
        root = root->right;
    }
}
```